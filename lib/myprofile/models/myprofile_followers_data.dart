class MyProfileFollowersData {
  String? profilePicture;
  String? userName;
  String? displayName;
  bool? isFollowed;
  int? karama;
  MyProfileFollowersData({
    required this.profilePicture,
    required this.userName,
    required this.displayName,
    required this.karama,
    required this.isFollowed,
  });
  MyProfileFollowersData.fromJson(Map<String, dynamic> json) {
    profilePicture=json['profilePicture'];
    userName = json['userName'];
    displayName = json['displayName'];
    karama = json['ownerType'];
    isFollowed = json['isFollowed'];
  }
}
