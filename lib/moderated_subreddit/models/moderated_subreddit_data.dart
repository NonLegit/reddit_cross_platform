//import 'package:flutter_code_style/analysis_options.yaml';
import '../../models/subreddit_about _rules.dart';

class ModeratedSubredditData {
  //String? id;
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
      {
        //required this.id,
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

  ModeratedSubredditData.fromJson(Map<String, dynamic> json) {
    name = json['fixedName'];
    displayName = json['name'];
    subredditPicture =json['icon'];
    subredditBackPicture = json['backgroundImage'];
    description = json['description'];
    subredditLink = (json['subredditLink'] != null)
        ? json['subredditLink']
        : 'https://www.reddit.com/r/${ name.toString()}?utm_medium=android_app&utm_source=share';
    numOfMembers =int.parse(json['membersCount'].toString());
    numOfOnlines = 0; //int.parse(json['numOfOnlines'].toString());
    isJoined = (json['isJoined']);
    final List<SubredditAboutRules> loadedrule = [];
    json['rules'].forEach((rule) {
      loadedrule.add(SubredditAboutRules(rule['title'],
          (rule['description'] != null) ? rule['description'] : ''));
    });
    rules = loadedrule;
    final List<String> loadedmodrator = [];
    json['moderators'].forEach((moderator) {
      loadedmodrator.add(moderator["userName"]);
    });
    moderators = loadedmodrator;
  }
}
