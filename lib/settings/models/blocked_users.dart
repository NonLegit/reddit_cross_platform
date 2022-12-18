class BlockedUsers {
  String? status;
  List<Blocked>? blocked;

  BlockedUsers({this.status, this.blocked});

  BlockedUsers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['blocked'] != null) {
      blocked = <Blocked>[];
      json['blocked'].forEach((v) {
        blocked!.add(new Blocked.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.blocked != null) {
      data['blocked'] = this.blocked!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blocked {
  String? sId;
  String? userName;
  String? profilePicture;

  Blocked({this.sId, this.userName, this.profilePicture});

  Blocked.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
