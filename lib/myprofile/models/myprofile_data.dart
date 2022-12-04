//import 'package:flutter_code_style/analysis_options.yaml';
// import 'dart:ffi';

class MyProfileData {
  String? id;
  String? userName;
  String? email;
  String? profilePicture;
  String? profileBackPicture;
  String? description;
  String? displayName;
  // DateTime? toDayTime;
  String? createdAt;
  //int? numOfDaysInReddit;
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
      // required this.numOfDaysInReddit,
      required this.followersCount,
      required this.postKarma,
      required this.commentkarma});

  MyProfileData.fromJson(Map<String, dynamic> json) {
    // print(json['id'].runtimeType);
    // print(json['userName'].runtimeType);
    // print(json['email'].runtimeType);
    // print(json['profilePicture'].runtimeType);
    print(json['profileBackground'].runtimeType);
    print(json['followersCount'].runtimeType);
    print(json['createdAt'].runtimeType);
    print(json['postKarma'].runtimeType);
    print(json['commentKarma'].runtimeType);
    print(json['description'].runtimeType);
    print('heeee;ssssssssssssssssssssss');
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    profileBackPicture = json['profileBackground'];
    description = json['description'];
    displayName = json['userName']; //json['displayName'];
    followersCount = int.parse(json['followersCount'].toString());
    createdAt = json['createdAt'];
    // numOfDaysInReddit = int.parse(json['numOfDaysInReddit'].toString());
    postKarma = int.parse(json['postKarma'].toString());
    // displayName = json['displayName'];
    commentkarma = int.parse(json['commentKarma'].toString());
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
    // data['numOfDaysInReddit'] = this.numOfDaysInReddit;
    data['postKarma'] = this.postKarma;
    data['displayName'] = this.displayName;
    data['commentkarma'] = this.commentkarma;
    return data;
  }
}
