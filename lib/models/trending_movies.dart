class TrendingMovies{
  int page;
  List<ResultsData> results = [];

  TrendingMovies.fromJson(Map<String,dynamic> json){
    page = json['page'];
    json['results'].forEach((element) {
      results.add(ResultsData.fromJson(element));
    });
  }
}

class ResultsData{
  dynamic vote_average;
  String title;
  String overview;
  String poster_path;
  String backdrop_path;
  String release_date;
  String original_title;
  int id;

  ResultsData.fromJson(Map<String,dynamic> json){
    vote_average = json['vote_average'];
    title = json['title'];
    overview = json['overview'];
    release_date = json['release_date'];
    original_title = json['original_title'];
    id = json['id'];
    poster_path = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
    backdrop_path = 'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';

  }
}