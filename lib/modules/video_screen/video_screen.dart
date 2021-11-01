import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  final String videoId;
  final String title;

  const VideoScreen({this.videoId,this.title});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: YoutubePlayer(
              controller:YoutubePlayerController(
                  initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
