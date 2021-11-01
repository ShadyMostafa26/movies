import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/genres/genres_list.dart';
import 'package:movies/modules/now_playing/now_playing_screen.dart';
import 'package:movies/modules/serach/search_screen.dart';
import 'package:movies/modules/trending_actors/trending_actors_screen.dart';
import 'package:movies/modules/trending_movies/trending_movies_screen.dart';
import 'package:movies/shared/components/components.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Movies'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (AppCubit.get(context).genresModel != null) ? ListView(
              physics: BouncingScrollPhysics(),
              children: [
                NowPlayingScreen(),
                GenresList(),
                SizedBox(height: 15,),
                TrendingActors(),
                TrendingMovies(),
              ],
            ) : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
