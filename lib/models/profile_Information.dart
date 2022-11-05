//import 'package:flutter_code_style/analysis_options.yaml';
class ProfileInformation {
  final int id;
  final String userName;
  final String email;
  final String profilePicture;
  final String description;
  final String displayName;
  final DateTime toDayTime;
  final int numOfDaysInReddit;
  final int followersCount;
  final int postKarma;
  final int commentkarma;
  final int awarderKarma;
  final int awardeekarma;
  ProfileInformation(
      {required this.id,
      required this.userName,
      required this.email,
      required this.profilePicture,
      required this.description,
      required this.displayName,
      required this.toDayTime,
      required this.numOfDaysInReddit,
      required this.followersCount,
      required this.postKarma,
      required this.commentkarma,
      required this.awardeekarma,
      required this.awarderKarma});
}

// {
// "contentvisibility": true,
// "canbeFollowed": true,
// "lastUpdatedPassword": "2022-10-22-06-12",
// "friendsCount": 0,
// "accountActivated": true,
// "gender": "male",
// "karma": 1
// }