class Profile {
  final String? email;
  final String? id;
  final String? image;
  final String? name;
  final String? phone;
  final String? location;
  final String? profession;
  final List<String>? posts;
  final List<String>? followers;
  final List<String>? following;
  Profile.fromJson(Map<String, Object?> json)
      : this(
          email: json['email']! as String,
          id: json['id']! as String,
          image: json['image']! as String,
          name: json['name']! as String,
          phone: json['phone']! as String,
          location: json['location']! as String,
          profession: json['profession']! as String,
          posts: json['posts']! as List<String>,
          followers: json['followers']! as List<String>,
          following: json['following']! as List<String>,
        );
  Profile({
    this.email,
    this.id,
    this.image,
    required this.name,
    required this.phone,
    required this.location,
    required this.profession,
    this.followers,
    this.posts,
    this.following,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image": image,
        "email": email,
        "phone": phone,
        "location": location,
        "posts": posts,
        "profession": profession,
        "followers": followers,
        "following": following,
      };
}
