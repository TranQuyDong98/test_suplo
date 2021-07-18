class Comment {
  String id;
  String content;

  Comment({this.id, this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
    );
  }
}
