class Post {
  String id;
  String userId;
  String title;
  String content;

  Post({
    this.id,
    this.userId,
    this.title,
    this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    id: id,
    userId: userId,
    content: content,
    title: title,
  };
}
