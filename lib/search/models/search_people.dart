class SearchPeople {
  List<PeopleData>? data;

  SearchPeople({this.data});

  SearchPeople.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PeopleData>[];
      json['data'].forEach((v) {
        data!.add(new PeopleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PeopleData {
  String? sId;
  String? userName;
  String? profilePicture;
  String? displayName;
  int? postKarma;
  int? commentKarma;
  String? description;
  bool? isFollowed;

  PeopleData(
      {this.sId,
      this.userName,
      this.profilePicture,
      this.displayName,
      this.postKarma,
      this.commentKarma,
      this.description,
      this.isFollowed});

  PeopleData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    displayName = json['displayName'];
    postKarma = json['postKarma'];
    commentKarma = json['commentKarma'];
    description = json['description'];
    isFollowed = json['isFollowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['displayName'] = this.displayName;
    data['postKarma'] = this.postKarma;
    data['commentKarma'] = this.commentKarma;
    data['description'] = this.description;
    data['isFollowed'] = this.isFollowed;
    return data;
  }
}
