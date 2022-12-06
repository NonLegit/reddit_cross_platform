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
    // id = json['_id'];
    // name = json['fixedName'];
    // displayName = json['name'];
    // subredditPicture = json['icon'];
    // subredditBackPicture = json['backgroundImage'];
    // description = json['description'];
    // subredditLink = json['subredditLink'];
    // numOfMembers = int.parse(json['membersCount'].toString());
    // numOfOnlines = int.parse(json['numOfOnlines'].toString());
    // isJoined = (json['isJoined']);
    // final List<SubredditAboutRules> loadedrule = [];
    // json['rules'].forEach((rule) {
    //   loadedrule.add(SubredditAboutRules(rule['title'], rule['description']));
    // });
    // rules = loadedrule;
    // final List<String> loadedmodrator = [];
    // json['moderators'].forEach((moderator) {
    //   loadedmodrator.add(moderator["userName"]);
    print(json);
    id = json['_id'];
    name = json['fixedName'];
    displayName = json['name'];
    subredditPicture =
    'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=2iWzRT-vma8AX-PiMqC&_nc_ht=scontent.fcai22-1.fna&oh=00_AfBEvYZoMur64QVXcxLFJVnuJaaLWR183dRaZG6nN2Jdhw&oe=636EEF08'; //json['icon'];
    subredditBackPicture =
    'https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=2iWzRT-vma8AX-PiMqC&_nc_ht=scontent.fcai22-1.fna&oh=00_AfBEvYZoMur64QVXcxLFJVnuJaaLWR183dRaZG6nN2Jdhw&oe=636EEF08'; //json['backgroundImage'];
    description = json['description'];
    subredditLink = json['subredditLink'];
    numOfMembers = 0; //int.parse(json['membersCount'].toString());
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

//   {
// 	"id": 10,
// 	"name": "Cooking",
// 	"displayName": "Cooking Good",
// 	"subredditPicture": "https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg",
// 	"subredditBackPicture": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fassets.marthastewart.com%2Fstyles%2Fwmax-750%2Fd30%2Feasy-basic-pancakes-horiz-1022%2Feasy-basic-pancakes-horiz-1022_0.jpg%3Fitok%3DXQMZkp_j",
// 	"description": "Iam Chef",
// 	"subredditLink": "https://previews.123rf.com/images/seamartini/seamartini1609/seamartini160900764/64950290-chef-toque-vector-sketch-icon-cook-cap-kitchen-cooking-hat-emblem-for-restaurant-design-element-bake.jpg",
// 	"numOfMembers": 10398,
// 	"numOfOnlines": 1789,
// 	"rules": [{
// 			"title": "no codeing",
// 			"description": "i hate coding"
// 		},
// 		{
// 			"title": "no codeing",
// 			"description": "i hate coding"
// 		},
// 		{
// 			"title": "no codeing",
// 			"description": "i hate coding"
// 		}
// 	],
// 	"moderators": [{
// 			"userName": "Ali"
// 		},
// 		{
// 			"userName": "omer"
// 		},
// 		{
// 			"userName": "zeinab"
// 		},
// 		{
// 			"userName": "mazen"
// 		}
// 	],
// 	"isJoined": true
// }
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
