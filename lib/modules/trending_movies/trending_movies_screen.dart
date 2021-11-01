import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/models/trending_movies.dart';
import 'package:movies/modules/movie_details/movie_details_screen.dart';
import 'package:movies/shared/components/components.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trending Movies',
              style: TextStyle(color: Colors.white.withOpacity(.5), fontSize: 25),
            ),
            SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => buildTrendingMovies(AppCubit.get(context).trendingMovie.results[index],context),
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: AppCubit.get(context).trendingMovie.results.length,
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildTrendingMovies(ResultsData model,context) => GestureDetector(
    onTap: (){
      AppCubit.get(context).getMovieDetails(model.id).then((value) {
        AppCubit.get(context).getSimilarMovies(movieId: model.id );
        navigateTo(context, MovieDetailsScreen(movieId: model.id,));
      });
    },
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Image.network(
                  '${model.poster_path}',
               // fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${model.title}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('${model.vote_average/2}',style: TextStyle(color: Colors.white),),
                RatingBar(
                  allowHalfRating: true,
                  ignoreGestures: true,
                  initialRating: model.vote_average/2,
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
          ],
        ),
  );
}
