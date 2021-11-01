import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/movie_details_model.dart';
import 'package:movies/models/similar_movies_model.dart';
import 'package:movies/modules/video_screen/video_screen.dart';
import 'package:movies/shared/components/components.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).movieDetailsModel;
        return Scaffold(
          body: SliverFab(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floatingWidget: FloatingActionButton(
              child: Icon(Icons.play_arrow, size: 40),
              onPressed: () {
                AppCubit.get(context).getMovieVideo(movieId: movieId).then((value) {
                  navigateTo(context, VideoScreen(videoId: AppCubit.get(context).videoModel.results[0].key,title: model.original_title,),);
                });
              },
            ),
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.only(right: 75.0),
                    child: Text(
                      model.original_title,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  background: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          model.backdrop_path,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.3),
                              Theme.of(context).primaryColor.withOpacity(0.1),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rate: ',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              Text(
                                '${model.vote_average}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Overview',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 13),
                          Text(
                            model.overview,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'BUDGET',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    '${model.budget} \$',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'DURATION',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    '${model.runtime} min',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'RELEASE DATE',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    '${model.release_date}',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Genres',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: MediaQuery.of(context).size.height * .05,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => buildGenresItem(
                                  AppCubit.get(context)
                                      .movieDetailsModel
                                      .genres[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 7,
                              ),
                              itemCount: AppCubit.get(context)
                                  .movieDetailsModel
                                  .genres
                                  .length,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Similar Movies',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 5),
                          (AppCubit.get(context).similarMoviesModel != null) ? Container(
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        buildSimilarMovies(AppCubit.get(context).similarMoviesModel.results[index], context),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 5),
                                    itemCount: AppCubit.get(context).similarMoviesModel.results.length),
                                ) : Center(child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildGenresItem(GenresDataList model) => Container(
        padding: EdgeInsets.all(7),
        child: Text(
          '${model.name}',
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
        ),
      );

  Widget buildSimilarMovies(SimilarMoviesResult model, context) => Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network('${model.poster_path}'),
            ),
            SizedBox(height: 5),
            Container(
              width: 120,
              child: Text(
                '${model.title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
