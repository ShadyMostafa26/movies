class NowPlayingModel {
  int page;
  DateData dates;
 List<ResultData> results = [];

  NowPlayingModel.fromJson(Map<String, dynamic> json) {
    page = json[page];
    dates = json['dates'] != null? DateData.fromJson(json['dates']) : null;
    json['results'].forEach((element) {
      results.add(ResultData.fromJson(element));
    });
  }
}

class DateData{
 String maximum;
 String minimum;

 DateData.fromJson(Map<String, dynamic> json) {
  maximum = json['maximum'];
  minimum = json['minimum'];
 }
}

class ResultData{
  bool adult;
  String backdrop_path;
  int id;
  String original_language;
  String original_title;
  String title;
  String overview;
  dynamic popularity;
  dynamic vote_average;
  String poster_path;
  String release_date;

  ResultData.fromJson(Map<String,dynamic> json){
    adult = json['adult'];
    backdrop_path =  'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
    poster_path = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'];
    vote_average = json['vote_average'];
    title = json['title'];
    original_language = json['original_language'];
    original_title = json['original_title'];
    release_date = json['release_date'];
   // genreIds = json['genre_ids'].cast<int>();
  }
}