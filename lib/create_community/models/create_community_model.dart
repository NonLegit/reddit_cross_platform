class CreateCommunityModel {
  String? name;
  String? type;
  bool? nSFW;

  CreateCommunityModel({this.name, this.type, this.nSFW});

  CreateCommunityModel.fromJson(Map<String, dynamic> json) {
    name = json['fixedName'];
    type = json['type'];
    nSFW = json['nsfw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fixedName'] = name;
    data['type'] = type;
    data['nsfw'] = nSFW;
    return data;
  }
}
