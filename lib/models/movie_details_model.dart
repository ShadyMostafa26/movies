class MovieDetailsModel{
  String backdrop_path;
  int budget;
  String original_title;
  String overview;
  String release_date;
  dynamic popularity;
  int runtime;
  dynamic vote_average;
  List<GenresDataList> genres = [];


  MovieDetailsModel.fromJson(Map<String,dynamic> json){
    backdrop_path =  'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
    budget = json['budget'];
    original_title = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    runtime = json['runtime'];
    release_date = json['release_date'];
    vote_average = json['vote_average'];

    json['genres'].forEach((element) {
      genres.add(GenresDataList.fromJson(element));
    });
  }
}

class GenresDataList{
  int id;
  String name;

  GenresDataList.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}