class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String profileUrl;
  final List<String> followers;
  final List<String> following;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.profileUrl,
    required this.followers,
    required this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      profileUrl: json['profileUrl'],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profileUrl': profileUrl,
      'followers': followers,
      'following': following,
    };
  }
  void addFollower(String userId) {
    if (!followers.contains(userId)) {
      followers.add(userId);
    }
  }

  void removeFollower(String userId) {
    followers.remove(userId);
  }

  void addFollowing(String userId) {
    if (!following.contains(userId)) {
      following.add(userId);
    }
  }

  void removeFollowing(String userId) {
    following.remove(userId);
  }
}
