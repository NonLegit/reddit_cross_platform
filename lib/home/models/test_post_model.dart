class Data {
  String? sId;
  Author? author;
  String? ownerType;
  Owner? owner;
  List<String>? replies;
  FlairId? flairId;
  String? flairText;
  String? sharedFrom;
  String? title;
  String? kind;
  String? text;
  List<Null>? images;
  String? video;
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
  int? sortOnHot;
  int? sortOnBest;
  bool? isSpam;
  String? url;
  bool? isSaved;
  int? postVoteStatus;

  Data(
      {this.sId,
        this.author,
        this.ownerType,
        this.owner,
        this.replies,
        this.flairId,
        this.flairText,
        this.sharedFrom,
        this.title,
        this.kind,
        this.text,
        this.images,
        this.video,
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
        this.sortOnHot,
        this.sortOnBest,
        this.isSpam,
        this.url,
        this.isSaved,
        this.postVoteStatus});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    ownerType = json['ownerType'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    replies = json['replies'].cast<String>();
    flairId =
    json['flairId'] != null ? new FlairId.fromJson(json['flairId']) : null;
    flairText = json['flairText'];
    sharedFrom = json['sharedFrom'];
    title = json['title'];
    kind = json['kind'];
    text = json['text'];
    // if (json['images'] != null) {
    //   images = <Null>[];
    //   json['images'].forEach((v) {
    //     images!.add(new Null.fromJson(v));
    //   });
    // }
    video = json['video'];
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
    sortOnHot = json['sortOnHot'];
    sortOnBest = json['sortOnBest'];
    isSpam = json['isSpam'];
    url = json['url'];
    isSaved = json['isSaved'];
    postVoteStatus = json['postVoteStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['ownerType'] = this.ownerType;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['replies'] = this.replies;
    if (this.flairId != null) {
      data['flairId'] = this.flairId!.toJson();
    }
    data['flairText'] = this.flairText;
    data['sharedFrom'] = this.sharedFrom;
    data['title'] = this.title;
    data['kind'] = this.kind;
    data['text'] = this.text;
    // if (this.images != null) {
    //   data['images'] = this.images!.map((v) => v.toJson()).toList();
    // }
    data['video'] = this.video;
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
    data['sortOnHot'] = this.sortOnHot;
    data['sortOnBest'] = this.sortOnBest;
    data['isSpam'] = this.isSpam;
    data['url'] = this.url;
    data['isSaved'] = this.isSaved;
    data['postVoteStatus'] = this.postVoteStatus;
    return data;
  }
}

class Author {
  String? sId;
  String? name;

  Author({this.sId, this.name});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Owner {
  String? sId;
  String? name;
  String? icon;

  Owner({this.sId, this.name, this.icon});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class FlairId {
  String? sId;
  String? text;
  String? backgroundColor;
  String? textColor;
  String? permissions;

  FlairId(
      {this.sId,
        this.text,
        this.backgroundColor,
        this.textColor,
        this.permissions});

  FlairId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
    permissions = json['permissions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['backgroundColor'] = this.backgroundColor;
    data['textColor'] = this.textColor;
    data['permissions'] = this.permissions;
    return data;
  }
}