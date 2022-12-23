class ModerationPosts {
  List<Data>? data;

  ModerationPosts({this.data});

  ModerationPosts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  Owner? owner;
  String? ownerType;
  Author? author;
  FlairId? flairId;
  String? title;
  String? kind;
  String? text;
  List<String>? images;
  String? createdAt;
  bool? locked;
  bool? isDeleted;
  bool? sendReplies;
  bool? nsfw;
  bool? spoiler;
  int? votes;
  int? views;
  int? commentCount;
  int? shareCount;
  String? suggestedSort;
  bool? scheduled;
  String? modState;
  int? spamCount;
  double? sortOnHot;
  double? sortOnBest;
  int? iV;

  Data(
      {this.sId,
      this.owner,
      this.ownerType,
      this.author,
      this.flairId,
      this.title,
      this.kind,
      this.text,
      this.images,
      this.createdAt,
      this.locked,
      this.isDeleted,
      this.sendReplies,
      this.nsfw,
      this.spoiler,
      this.votes,
      this.views,
      this.commentCount,
      this.shareCount,
      this.suggestedSort,
      this.scheduled,
      this.modState,
      this.spamCount,
      this.sortOnHot,
      this.sortOnBest,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    ownerType = json['ownerType'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    flairId =
        json['flairId'] != null ? new FlairId.fromJson(json['flairId']) : null;
    title = json['title'];
    kind = json['kind'];
    text = json['text'];
    images = json['images'].cast<String>();
    createdAt = json['createdAt'];
    locked = json['locked'];
    isDeleted = json['isDeleted'];
    sendReplies = json['sendReplies'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    votes = json['votes'];
    views = json['views'];
    commentCount = json['commentCount'];
    shareCount = json['shareCount'];
    suggestedSort = json['suggestedSort'];
    scheduled = json['scheduled'];
    modState = json['modState'];
    spamCount = json['spamCount'];
    sortOnHot = json['sortOnHot'];
    sortOnBest = json['sortOnBest'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['ownerType'] = this.ownerType;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.flairId != null) {
      data['flairId'] = this.flairId!.toJson();
    }
    data['title'] = this.title;
    data['kind'] = this.kind;
    data['text'] = this.text;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['locked'] = this.locked;
    data['isDeleted'] = this.isDeleted;
    data['sendReplies'] = this.sendReplies;
    data['nsfw'] = this.nsfw;
    data['spoiler'] = this.spoiler;
    data['votes'] = this.votes;
    data['views'] = this.views;
    data['commentCount'] = this.commentCount;
    data['shareCount'] = this.shareCount;
    data['suggestedSort'] = this.suggestedSort;
    data['scheduled'] = this.scheduled;
    data['modState'] = this.modState;
    data['spamCount'] = this.spamCount;
    data['sortOnHot'] = this.sortOnHot;
    data['sortOnBest'] = this.sortOnBest;
    data['__v'] = this.iV;
    return data;
  }
}

class Owner {
  String? sId;
  String? fixedName;
  String? icon;
  List<Rules>? rules;
  String? backgroundImage;

  Owner(
      {this.sId, this.fixedName, this.icon, this.rules, this.backgroundImage});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fixedName = json['fixedName'];
    icon = json['icon'];
    if (json['rules'] != null) {
      rules = <Rules>[];
      json['rules'].forEach((v) {
        rules!.add(new Rules.fromJson(v));
      });
    }
    backgroundImage = json['backgroundImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fixedName'] = this.fixedName;
    data['icon'] = this.icon;
    if (this.rules != null) {
      data['rules'] = this.rules!.map((v) => v.toJson()).toList();
    }
    data['backgroundImage'] = this.backgroundImage;
    return data;
  }
}

class Rules {
  String? createdAt;

  Rules({this.createdAt});

  Rules.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Author {
  String? sId;
  String? userName;
  String? profilePicture;
  String? profileBackground;

  Author(
      {this.sId, this.userName, this.profilePicture, this.profileBackground});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    profileBackground = json['profileBackground'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['profileBackground'] = this.profileBackground;
    return data;
  }
}

class FlairId {
  String? sId;
  String? text;
  String? textColor;
  String? backgroundColor;
  String? permissions;
  int? iV;

  FlairId(
      {this.sId,
      this.text,
      this.textColor,
      this.backgroundColor,
      this.permissions,
      this.iV});

  FlairId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    textColor = json['textColor'];
    backgroundColor = json['backgroundColor'];
    permissions = json['permissions'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['textColor'] = this.textColor;
    data['backgroundColor'] = this.backgroundColor;
    data['permissions'] = this.permissions;
    data['__v'] = this.iV;
    return data;
  }
}
