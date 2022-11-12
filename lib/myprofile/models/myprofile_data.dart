//import 'package:flutter_code_style/analysis_options.yaml';
class MyProfileData {
  int? id;
  String? userName;
  String? email;
  String? profilePicture;
  String? profileBackPicture;
  String? description;
  String? displayName;
  // DateTime? toDayTime;
  String? createdAt;
  int? numOfDaysInReddit;
  int? followersCount;
  int? postKarma;
  int? commentkarma;
  MyProfileData(
      {required this.id,
      required this.userName,
      required this.email,
      required this.profilePicture,
      required this.profileBackPicture,
      required this.description,
      required this.displayName,
      required this.createdAt,
      required this.numOfDaysInReddit,
      required this.followersCount,
      required this.postKarma,
      required this.commentkarma});

  MyProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    profileBackPicture = json['profileBackPicture'];
    description = json['description'];
    displayName = json['displayName'];
    followersCount = json['followersCount'];
    createdAt = json['createdAt'];
    numOfDaysInReddit = json['numOfDaysInReddit'];
    postKarma = json['postKarma'];
    displayName = json['displayName'];
    commentkarma = json['commentkarma'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    data['profileBackPicture'] = this.profileBackPicture;
    data['description'] = this.description;
    data['followersCount'] = this.followersCount;
    data['createdAt'] = this.createdAt;
    data['numOfDaysInReddit'] = this.numOfDaysInReddit;
    data['postKarma'] = this.postKarma;
    data['displayName'] = this.displayName;
    data['commentkarma'] = this.commentkarma;
    return data;
  }
}

