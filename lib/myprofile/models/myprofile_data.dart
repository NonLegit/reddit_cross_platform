class MyProfileData {
  String? userName;
  String? email;
  String? profilePicture;
  String? profileBackPicture;
  String? description;
  String? displayName;
  String? createdAt;
  int? followersCount;
  int? postKarma;
  int? commentkarma;
  MyProfileData(
      {
      required this.userName,
      required this.email,
      required this.profilePicture,
      required this.profileBackPicture,
      required this.description,
      required this.displayName,
      required this.createdAt,
      required this.followersCount,
      required this.postKarma,
      required this.commentkarma});
  // ===================================this function used to===========================================//
//=================to change json to model===========================//
  MyProfileData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    profileBackPicture = json['profileBackground'];
    description = json['description'];
    displayName =json['displayName']??'';
    followersCount = int.parse(json['followersCount'].toString());
    createdAt = json['createdAt'];
    postKarma = int.parse(json['postKarma'].toString());
    commentkarma = int.parse(json['commentKarma'].toString());
  }
}
