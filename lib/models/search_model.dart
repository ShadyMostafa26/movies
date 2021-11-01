class SearchModel{
  List<SearchResults> results = [];
  SearchModel.fromJson(Map<String,dynamic> json){
    json['results'].forEach((element) {
      results.add(SearchResults.fromJson(element));
    });
  }
}

class SearchResults{
  int id;
  String original_title;
  String overview;
  String poster_path;
  String backdrop_path;
  String release_date;
  dynamic vote_average;

  SearchResults.fromJson(Map<String,dynamic> json){
    id = json['id'];
    original_title = json['original_title'];
    overview = json['overview'];
    release_date = json['release_date'];
    vote_average = json['vote_average'];
    backdrop_path =  'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
    poster_path = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
  }
}