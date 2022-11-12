//import 'package:flutter_code_style/analysis_options.yaml';
import '../../models/subreddit_about _rules.dart';

class SubredditData {
  int? id;
  String? name;
  String? subredditPicture;
  String? subredditBackPicture;
  String? description;
  String? subredditLink;
  int? numOfMembers;
  int? numOfOnlines;
  List<SubredditAboutRules>? rules;
  List<String>? moderators;
  bool? isJoined;
  SubredditData(
      { this.id,
      required this.name,
      required this.subredditPicture,
      required this.subredditBackPicture,
      required this.description,
      required this.subredditLink,
      required this.numOfMembers,
      required this.numOfOnlines,
      required this.isJoined,
      required this.rules,
      required this.moderators
      });

  SubredditData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subredditPicture = json['subredditPicture'];
    subredditBackPicture = json['subredditBackPicture'];
    description = json['description'];
    subredditLink = json['subredditLink'];
    numOfMembers = json['numOfMembers'];
    numOfOnlines = json['numOfOnlines'];
    isJoined = json['isJoined'];
    json['rules'].forEach((rule) {
      rules!.add(SubredditAboutRules(rule['title'], rule[description]));
    });
    // json['moderators'].forEach((moderator) {
    //   moderators!.add(moderator);
    // });
  }

  // SubredditData.fromJsonlist(Map<String, dynamic> json) {
  //   json[id].forEach((moderator) {
  //     moderators!.add(moderator['userName']);
  //   });
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['subredditPicture'] = this.subredditPicture;
    data['subredditBackPicture'] = this.subredditBackPicture;
    data['subredditLink'] = this.subredditLink;
    data['description'] = this.description;
    data['numOfMembers'] = this.numOfMembers;
    data['numOfOnlines'] = this.numOfOnlines;
    data['isJoined'] = this.isJoined;
    data['rules'] = this.rules;
  //  data['moderators'] = this.moderators;
    return data;
  }
}

// {
// "id": 10,
// "userName": "Zeinab_maoawad",
// "email": "user@email.com",
// "profilePicture":"https://militaryhealthinstitute.org/wp-content/uploads/sites/37/2019/10/blank-person-icon-9.jpg",
// "profileBackPicture":"https://preview.redd.it/vqqv5xbfezp91.jpg?width=4096&format=pjpg&auto=webp&s=54acda24af01e2de60e98603e3e29e8db381ebac",
// "description":"I'm Student",
// "toDayTime":"2022-11-09T00:19:45.186+00:00",
// "followersCount": 0,
// "numOfDaysInReddit": 0,
// "displayName": "Zeinab_maoawad",
// "postKarma": 1,
// "commentkarma": 1
// }