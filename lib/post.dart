class Posts {
  late int? userId;
  late int? id;
  late String? title;
  late String? body;
  Posts({this.userId,this.id,this.title,this.body});

  factory Posts.fromJson(Map json) {
    return Posts(
      userId:json["userId"],
      id:json["id"],
      title:json["title"],
      body:json["body"],
    );
  }


}