import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/genres_model.dart';
import 'package:movies/models/movie_details_model.dart';
import 'package:movies/models/now_playing_model.dart';
import 'package:movies/models/search_model.dart';
import 'package:movies/models/similar_movies_model.dart';
import 'package:movies/models/trending_actors_model.dart';
import 'package:movies/models/trending_movies.dart';
import 'package:movies/models/video_model.dart';
import 'package:movies/shared/cubit/states.dart';
import 'package:movies/shared/helpers/constants.dart';
import 'package:movies/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  NowPlayingModel nowPlayingModel;
  void getNowPlaying() {
    emit(GetNowPlayingLoadingState());
    DioHelper.getData(
      path: 'movie/now_playing',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      nowPlayingModel = NowPlayingModel.fromJson(value.data);
      emit(GetNowPlayingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNowPlayingErrorState());
    });
  }

  GenresModel genresModel;
  void getGenres() {
    emit(GetGenresLoadingState());
    DioHelper.getData(
      path: 'genre/movie/list',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      genresModel = GenresModel.fromJson(value.data);
      emit(GetGenresSuccessState());
    }).catchError((error) {
      emit(GetGenresErrorState());
    });
  }

  NowPlayingModel genre;
  void getMovieByGenre({int genreId}) {
    emit(GetMovieByGenreLoadingState());
    DioHelper.getData(
      path: 'discover/movie',
      query: {
        'api_key': Constants.apiKey,
        'with_genres': genreId,
      },
    ).then((value) {
      genre = NowPlayingModel.fromJson(value.data);
      emit(GetMovieByGenreSuccessState());
    }).catchError((error) {
      emit(GetMovieByGenreErrorState());
    });
  }

  TrendingActors trendingActors;
  void getTrendingActors() {
    emit(GetTrendingActorsLoadingState());
    DioHelper.getData(
      path: 'trending/person/week',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      trendingActors = TrendingActors.fromJson(value.data);
      emit(GetTrendingActorsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTrendingActorsErrorState());
    });
  }

  TrendingMovies trendingMovie;
  void getTrendingMovies() {
    emit(GetTrendingMoviesLoadingState());
    DioHelper.getData(
      path: 'trending/movie/week',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      trendingMovie = TrendingMovies.fromJson(value.data);
      emit(GetTrendingMoviesSuccessState());
    }).catchError((error) {
      emit(GetTrendingMoviesErrorState());
    });
  }

  MovieDetailsModel movieDetailsModel;
  Future<void> getMovieDetails(int movieId) async {
    emit(GetMovieDetailsLoadingState());
    await DioHelper.getData(
      path: 'movie/$movieId',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      movieDetailsModel = MovieDetailsModel.fromJson(value.data);
      emit(GetMovieDetailsSuccessState());
    }).catchError((error) {
      emit(GetMovieDetailsErrorState());
    });
  }


  SimilarMoviesModel similarMoviesModel;
  void getSimilarMovies({int movieId}) {
    DioHelper.getData(
      path: 'movie/$movieId/similar',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      similarMoviesModel = SimilarMoviesModel.fromJson(value.data);
      emit(GetSimilarMoviesSuccessState());
    }).catchError((error) {
      emit(GetSimilarMoviesErrorState());
    });
  }

  VideoModel videoModel;
  Future<void> getMovieVideo({int movieId}) async {
    await DioHelper.getData(
      path: 'movie/$movieId/videos',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      videoModel = VideoModel.fromJson(value.data);
      emit(GetMovieVideoSuccessState());
    }).catchError((error) {
      emit(GetMovieVideoErrorState());
    });
  }

  SearchModel searchModel;
  void searchMovie({String query}) {
    emit(SearchMovieLoadingState());
    DioHelper.getData(
      path: 'search/movie',
      query: {
        'api_key': Constants.apiKey,
        'query': query,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchMovieSuccessState());
    }).catchError((error){
      emit(SearchMovieErrorState());
    });
  }
}
