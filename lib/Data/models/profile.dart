class Profile {
  final String? email;
  final String? id;
  final String? image;
  final String? name;
  final int? phone;
  final String? place;
  final String? profession;
  final int? posts;
  final int? followers;
  final int? following;
  Profile.fromJson(Map<String, Object?> json)
      : this(
          email: json['email']! as String,
          id: json['id']! as String,
          image: json['image']! as String,
          name: json['name']! as String,
          phone: json['phone']! as int,
          place: json['place']! as String,
          profession: json['profession']! as String,
          posts: json['posts']! as int,
          followers: json['followers']! as int,
          following: json['following']! as int,
        );
  Profile({
    this.email,
    this.id,
    required this.image,
    required this.name,
    required this.phone,
    required this.place,
    required this.profession,
    this.followers,
    this.posts,
    this.following,
  });
}
