import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/modules/genres/movies_list.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';

class GenresList extends StatefulWidget {
  @override
  _GenresListState createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: AppCubit.get(context).genresModel.genres.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.42,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              bottom: TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: AppCubit.get(context).genresModel.genres.map((e) {
                  return Text(e.name);
                }).toList(),
              ),
            ),
            body: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: AppCubit.get(context).genresModel.genres.map((e) {
                return MoviesList(e.id);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
