class SimilarMoviesModel{
  List<SimilarMoviesResult> results = [];

  SimilarMoviesModel.fromJson(Map<String,dynamic> json){
    json['results'].forEach((element) {
      results.add(SimilarMoviesResult.fromJson(element));
    });
  }

}

class SimilarMoviesResult{
  int id;
  String original_title;
  String overview;
  String poster_path;
  String title;

  SimilarMoviesResult.fromJson(Map<String,dynamic> json){
    id = json['id'];
    original_title = json['original_title'];
    overview = json['overview'];
    title = json['title'];
    id = json['id'];
    poster_path = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
  }
}