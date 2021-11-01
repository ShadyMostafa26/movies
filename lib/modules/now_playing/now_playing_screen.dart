import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/video_screen/video_screen.dart';
import 'package:movies/shared/components/components.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlayingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.nowPlayingModel != null,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: PageIndicatorContainer(
              length: cubit.nowPlayingModel.results.length,
              indicatorSpace: 7,
              padding: EdgeInsets.all(5),
              indicatorSelectorColor: Theme.of(context).accentColor,
              shape: IndicatorShape.circle(size: 5),
              child: PageView.builder(
                itemCount: cubit.nowPlayingModel.results.length,
                reverse: false,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          cubit.nowPlayingModel.results[index].poster_path,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.8),
                              Colors.black.withOpacity(0.2),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.play_circle_outline,
                            size: 50,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {AppCubit.get(context).getMovieVideo(movieId: cubit.nowPlayingModel.results[index].id).then((value) {
                              navigateTo(context, VideoScreen(videoId: AppCubit.get(context).videoModel.results[0].key, title: cubit.nowPlayingModel.results[index].title),);
                            });
                          },
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 14,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            AppCubit.get(context)
                                .nowPlayingModel
                                .results[index]
                                .title,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
