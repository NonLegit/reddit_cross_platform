class Approved {
  User? user;
  String? approvedDate;

  Approved({this.user, this.approvedDate});

  Approved.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    approvedDate = json['approvedDate'];
    print(approvedDate);
    // approvedDate = '2022-12-06T08:55:28.000Z';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['approvedDate'] = this.approvedDate;
    return data;
  }
}

class User {
  String? sId;
  String? userName;
  String? profilePicture;
  String? joinDate;

  User({this.sId, this.userName, this.profilePicture, this.joinDate});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    print('approved user  $profilePicture');
    joinDate = json['joinDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['joinDate'] = this.joinDate;
    return data;
  }
}
