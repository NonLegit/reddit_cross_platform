class ModeratorToolsModel {
  String? createdAt;
  String? primaryTopic;
  String? backgroundImage;
  String? icon;
  List<Rules>? rules;
  String? name;
  String? description;
  List<Null>? topics;
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
  bool? allowImages;
  bool? allowVideos;
  bool? allowLinks;
  ModeratorToolsModel(
      {this.createdAt,
      this.primaryTopic,
      this.backgroundImage,
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
      this.allowMultipleImage,
      this.allowImages,
      this.allowLinks,
      this.allowVideos});

  String? get choosenTopic1 {
    return primaryTopic;
  }

  ModeratorToolsModel.fromJson(Map<String, dynamic> json) {
    //createdAt = json['createdAt'];
    primaryTopic = json['primaryTopic'];
    // backgroundImage = json['backgroundImage'];
    // icon = json['icon'];
    if (json['rules'] != null) {
      rules = <Rules>[];
      json['rules'].forEach((v) {
        rules!.add(new Rules.fromJson(v));
      });
    }
    // fixedName = json['fixedName'];
    // name = json['name'];
    description = json['description'];
    // if (json['topics'] != null) {
    //   topics = <Null>[];
    //   json['topics'].forEach((v) {
    //     topics!.add(new Null.fromJson(v));
    //   });
    // }
    // language = json['language'];
    region = json['region'];
    type = json['type'];
    nsfw = json['nsfw'];
    // postType = json['postType'];
    // allowCrossposting = json['allowCrossposting'];
    // allowArchivePosts = json['allowArchivePosts'];
    // allowSpoilerTag = json['allowSpoilerTag'];
    // allowGif = json['allowGif'];
    // allowImageUploads = json['allowImageUploads'];
    // allowMultipleImage = json['allowMultipleImage'];
    allowImages = json['allowImgs'];
    allowVideos = json['allowVideos'];
    allowLinks = json['allowLinks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['primaryTopic'] = primaryTopic;
    data['backgroundImage'] = backgroundImage;
    data['icon'] = icon;
    if (this.rules != null) {
      data['rules'] = this.rules!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['description'] = description;
    // if (this.topics != null) {
    //   data['topics'] = topics!.map((v) => v.toJson()).toList();
    // }
    data['language'] = language;
    data['region'] = region;
    data['type'] = type;
    data['nsfw'] = nsfw;
    data['postType'] = postType;
    data['allowCrossposting'] = allowCrossposting;
    data['allowArchivePosts'] = allowArchivePosts;
    data['allowSpoilerTag'] = allowSpoilerTag;
    data['allowGif'] = allowGif;
    // data['allowImageUploads'] = allowImageUploads;
    // data['allowMultipleImage'] = allowMultipleImage;
    data['allowImgs'] = allowImages;
    data['allowVideos'] = allowVideos;
    data['allowLinks'] = allowLinks;
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
