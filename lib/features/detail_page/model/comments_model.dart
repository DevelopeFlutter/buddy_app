class Comment {
  final String id;
  final String text;
  final String parentPostId;
  final String userId;

  Comment({
    required this.id,
    required this.text, 
    required this.parentPostId,
    required this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      parentPostId: json['parent'],
      userId: json['userId'],
    );
  }
}
