class Approved {
  String? sId;
  String? userName;
  String? profilePicture;
  String? joiningDate;

  Approved({this.sId, this.userName, this.profilePicture, this.joiningDate});

  Approved.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    joiningDate = json['joiningDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['joiningDate'] = this.joiningDate;
    return data;
  }
}
