class NotificationModel {
  String? sId;
  String? type;
  String? createdAt;
  bool? seen;
  bool? hidden;
  String? followerId;
  String? followeruserName;
  String? followerIcon;
  String? requiredId;
  String? requiredName;
  String? postId;
  String? commentId;
  String? description;

  NotificationModel(
      {this.sId,
      this.type,
      this.createdAt,
      this.seen,
      this.hidden,
      this.followerIcon,
      this.followerId,
      this.followeruserName});

  NotificationModel.fromJson(Map<String, dynamic> json) {

    sId = (json['_id'] == null) ? '' : json['_id'] as String;
    type = json['type'] ?? '';
    if (json['followedSubreddit'] != null) {
      requiredId = (json['followedSubreddit']['_id'] == null)
          ? ''
          : json['followedSubreddit']['_id'] as String;
      String? h = json['followedSubreddit']['fixedName'] ?? '';
      requiredName = 'r/$h';
    } else if (json['followedUser'] != null) {
      requiredId = (json['followedUser']['_id'] == null)
          ? ''
          : json['followedUser']['_id'] as String;
      String? h = json['followedUser']['userName'] ?? '';
      requiredName = 'u/$h';
    } else {
      requiredId = '';
      requiredName = '';
    }
    if (json['followerUser'] != null) {
      followerId = (json['followerUser']['_id'] == null)
          ? ''
          : json['followerUser']['_id'] as String;
      String? h = json['followerUser']['userName'] ?? '';
      followeruserName = 'u/$h';
      // followeruserName = json['followerUser']['userName'] ?? '';
      followerIcon = json['followerUser']['profilePicture'] ??
          'https://www.redditstatic.com/avatars/defaults/v2/avatar_default_0.png';
    } else {
      followerId = '';
      followeruserName = '';
      followerIcon =
          'https://www.redditstatic.com/avatars/defaults/v2/avatar_default_0.png';
    }

    if (json['post'] != null) {
      postId = (json['post'] == null) ? '' : json['post'] as String;
    } else {
      postId = '';
    }
    // comment =
    if (json['comment'] != null) {
      commentId = (json['comment']['_id'] == null)
          ? ''
          : json['comment']['_id'] as String;
      description = json['comment']['text'] ?? '';
    } else {
      commentId = '';
      description = '';
    }
    createdAt = json['createdAt'] ?? '';
    seen = json['seen'];
    hidden = json['hidden'];
  }
}
