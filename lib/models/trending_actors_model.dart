class TrendingActors {
  int page;
  List<ResultsData> results = [];

  TrendingActors.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    json['results'].forEach((element) {
      results.add(ResultsData.fromJson(element));
    });
  }
}

class ResultsData {
  String name;
  int id;
  String profile_path;
  //List<KnownForData> known_for = [];

  ResultsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    profile_path = 'https://image.tmdb.org/t/p/original/${json['profile_path']}';

    /*json['known_for'].forEach((element) {
      known_for.add(KnownForData.fromJson(element));
    });*/
  }
}

/*class KnownForData {
  String backdrop_path;
  int id;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  String title;
  dynamic vote_average;

  KnownForData.fromJson(Map<String, dynamic> json) {
    backdrop_path = 'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
    id = json['id'];
    original_title = json['original_title'];
    overview = json['overview'];
    release_date = json['release_date'];
    title = json['title'];
    vote_average = json['vote_average'];
    poster_path = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
  }
}*/
