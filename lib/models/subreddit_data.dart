import './subreddit_about _rules.dart';

class SubredditData {
  //String? id;
  String? displayName;
  String? name;
  String? subredditPicture;
  String? subredditBackPicture;
  String? subredditLink;
  String? description;
  int? numOfMembers;
  int? numOfOnlines;
  String? createdAt;
  List<SubredditAboutRules>? rules;
  List<String>? moderators;
  bool? isJoined;
  String? theme;
  SubredditData(
      {
      //required this.id,
      required this.name,
      required this.displayName,
      required this.subredditPicture,
      required this.subredditBackPicture,
      required this.description,
      required this.numOfMembers,
      required this.subredditLink,
      required this.numOfOnlines,
      required this.isJoined,
      required this.rules,
      required this.moderators,
      required this.createdAt,
      required this.theme});
  SubredditData.fromJson(Map<String, dynamic> json) {
    print(
        '=========================in subreddit data====================================');
    // print(json);
    // print(json['_id'].runtimeType);
    // print(json['fixedName'].runtimeType);
    // print(json['name'].runtimeType);
    // print(json['description'].runtimeType);
    // print(json['isJoined'].runtimeType);
    // print(json['rules'].runtimeType);
    // print(json['moderators'].runtimeType);
    // print(json['icon'].runtimeType);
    // print(json['rules'].runtimeType);
    // print(json['membersCount'].runtimeType);
    //id = json['_id'];
    name = json['fixedName'];
    displayName = json['name'];
    subredditPicture = json['icon'];
    subredditBackPicture = json['backgroundImage'];
    description = json['description'];
    numOfMembers = int.parse(json['membersCount'].toString());
    numOfOnlines = 0; //int.parse(json['numOfOnlines'].toString());
    subredditLink = (json['subredditLink'] != null)
        ? json['subredditLink']
        : 'https://www.reddit.com/r/${name.toString()}?utm_medium=android_app&utm_source=share';
    isJoined = (json['isJoined']) ?? false;
    final List<SubredditAboutRules> loadedrule = [];
    json['rules'].forEach((rule) {
      loadedrule.add(SubredditAboutRules(rule['title'],
          (rule['description'] != null) ? rule['description'] : ''));
    });
    rules = loadedrule;
    final List<String> loadedmodrator = [];
    json['moderators'].forEach((moderator) {
      print(json['moderators']);
      loadedmodrator.add(moderator['user']['userName']);
    });
    moderators = loadedmodrator;
    createdAt = json['createdAt'];
    theme = json['theme'];
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
  //   //  data['moderators'] = this.moderators;
  //   return data;
  // }
}
