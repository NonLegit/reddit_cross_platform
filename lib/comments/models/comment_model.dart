class CommentModel {
  String? sId;
  Author? author;
  String? post;
  List<String>? mentions;
  List<CommentModel>? replies;
  String? parent;
  String? parentType;
  String? text;
  String? createdAt;
  bool? isDeleted;
  int? votes;
  int? repliesCount;
  bool? locked;
  bool? nsfw;
  bool? spoiler;
  String? modState;
  double? sortOnHot;
  int? iV;
  String? type;
  int? count;
  List<String>? children;

  CommentModel(
      {this.sId,
      this.author,
      this.post,
      this.mentions,
      this.replies,
      this.parent,
      this.parentType,
      this.text,
      this.createdAt,
      this.isDeleted,
      this.votes,
      this.repliesCount,
      this.locked,
      this.nsfw,
      this.spoiler,
      this.modState,
      this.sortOnHot,
      this.iV,
      this.type,
      this.count,
      this.children});

  CommentModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    post = json['post'];
    if (json['mentions'] != null) {
      mentions = json['mentions'].cast<String>();
    } else {
      mentions = [''];
    }

    if (json['replies'] != null) {
      replies = <CommentModel>[];
      json['replies'].forEach((v) {
        replies!.add(CommentModel.fromJson(v));
      });
    }
    parent = json['parent'];
    parentType = json['parentType'];
    text = json['text'];
    createdAt = json['createdAt'];
    isDeleted = json['isDeleted'];
    votes = json['votes'];
    repliesCount = json['repliesCount'];
    locked = json['locked'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    modState = json['modState'];
    iV = json['__v'];
    type = json['Type'];
    count = json['count'];
    if (json['children'] != null) {
      children = json['children'].cast<String>();
    } else {
      children = [''];
    }
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
}
