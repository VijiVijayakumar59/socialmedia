class Posts {
  final String? username;
  final String? location;
  final String? description;
  final String? email;
  final List<String>? comments;
  final int? likes;
  final String? postId;
  final String? postImage;
  Posts.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          location: json['location']! as String,
          description: json['description']! as String,
          email: json['email']! as String,
          comments: json['comments']! as List<String>,
          likes: json['likes']! as int,
          postId: json['postId']! as String,
          postImage: json['postImage']! as String,
        );
  Posts({
    required this.username,
    this.location,
    required this.description,
    required this.email,
    this.comments,
    this.likes,
    required this.postId,
    required this.postImage,
  });
}
