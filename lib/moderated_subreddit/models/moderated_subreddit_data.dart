//import 'package:flutter_code_style/analysis_options.yaml';
import '../../models/subreddit_about _rules.dart';

class ModeratedSubredditData {
  String? id;
  String? displayName;
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
  ModeratedSubredditData(
      {required this.id,
      required this.name,
      required this.displayName,
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

 ModeratedSubredditData.fromJson(Map<String, dynamic> json) {
 id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    subredditPicture = json['icon'];
    subredditBackPicture = json['backgroundImage'];
    description = json['description'];
    subredditLink = json['subredditLink'];
    numOfMembers = int.parse(json['numOfMembers'].toString());
    numOfOnlines = int.parse(json['numOfOnlines'].toString());
    isJoined =(json['isJoined']);
   final List<SubredditAboutRules> loadedrule = [];
    json['rules'].forEach((rule) {
      loadedrule.add(SubredditAboutRules(rule['title'], rule['description']));
    });
    rules = loadedrule;
    final List<String> loadedmodrator = [];
    json['moderators'].forEach((moderator) {
      loadedmodrator.add(moderator["userName"]);
    });
    moderators = loadedmodrator;
  }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['subredditPicture'] = this.subredditPicture;
  //   data['subredditBackPicture'] = this.subredditBackPicture;
  //   data['subredditLink'] = this.subredditLink;
  //   data['description'] = this.description;
  //   data['numOfMembers'] = this.numOfMembers;
  //   data['numOfOnlines'] = this.numOfOnlines;
  //   data['isJoined'] = this.isJoined;
  //   data['rules'] = this.rules;
  // //  data['moderators'] = this.moderators;
  //   return data;
  // }
}