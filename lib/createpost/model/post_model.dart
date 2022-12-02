class PostModel {
  PostModel({
    this.title,
    this.kind,
    this.text,
    this.url,
    this.owner,
    this.ownerType,
    this.nsfw,
    this.spoiler,
    this.sendReplies,
    this.flairId,
    this.flairText,
    this.suggestedSort,
    this.scheduled,
    this.sharedFrom,
  });

  PostModel.fromJson(dynamic json) {
    title = json['title'];
    kind = json['kind'];
    text = json['text'];
    url = json['url'];
    owner = json['owner'];
    ownerType = json['ownerType'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    sendReplies = json['sendReplies'];
    flairId = json['flairId'];
    flairText = json['flairText'];
    suggestedSort = json['suggestedSort'];
    scheduled = json['scheduled'];
    sharedFrom = json['sharedFrom'];
  }

  String? title;
  String? kind;
  String? text;
  String? url;
  String? owner;
  String? ownerType;
  String? nsfw;
  String? spoiler;
  String? sendReplies;
  String? flairId;
  String? flairText;
  String? suggestedSort;
  String? scheduled;
  String? sharedFrom;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['kind'] = kind;
    map['text'] = text;
    map['url'] = url;
    map['owner'] = owner;
    map['ownerType'] = ownerType;
    map['nsfw'] = nsfw;
    map['spoiler'] = spoiler;
    map['sendReplies'] = sendReplies;
    map['flairId'] = flairId;
    map['flairText'] = flairText;
    map['suggestedSort'] = suggestedSort;
    map['scheduled'] = scheduled;
    map['sharedFrom'] = sharedFrom;
    return map;
  }
}
