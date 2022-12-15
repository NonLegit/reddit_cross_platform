class Moderators {
  String? sId;
  String? userName;
  String? joiningDate;
  String? profilePicture;
  ModeratorPermissions? moderatorPermissions;

  Moderators(
      {this.sId,
      this.userName,
      this.joiningDate,
      this.profilePicture,
      this.moderatorPermissions});

  Moderators.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    joiningDate = json['joiningDate'];
    profilePicture = json['profilePicture'];
    moderatorPermissions = json['moderatorPermissions'] != null
        ? new ModeratorPermissions.fromJson(json['moderatorPermissions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['joiningDate'] = this.joiningDate;
    data['profilePicture'] = this.profilePicture;
    if (this.moderatorPermissions != null) {
      data['moderatorPermissions'] = this.moderatorPermissions!.toJson();
    }
    return data;
  }
}

class ModeratorPermissions {
  bool? all;
  bool? access;
  bool? config;
  bool? flair;
  bool? posts;

  ModeratorPermissions(
      {this.all, this.access, this.config, this.flair, this.posts});

  ModeratorPermissions.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    access = json['access'];
    config = json['config'];
    flair = json['flair'];
    posts = json['posts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    data['access'] = this.access;
    data['config'] = this.config;
    data['flair'] = this.flair;
    data['posts'] = this.posts;
    return data;
  }
}
