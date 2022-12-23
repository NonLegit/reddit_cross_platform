//import 'package:flutter_code_style/analysis_options.yaml';
import '../../models/subreddit_about _rules.dart';

class SubredditData {
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
  SubredditData(
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
      required this.moderators});
  SubredditData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['fixedName'];
    displayName = json['name'];
    subredditPicture = json['icon'];
    subredditBackPicture = json['backgroundImage'];
    description = json['description'];
    subredditLink = json['subredditLink'];
    numOfMembers = int.parse(json['membersCount'].toString());
    numOfOnlines = 0; //int.parse(json['numOfOnlines'].toString());
    isJoined = (json['isJoined']);
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

}
