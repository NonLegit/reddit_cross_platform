//import 'package:flutter_code_style/analysis_options.yaml';
class OtherProfileData {
  //String? id;
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
  bool isFollowed = false;
  OtherProfileData(
      {
      //required this.id,
      required this.userName,
      required this.email,
      required this.profilePicture,
      required this.profileBackPicture,
      required this.description,
      required this.displayName,
      required this.createdAt,
      //required this.numOfDaysInReddit,
      required this.followersCount,
      required this.postKarma,
      required this.commentkarma,
      required this.isFollowed});

// {
//   "id": 10,
//   "userName": "Zeinab_maoawad",
//   "email": "user@email.com",
//   "profilePicture": "https://militaryhealthinstitute.org/wp-content/uploads/sites/37/2019/10/blank-person-icon-9.jpg",
//   "profileBackPicture": "https://preview.redd.it/vqqv5xbfezp91.jpg?width=4096&format=pjpg&auto=webp&s=54acda24af01e2de60e98603e3e29e8db381ebac",
//   "description": "I'm Student",
//   "createdAt": "2022-11-09T00:19:45.186+00:00",
//   "followersCount": 0,
//   "numOfDaysInReddit": 0,
//   "displayName": "Zeinab_maoawad",
//   "postKarma": 1,
//   "commentkarma": 1,
//   "isFollowed": true
// }
  OtherProfileData.fromJson(Map<String, dynamic> json) {
    // print(json['id'].runtimeType);
    // print(json['userName'].runtimeType);
    // print(json['email'].runtimeType);
    // print(json['profilePicture'].runtimeType);
    // print(json['profileBackground'].runtimeType);
    // print(json['followersCount'].runtimeType);
    // print(json['createdAt'].runtimeType);
    // print(json['postKarma'].runtimeType);
    // print(json['commentKarma'].runtimeType);
    // print(json['description'].runtimeType);
    // print(json['isFollowed'].runtimeType);
    //id = json['id'].toString();
    userName = json['userName'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    profileBackPicture = json['profileBackground'];
    description = json['description'];
    displayName = json['displayName'];
    followersCount = int.parse(json['followersCount'].toString());
    createdAt = json['createdAt'];
    postKarma = int.parse(json['postKarma'].toString());
    commentkarma = int.parse(json['commentKarma'].toString());
    isFollowed = json['isFollowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    data['profileBackPicture'] = this.profileBackPicture;
    data['description'] = this.description;
    data['toDayTime'] = this.createdAt;
    data['followersCount'] = this.followersCount;
    data['toDayTime'] = this.createdAt;
    //data['numOfDaysInReddit'] = this.numOfDaysInReddit;
    data['postKarma'] = this.postKarma;
    data['displayName'] = this.displayName;
    data['commentkarma'] = this.commentkarma;
    data['isFollowed'] = this.isFollowed;
    data['createdAt'] = this.createdAt;
    return data;
  }
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