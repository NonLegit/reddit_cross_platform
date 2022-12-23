class NotificationModel {
  String? sId;
  String? type;
  //FollowedUser? followedUser;
  //FollowedUser? followerUser;
  //FollowedSubreddit? followedSubreddit;
  //Post? post;
  //Comment? comment;
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
      // this.followedUser,
      //this.followerUser,
      //this.followedSubreddit,
      //this.post,
      //this.comment,
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
      print(requiredName);
    } else if (json['followedUser'] != null) {
      print('folllllllllllllllllllllllllll');
      requiredId = (json['followedUser']['_id'] == null)
          ? ''
          : json['followedUser']['_id'] as String;
      String? h = json['followedUser']['userName'] ?? '';
      requiredName = 'u/$h';
      // requiredName = json['followedUser']['userName'] ?? '';
      //name = json['name'];
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
      print('In class Model');
      // print(json['post']['_id'].runtimeType);
      postId = (json['post'] == null) ? '' : json['post'] as String;
    } else {
      postId = '';
    }
    // comment =
    if (json['comment'] != null) {
      print('In mcommmmeeeeeeen');
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

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['type'] = this.type;
//     // if (this.followedUser != null) {
//     //   data['followedUser'] = this.followedUser!.toJson();
//     // }
//     // if (this.followerUser != null) {
//     //   data['followerUser'] = this.followerUser!.toJson();
//     // }
//     // if (this.followedSubreddit != null) {
//     //   data['followedSubreddit'] = this.followedSubreddit!.toJson();
//     // }
//     // if (this.post != null) {
//     //   data['post'] = this.post!.toJson();
//     // }
//     // if (this.comment != null) {
//     //   data['comment'] = this.comment!.toJson();
//     // }
//     data['createdAt'] = this.createdAt;
//     data['seen'] = this.seen;
//     data['hidden'] = this.hidden;
//     return data;
//   }
// }
}

// class FollowedUser {
//   int? iId;
//   String? userName;
//   // String email;
//   // String profilePicture;
//   // String profileBackground;
//   // bool adultContent;
//   // bool autoplayMedia;
//   // bool canbeFollowed;
//   // String lastUpdatedPassword;
//   // int followersCount;
//   // int friendsCount;
//   // bool accountActivated;
//   // String gender;
//   // String displayName;
//   // int postKarma;
//   // int commentKarma;
//   // String createdAt;
//   // String description;
//   // List<SocialLinks> socialLinks;

//   FollowedUser({
//     this.iId,
//     this.userName,
//     // this.email,
//     // this.profilePicture,
//     // this.profileBackground,
//     // this.adultContent,
//     // this.autoplayMedia,
//     // this.canbeFollowed,
//     // this.lastUpdatedPassword,
//     // this.followersCount,
//     // this.friendsCount,
//     // this.accountActivated,
//     // this.gender,
//     // this.displayName,
//     // this.postKarma,
//     // this.commentKarma,
//     // this.createdAt,
//     // this.description,
//     // this.socialLinks
//   });

//   FollowedUser.fromJson(Map<String, dynamic> json) {
//     iId = json['_id'];
//     userName = json['userName'];
//     // email = json['email'];
//     // profilePicture = json['profilePicture'];
//     // profileBackground = json['profileBackground'];
//     // adultContent = json['adultContent'];
//     // autoplayMedia = json['autoplayMedia'];
//     // canbeFollowed = json['canbeFollowed'];
//     // lastUpdatedPassword = json['lastUpdatedPassword'];
//     // followersCount = json['followersCount'];
//     // friendsCount = json['friendsCount'];
//     // accountActivated = json['accountActivated'];
//     // gender = json['gender'];
//     // displayName = json['displayName'];
//     // postKarma = json['postKarma'];
//     // commentKarma = json['commentKarma'];
//     // createdAt = json['createdAt'];
//     // description = json['description'];
//     // if (json['socialLinks'] != null) {
//     //   socialLinks = new List<SocialLinks>();
//     //   json['socialLinks'].forEach((v) {
//     //     socialLinks.add(new SocialLinks.fromJson(v));
//     //   });
//     // }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.iId;
//     data['userName'] = this.userName;
//     // data['email'] = this.email;
//     // data['profilePicture'] = this.profilePicture;
//     // data['profileBackground'] = this.profileBackground;
//     // data['adultContent'] = this.adultContent;
//     // data['autoplayMedia'] = this.autoplayMedia;
//     // data['canbeFollowed'] = this.canbeFollowed;
//     // data['lastUpdatedPassword'] = this.lastUpdatedPassword;
//     // data['followersCount'] = this.followersCount;
//     // data['friendsCount'] = this.friendsCount;
//     // data['accountActivated'] = this.accountActivated;
//     // data['gender'] = this.gender;
//     // data['displayName'] = this.displayName;
//     // data['postKarma'] = this.postKarma;
//     // data['commentKarma'] = this.commentKarma;
//     // data['createdAt'] = this.createdAt;
//     // data['description'] = this.description;
//     // if (this.socialLinks != null) {
//     //   data['socialLinks'] = this.socialLinks.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }

// class FollowedSubreddit {
//   String? sId;
//   // bool isJoined;
//   // String createdAt;
//   // String primaryTopic;
//   // String backgroundImage;
//   // String icon;
//   // List<Rules> rules;
//   String? fixedName;
//   String? name;
//   // String description;
//   // List<Null> topics;
//   // String language;
//   // String region;
//   // String type;
//   // bool nsfw;
//   // String postType;
//   // bool allowCrossposting;
//   // bool allowArchivePosts;
//   // bool allowSpoilerTag;
//   // bool allowGif;
//   // bool allowImageUploads;
//   // bool allowMultipleImage;
//   // List<Moderators> moderators;

//   FollowedSubreddit({
//     this.sId,
//     // this.isJoined,
//     // this.createdAt,
//     // this.primaryTopic,
//     // this.backgroundImage,
//     // this.icon,
//     // this.rules,
//     this.fixedName,
//     this.name,
//     // this.description,
//     // this.topics,
//     // this.language,
//     // this.region,
//     // this.type,
//     // this.nsfw,
//     // this.postType,
//     // this.allowCrossposting,
//     // this.allowArchivePosts,
//     // this.allowSpoilerTag,
//     // this.allowGif,
//     // this.allowImageUploads,
//     // this.allowMultipleImage,
//     // this.moderators
//   });

//   FollowedSubreddit.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     // isJoined = json['isJoined'];
//     // createdAt = json['createdAt'];
//     // primaryTopic = json['primaryTopic'];
//     // backgroundImage = json['backgroundImage'];
//     // icon = json['icon'];
//     // if (json['rules'] != null) {
//     //   rules = new List<Rules>();
//     //   json['rules'].forEach((v) {
//     //     rules.add(new Rules.fromJson(v));
//     //   });
//     // }
//     fixedName = json['fixedName'];
//     name = json['name'];
//     // description = json['description'];
//     // if (json['topics'] != null) {
//     //   topics = new List<Null>();
//     //   json['topics'].forEach((v) {
//     //     topics.add(new Null.fromJson(v));
//     //   });
//     // }
//     // language = json['language'];
//     // region = json['region'];
//     // type = json['type'];
//     // nsfw = json['nsfw'];
//     // postType = json['postType'];
//     // allowCrossposting = json['allowCrossposting'];
//     // allowArchivePosts = json['allowArchivePosts'];
//     // allowSpoilerTag = json['allowSpoilerTag'];
//     // allowGif = json['allowGif'];
//     // allowImageUploads = json['allowImageUploads'];
//     // allowMultipleImage = json['allowMultipleImage'];
//     // if (json['moderators'] != null) {
//     //   moderators = new List<Moderators>();
//     //   json['moderators'].forEach((v) {
//     //     moderators.add(new Moderators.fromJson(v));
//     //   });
//     // }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     // data['isJoined'] = this.isJoined;
//     // data['createdAt'] = this.createdAt;
//     // data['primaryTopic'] = this.primaryTopic;
//     // data['backgroundImage'] = this.backgroundImage;
//     // data['icon'] = this.icon;
//     // if (this.rules != null) {
//     //   data['rules'] = this.rules.map((v) => v.toJson()).toList();
//     // }
//     data['fixedName'] = this.fixedName;
//     data['name'] = this.name;
//     // data['description'] = this.description;
//     // if (this.topics != null) {
//     //   data['topics'] = this.topics.map((v) => v.toJson()).toList();
//     // }
//     // data['language'] = this.language;
//     // data['region'] = this.region;
//     // data['type'] = this.type;
//     // data['nsfw'] = this.nsfw;
//     // data['postType'] = this.postType;
//     // data['allowCrossposting'] = this.allowCrossposting;
//     // data['allowArchivePosts'] = this.allowArchivePosts;
//     // data['allowSpoilerTag'] = this.allowSpoilerTag;
//     // data['allowGif'] = this.allowGif;
//     // data['allowImageUploads'] = this.allowImageUploads;
//     // data['allowMultipleImage'] = this.allowMultipleImage;
//     // if (this.moderators != null) {
//     //   data['moderators'] = this.moderators.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }

// class Post {
//   String? sId;
//   // String author;
//   // String owner;
//   // String title;
//   // String kind;
//   // String text;
//   // String url;
//   // List<String> images;
//   // String video;
//   // int votes;
//   // int shareCount;
//   // int views;
//   // int commentCount;
//   // String createdAt;
//   // String suggestedSort;
//   // bool nsfw;
//   // bool spoiler;
//   // bool sendReplies;
//   // bool locked;
//   // String modState;
//   // String flairId;
//   // String flairText;

//   Post({
//     this.sId,
//     // this.author,
//     // this.owner,
//     // this.title,
//     // this.kind,
//     // this.text,
//     // this.url,
//     // this.images,
//     // this.video,
//     // this.votes,
//     // this.shareCount,
//     // this.views,
//     // this.commentCount,
//     // this.createdAt,
//     // this.suggestedSort,
//     // this.nsfw,
//     // this.spoiler,
//     // this.sendReplies,
//     // this.locked,
//     // this.modState,
//     // this.flairId,
//     // this.flairText
//   });

//   Post.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     // author = json['author'];
//     // owner = json['owner'];
//     // title = json['title'];
//     // kind = json['kind'];
//     // text = json['text'];
//     // url = json['url'];
//     // images = json['images'].cast<String>();
//     // video = json['video'];
//     // votes = json['votes'];
//     // shareCount = json['shareCount'];
//     // views = json['views'];
//     // commentCount = json['commentCount'];
//     // createdAt = json['createdAt'];
//     // suggestedSort = json['suggestedSort'];
//     // nsfw = json['nsfw'];
//     // spoiler = json['spoiler'];
//     // sendReplies = json['sendReplies'];
//     // locked = json['locked'];
//     // modState = json['modState'];
//     // flairId = json['flairId'];
//     // flairText = json['flairText'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     // data['author'] = this.author;
//     // data['owner'] = this.owner;
//     // data['title'] = this.title;
//     // data['kind'] = this.kind;
//     // data['text'] = this.text;
//     // data['url'] = this.url;
//     // data['images'] = this.images;
//     // data['video'] = this.video;
//     // data['votes'] = this.votes;
//     // data['shareCount'] = this.shareCount;
//     // data['views'] = this.views;
//     // data['commentCount'] = this.commentCount;
//     // data['createdAt'] = this.createdAt;
//     // data['suggestedSort'] = this.suggestedSort;
//     // data['nsfw'] = this.nsfw;
//     // data['spoiler'] = this.spoiler;
//     // data['sendReplies'] = this.sendReplies;
//     // data['locked'] = this.locked;
//     // data['modState'] = this.modState;
//     // data['flairId'] = this.flairId;
//     // data['flairText'] = this.flairText;
//     return data;
//   }
// }

// class Comment {
//   String? sId;
//   // String parent;
//   // String parentType;
//   // Author author;
//   // Owner owner;
//   // String ownerType;
//   // String post;
//   // String title;
//   // String text;
//   // String createdAt;
//   // int votes;
//   // String commentVoteStatus;
//   // bool isDeleted;
//   // List<String> mentions;
//   // bool isSaved;

//   Comment({
//     this.sId,
//     // this.parent,
//     // this.parentType,
//     // this.author,
//     // this.owner,
//     // this.ownerType,
//     // this.post,
//     // this.title,
//     // this.text,
//     // this.createdAt,
//     // this.votes,
//     // this.commentVoteStatus,
//     // this.isDeleted,
//     // this.mentions,
//     // this.isSaved
//   });

//   Comment.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     // parent = json['parent'];
//     // parentType = json['parentType'];
//     // author =
//     //     json['author'] != null ? new Author.fromJson(json['author']) : null;
//     // owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
//     // ownerType = json['ownerType'];
//     // post = json['post'];
//     // title = json['title'];
//     // text = json['text'];
//     // createdAt = json['createdAt'];
//     // votes = json['votes'];
//     // commentVoteStatus = json['commentVoteStatus'];
//     // isDeleted = json['isDeleted'];
//     // mentions = json['mentions'].cast<String>();
//     // isSaved = json['isSaved'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     // data['parent'] = this.parent;
//     // data['parentType'] = this.parentType;
//     // if (this.author != null) {
//     //   data['author'] = this.author.toJson();
//     // }
//     // if (this.owner != null) {
//     //   data['owner'] = this.owner.toJson();
//     // }
//     // data['ownerType'] = this.ownerType;
//     // data['post'] = this.post;
//     // data['title'] = this.title;
//     // data['text'] = this.text;
//     // data['createdAt'] = this.createdAt;
//     // data['votes'] = this.votes;
//     // data['commentVoteStatus'] = this.commentVoteStatus;
//     // data['isDeleted'] = this.isDeleted;
//     // data['mentions'] = this.mentions;
//     // data['isSaved'] = this.isSaved;
//     return data;
//   }
// }

// // class Author {
// //   String sId;
// //   String name;

// //   Author({this.sId, this.name});

// //   Author.fromJson(Map<String, dynamic> json) {
// //     sId = json['_id'];
// //     name = json['name'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['_id'] = this.sId;
// //     data['name'] = this.name;
// //     return data;
// //   }
// // }

// // class Owner {
// //   String sId;
// //   String name;
// //   String icon;

// //   Owner({this.sId, this.name, this.icon});

// //   Owner.fromJson(Map<String, dynamic> json) {
// //     sId = json['_id'];
// //     name = json['name'];
// //     icon = json['icon'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['_id'] = this.sId;
// //     data['name'] = this.name;
// //     data['icon'] = this.icon;
// //     return data;
// //   }
// // }
