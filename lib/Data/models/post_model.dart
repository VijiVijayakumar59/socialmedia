class Posts {
  final String? username;
  final String? location;
  final String? description;
  final String? email;
  final int? likes;
  final String? postId;
  final String? postImage;
  final List<String>? likedBy;
  Posts.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          location: json['location']! as String,
          description: json['description']! as String,
          email: json['email']! as String,
          likes: json['likes']! as int,
          postId: json['postId']! as String,
          postImage: json['postImage']! as String,
          likedBy: json['likedBy']! as List<String>,
        );
  Posts({
    required this.username,
    this.location,
    required this.description,
    required this.email,
    this.likes,
    required this.postId,
    required this.postImage,
    this.likedBy,
  });
}
