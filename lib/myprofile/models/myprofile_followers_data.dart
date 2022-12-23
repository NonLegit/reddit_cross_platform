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
    // ===================================this function used to===========================================//
//=================to change json to model===========================//
  MyProfileFollowersData.fromJson(Map<String, dynamic> json) {
    profilePicture=json['profilePicture'];
    userName = json['userName'];
    displayName = json['displayName'];
    karama =int.parse(json['commentKarma'].toString())+int.parse(json['postKarma'].toString());
    isFollowed = json['isFollowed'];
  }
}
