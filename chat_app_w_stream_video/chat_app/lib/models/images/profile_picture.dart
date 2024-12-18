class ProfilePicture {
  final String image;

  ProfilePicture({required this.image});

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(image: json['image']);
  }
}
