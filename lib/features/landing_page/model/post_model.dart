class Post {
  final String id;
  final String title;
  final String text;
  final String image;
  final String userId;
  final String  createdAt;
  final List<String> likes;

  Post({
    required this.id,
    required this.title,
    required this.text,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      image: json['image'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      likes: List<String>.from(json['likes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'image': image,
      'userId': userId,
      'createdAt': createdAt,
      'likes': likes,
    };
  }
}
