import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/trending_actors_model.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';


class TrendingActors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trending Actors',style: TextStyle(color: Colors.white.withOpacity(.5),fontSize: 25),),
            SizedBox(height: 5),
           AppCubit.get(context).trendingActors != null? Container(
              height: MediaQuery.of(context).size.height * 0.18,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => buildTrendingActors(AppCubit.get(context).trendingActors.results[index]),
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: AppCubit.get(context).trendingActors.results.length,
              ),
            ) : Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }

  Widget buildTrendingActors(ResultsData model) => Column(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
            '${model.profile_path}'
        ),
      ),
      Text('${model.name}',style: TextStyle(color: Colors.white),),
    ],
  );
}
