class NotificationsClassModel {
  String? type;
  String? folowerId;
  String? postId;
  String? commentId;
  String? followedId;
  String? createdAt;
  bool? seen;
  bool? isHidden;


// [
//   {
//     "type": "post_reply",
//     "folowerId": "string",
//     "postId": "string",
//     "commentId": "string",
//     "followedId": "2017-07-21T17:32:28.000Z",
//     "createdAt": "string",
//     "seen": true,
//     "isHidden": true
//   }
// ]
  NotificationsClassModel(
      {this.type,
      this.folowerId,
      this.postId,
      this.commentId,
      this.followedId,
      this.createdAt,
      this.seen,
      this.isHidden});

  NotificationsClassModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    folowerId = json['folowerId'];
    postId = json['postId'];
    commentId = json['commentId'];
    followedId = json['followedId'];
    createdAt = json['createdAt'];
    seen = json['seen'];
    isHidden = json['isHidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['folowerId'] = this.folowerId;
    data['postId'] = this.postId;
    data['commentId'] = this.commentId;
    data['followedId'] = this.followedId;
    data['createdAt'] = this.createdAt;
    data['seen'] = this.seen;
    data['isHidden'] = this.isHidden;
    return data;
  }
}
