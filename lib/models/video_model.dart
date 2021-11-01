class VideoModel{
  int id;
  List<VideoResults> results = [];

  VideoModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    json['results'].forEach((element) {
      results.add(VideoResults.fromJson(element));
    });
  }
}

class VideoResults{
  String name;
  String key;
  String id;

  VideoResults.fromJson(Map<String,dynamic> json){
    name = json['name'];
    key = json['key'];
    id = json['id'];
  }
}