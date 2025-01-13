class UserModel {
  final String? username;
  final String? userId;
  final String? email;
  final String? photoUrl;
  final String? bio;
  final String? location;
  final String? website;
  final int? followers;
  final int? following;
  final String? socialMedia;
  final String? enterprise;

  UserModel({
    this.username,
    this.userId,
    this.email,
    this.photoUrl,
    this.bio,
    this.location,
    this.website,
    this.followers,
    this.following,
    this.socialMedia,
    this.enterprise,
  });

  factory UserModel.empty() {
    return UserModel(
      username: '',
      userId: '',
      email: '',
      photoUrl: '',
      bio: '',
      location: '',
      website: '',
      followers: 0,
      following: 0,
      socialMedia: '',
      enterprise: '',
    );
  }
}
