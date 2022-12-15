class Banned {
  String? sId;
  String? userName;
  String? profilePicture;
  String? banDate;
  Baninfo? baninfo;

  Banned(
      {this.sId,
      this.userName,
      this.profilePicture,
      this.banDate,
      this.baninfo});

  Banned.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    banDate = json['banDate'];
    baninfo =
        json['baninfo'] != null ? new Baninfo.fromJson(json['baninfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['banDate'] = this.banDate;
    if (this.baninfo != null) {
      data['baninfo'] = this.baninfo!.toJson();
    }
    return data;
  }
}

class Baninfo {
  String? punishType;
  String? note;
  String? punishReason;
  int? duration;

  Baninfo({this.punishType, this.note, this.punishReason, this.duration});

  Baninfo.fromJson(Map<String, dynamic> json) {
    punishType = json['punish_type'];
    note = json['Note'];
    punishReason = json['punishReason'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['punish_type'] = this.punishType;
    data['Note'] = this.note;
    data['punishReason'] = this.punishReason;
    data['duration'] = this.duration;
    return data;
  }
}
