import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/search_model.dart';
import 'package:movies/shared/cubit/cubit.dart';
import 'package:movies/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.teal,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            onFieldSubmitted: (value) {
                              AppCubit.get(context).searchMovie(query: value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Search a movie...'
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(state is SearchMovieLoadingState)
                      SizedBox(height:20),
                    if(state is SearchMovieLoadingState)
                      LinearProgressIndicator(backgroundColor: Colors.black,),
                    if(state is SearchMovieLoadingState)
                      SizedBox(height:15),

                    SizedBox(height: 20),

                   ConditionalBuilder(
                     condition: AppCubit.get(context).searchModel != null,
                     builder: (context) =>  ListView.separated(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context, index) => searchItem(AppCubit.get(context).searchModel.results[index]),
                       separatorBuilder: (context, index) => SizedBox(height: 10),
                       itemCount: AppCubit.get(context).searchModel.results.length,
                     ),
                     fallback: (context) => Container(),
                   ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget searchItem(SearchResults model,) =>  InkWell(
    onTap: () {
      //navigateTo(context, SearchDetail(model: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 140,
                child: Image.network(
                  '${model.poster_path}',
                  fit: BoxFit.fill,
                ),),
              SizedBox(width: 8,),
              Expanded(child: Text(model.original_title),)
            ],
          )
        ],
      ),
    ),
  );
}
