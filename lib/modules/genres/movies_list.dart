import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/modules/movie_details/movie_details_screen.dart';
import 'package:movies/shared/components/components.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';

class MoviesList extends StatefulWidget {
  int genreId;
  MoviesList(this.genreId);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  @override
  void initState() {
    super.initState();
   AppCubit.get(context).getMovieByGenre(genreId: widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppCubit.get(context).genre != null? Container(
          height: MediaQuery.of(context).size.height * 40 - 48,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppCubit.get(context).genre.results.length,
            itemExtent: 120,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child:  GestureDetector(
                  onTap: (){
                    AppCubit.get(context).getMovieDetails(AppCubit.get(context).genre.results[index].id).then((value) {
                      AppCubit.get(context).getSimilarMovies(movieId:AppCubit.get(context).genre.results[index].id );
                      navigateTo(context, MovieDetailsScreen(movieId: AppCubit.get(context).genre.results[index].id,));
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Image.network(
                          AppCubit.get(context).genre.results[index].poster_path,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            AppCubit.get(context).genre.results[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text('${AppCubit.get(context).genre.results[index].vote_average}',style: TextStyle(color: Colors.white),),
                            RatingBar(
                              allowHalfRating: true,
                              ignoreGestures: true,
                              initialRating: AppCubit.get(context).genre.results[index].vote_average/2,
                              itemCount: 5,
                              itemSize: 15,
                              maxRating: 5,
                              glowColor: Colors.yellow,
                              unratedColor: Colors.grey,
                              onRatingUpdate: (double value) {  },
                              ratingWidget: RatingWidget(
                                full: Icon(Icons.star,color: Colors.yellow,),
                                empty: Icon(Icons.star,color: Colors.grey,),
                                half: Icon(Icons.star_half,color: Colors.yellow,),
                              ),

                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
