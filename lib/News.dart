import 'dart:convert';

List<News> newsFromJson(String str) => List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    this.id,
    this.name,
    this.image,
  });

  int id;
  String name;
  String image;

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    name: json["name"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image == null ? null : image,
  };
}
