class SendPostModel {
  String? title;
  String? kind;
  String? text;
  String? url;
  String? owner;
  String? ownerType;
  bool? nsfw;
  bool? spoiler;
  bool? sendReplies;
  String? flairId;
  String? flairText;
  String? suggestedSort;
  bool? scheduled;

  SendPostModel(
      {this.title,
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
       });

  SendPostModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title ;
    data['kind'] = this.kind;
    data['text'] = this.text;
    data['url'] = this.url;
    data['owner'] = this.owner;
    data['ownerType'] = this.ownerType;
    data['nsfw'] = this.nsfw;
    data['spoiler'] = this.spoiler;
    data['sendReplies'] = this.sendReplies;
    data['flairId'] = this.flairId;
    data['flairText'] = this.flairText;
    data['suggestedSort'] = this.suggestedSort;
    data['scheduled'] = this.scheduled;
    return data;
  }
}
