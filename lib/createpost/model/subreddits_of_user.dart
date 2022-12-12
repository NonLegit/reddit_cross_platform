class userSubredditsResponse {
  String? icon;
  String? id;
  String? subredditName;
  int? membersCount;
  String? description;

  userSubredditsResponse(
      {this.icon,
      this.id,
      this.subredditName,
      this.membersCount,
      this.description});

  userSubredditsResponse.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    id = json['_id'];
    subredditName = json['fixedName'];
    membersCount = json['membersCount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['_id'] = this.id;
    data['fixedName'] = this.subredditName;
    data['membersCount'] = this.membersCount;
    data['description'] = this.description;
    return data;
  }
}
