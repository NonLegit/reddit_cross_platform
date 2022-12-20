// for back server
class userSubredditsResponse {
  String? icon;
  String? iId;
  String? subredditName;
  int? membersCount;
  String? description;

  userSubredditsResponse(
      {this.icon,
        this.iId,
        this.subredditName,
        this.membersCount,
        this.description});

  userSubredditsResponse.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    iId = json['_id'];
    subredditName = json['fixedName'];
    membersCount = json['membersCount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['_id'] = this.iId;
    data['fixedName'] = this.subredditName;
    data['membersCount'] = this.membersCount;
    data['description'] = this.description;
    return data;
  }
}
//////////////////////////////////////////////
// for jason
// class userSubredditsResponse {
//   String? icon;
//   String? id;
//   String? subredditName;
//   int? membersCount;
//   String? description;
//
//   userSubredditsResponse(
//       {this.icon,
//         this.id,
//         this.subredditName,
//         this.membersCount,
//         this.description});
//
//   userSubredditsResponse.fromJson(Map<String, dynamic> json) {
//     icon = json['icon'];
//     id = json['_id'];
//     subredditName = json['subredditName'];
//     membersCount = json['membersCount'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['icon'] = this.icon;
//     data['_id'] = this.id;
//     data['subredditName'] = this.subredditName;
//     data['membersCount'] = this.membersCount;
//     data['description'] = this.description;
//     return data;
//   }
// }