class Posts {
  final String? postedBy;
  final String? location;
  final String? description;

  final String? postId;
  final String? postImage;
  final List<String>? likes;
  final List<String>? comments;
  //postid,postedby,caption,likes[],comments[],createdat
  Posts.fromJson(Map<String, Object?> json)
      : this(
          postedBy: json['postedBy']! as String,
          location: json['location']! as String,
          description: json['description']! as String,
          comments: json['comments']! as List<String>,
          postId: json['postId']! as String,
          postImage: json['postImage']! as String,
          likes: json['likes']! as List<String>,
        );
  Posts({
    this.postId,
    this.comments,
    this.location,
    required this.description,
    required this.postedBy,
    required this.postImage,
    this.likes,
  });
}
