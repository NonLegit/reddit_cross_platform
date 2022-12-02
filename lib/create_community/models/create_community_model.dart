class CreateCommunityModel {
  String? name;
  String? type;
  bool? nSFW;

  CreateCommunityModel({this.name, this.type, this.nSFW});

  CreateCommunityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    nSFW = json['NSFW'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['NSFW'] = nSFW;
    return data;
  }
}
