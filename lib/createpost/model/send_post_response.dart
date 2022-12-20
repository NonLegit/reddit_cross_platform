class SendPostResponseModel {
  String? sId;
  String? author;
  String? owner;
  String? title;
  String? kind;
  String? text;
  String? url;
  List<String>? images;
  String? video;
  int? votes;
  int? shareCount;
  int? views;
  int? commentCount;
  String? createdAt;
  String? suggestedSort;
  bool? nsfw;
  bool? spoiler;
  bool? sendReplies;
  bool? locked;
  String? modState;
  String? flairId;
  String? flairText;

  SendPostResponseModel(
      {this.sId,
        this.author,
        this.owner,
        this.title,
        this.kind,
        this.text,
        this.url,
        this.images,
        this.video,
        this.votes,
        this.shareCount,
        this.views,
        this.commentCount,
        this.createdAt,
        this.suggestedSort,
        this.nsfw,
        this.spoiler,
        this.sendReplies,
        this.locked,
        this.modState,
        this.flairId,
        this.flairText});

  SendPostResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    owner = json['owner'];
    title = json['title'];
    kind = json['kind'];
    text = json['text'];
    url = json['url'];
    images = json['images'].cast<String>();
    video = json['video'];
    votes = json['votes'];
    shareCount = json['shareCount'];
    views = json['views'];
    commentCount = json['commentCount'];
    createdAt = json['createdAt'];
    suggestedSort = json['suggestedSort'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    sendReplies = json['sendReplies'];
    locked = json['locked'];
    modState = json['modState'];
    flairId = json['flairId'];
    flairText = json['flairText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['author'] = this.author;
    data['owner'] = this.owner;
    data['title'] = this.title;
    data['kind'] = this.kind;
    data['text'] = this.text;
    data['url'] = this.url;
    data['images'] = this.images;
    data['video'] = this.video;
    data['votes'] = this.votes;
    data['shareCount'] = this.shareCount;
    data['views'] = this.views;
    data['commentCount'] = this.commentCount;
    data['createdAt'] = this.createdAt;
    data['suggestedSort'] = this.suggestedSort;
    data['nsfw'] = this.nsfw;
    data['spoiler'] = this.spoiler;
    data['sendReplies'] = this.sendReplies;
    data['locked'] = this.locked;
    data['modState'] = this.modState;
    data['flairId'] = this.flairId;
    data['flairText'] = this.flairText;
    return data;
  }
}