import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/layout/home_layout.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';
import 'package:movies/shared/helpers/constants.dart';
import 'package:movies/shared/helpers/helpers.dart';
import 'package:movies/shared/network/remote/dio_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getNowPlaying()..getGenres()..getTrendingActors()..getTrendingMovies(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies',
            theme: ThemeData(
              primarySwatch: Constants.color,
              accentColor: Color.fromRGBO(245, 195, 15, 1),
              fontFamily: 'Poppins',
              textTheme: TextTheme(
                headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              scaffoldBackgroundColor: Constants.color,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light
                ),
              ),
            ),
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}


