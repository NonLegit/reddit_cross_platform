class ModeratorToolsModel {
  RemovalReasons? removalReasons;
  String? icon;
  Rules? rules;
  String? name;
  String? description;
  List<String>? topics;
  String? language;
  String? region;
  String? type;
  bool? nsfw;
  String? postType;
  bool? allowCrossposting;
  bool? allowArchivePosts;
  bool? allowSpoilerTag;
  bool? allowGif;
  bool? allowImageUploads;
  bool? allowMultipleImage;

  ModeratorToolsModel(
      {this.removalReasons,
      this.icon,
      this.rules,
      this.name,
      this.description,
      this.topics,
      this.language,
      this.region,
      this.type,
      this.nsfw,
      this.postType,
      this.allowCrossposting,
      this.allowArchivePosts,
      this.allowSpoilerTag,
      this.allowGif,
      this.allowImageUploads,
      this.allowMultipleImage});

  ModeratorToolsModel.fromJson(Map<String, dynamic> json) {
    removalReasons = json['removalReasons'] != null
        ? RemovalReasons.fromJson(json['removalReasons'])
        : null;
    icon = json['icon'];
    rules = json['rules'] != null ? Rules.fromJson(json['rules']) : null;
    name = json['name'];
    description = json['description'];
    if (json['topics'] != null) {
      topics = <String>[];
      json['topics'].forEach((v) {
        topics!.add(v);
      });
    }
    language = json['language'];
    region = json['region'];
    type = json['type'];
    nsfw = json['nsfw'];
    postType = json['postType'];
    allowCrossposting = json['allowCrossposting'];
    allowArchivePosts = json['allowArchivePosts'];
    allowSpoilerTag = json['allowSpoilerTag'];
    allowGif = json['allowGif'];
    allowImageUploads = json['allowImageUploads'];
    allowMultipleImage = json['allowMultipleImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.removalReasons != null) {
      data['removalReasons'] = this.removalReasons!.toJson();
    }
    data['icon'] = this.icon;
    if (this.rules != null) {
      data['rules'] = this.rules!.toJson();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.topics != null) {
      data['topics'] = topics!.map((v) => v).toList();
    }
    data['language'] = this.language;
    data['region'] = this.region;
    data['type'] = this.type;
    data['nsfw'] = this.nsfw;
    data['postType'] = this.postType;
    data['allowCrossposting'] = this.allowCrossposting;
    data['allowArchivePosts'] = this.allowArchivePosts;
    data['allowSpoilerTag'] = this.allowSpoilerTag;
    data['allowGif'] = this.allowGif;
    data['allowImageUploads'] = this.allowImageUploads;
    data['allowMultipleImage'] = this.allowMultipleImage;
    return data;
  }
}

class RemovalReasons {
  String? title;
  String? description;

  RemovalReasons({this.title, this.description});

  RemovalReasons.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Rules {
  String? title;
  String? description;
  String? defaultName;
  String? appliesTo;

  Rules({this.title, this.description, this.defaultName, this.appliesTo});

  Rules.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    defaultName = json['defaultName'];
    appliesTo = json['appliesTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['defaultName'] = this.defaultName;
    data['appliesTo'] = this.appliesTo;
    return data;
  }
}
