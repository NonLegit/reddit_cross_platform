class SearchCommunity {
  List<CommunityData>? data;
  SearchCommunity({this.data});
  SearchCommunity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CommunityData>[];
      json['data'].forEach((v) {
        data!.add(new CommunityData.fromJson(v));
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

class CommunityData {
  String? icon;
  String? sId;
  String? fixedName;
  int? membersCount;
  String? description;
  String? name;
  bool? nsfw;
  bool? isJoined;

  CommunityData(
      {this.icon,
      this.sId,
      this.fixedName,
      this.membersCount,
      this.description,
      this.name,
      this.nsfw,
      this.isJoined});

  CommunityData.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    sId = json['_id'];
    fixedName = json['fixedName'];
    membersCount = json['membersCount'];
    description = json['description'];
    name = json['name'];
    nsfw = json['nsfw'];
    isJoined = json['isJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['_id'] = this.sId;
    data['fixedName'] = this.fixedName;
    data['membersCount'] = this.membersCount;
    data['description'] = this.description;
    data['name'] = this.name;
    data['nsfw'] = this.nsfw;
    data['isJoined'] = this.isJoined;
    return data;
  }
}
