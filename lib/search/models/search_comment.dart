class SearchComment {
  List<CommentData>? data;

  SearchComment({this.data});

  SearchComment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CommentData>[];
      json['data'].forEach((v) {
        data!.add(new CommentData.fromJson(v));
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

class CommentData {
  String? sId;
  Author? author;
  Post? post;
  String? text;
  String? createdAt;
  int? votes;
  int? repliesCount;

  CommentData(
      {this.sId,
      this.author,
      this.post,
      this.text,
      this.createdAt,
      this.votes,
      this.repliesCount});

  CommentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    text = json['text'];
    createdAt = json['createdAt'];
    votes = json['votes'];
    repliesCount = json['repliesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    data['votes'] = this.votes;
    data['repliesCount'] = this.repliesCount;
    return data;
  }
}

class Author {
  String? sId;
  String? userName;
  String? profilePicture;
  String? displayName;

  Author({this.sId, this.userName, this.profilePicture, this.displayName});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['displayName'] = this.displayName;
    return data;
  }
}

class Post {
  String? sId;
  Author? author;
  Owner? owner;
  String? title;
  String? kind;
  String? text;
  String? url;
  List<String>? images;
  String? video;
  int? votes;
  int? commentCount;
  String? createdAt;
  FlairId? flairId;

  Post(
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
      this.commentCount,
      this.createdAt,
      this.flairId});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    title = json['title'];
    kind = json['kind'];
    text = json['text'];
    url = json['url'];
    images = json['images'].cast<String>();
    video = json['video'];
    votes = json['votes'];
    commentCount = json['commentCount'];
    createdAt = json['createdAt'];
    flairId =
        json['flairId'] != null ? new FlairId.fromJson(json['flairId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['title'] = this.title;
    data['kind'] = this.kind;
    data['text'] = this.text;
    data['url'] = this.url;
    data['images'] = this.images;
    data['video'] = this.video;
    data['votes'] = this.votes;
    data['commentCount'] = this.commentCount;
    data['createdAt'] = this.createdAt;
    if (this.flairId != null) {
      data['flairId'] = this.flairId!.toJson();
    }
    return data;
  }
}

class Owner {
  String? icon;
  String? sId;
  String? fixedName;
  String? name;
  int? membersCount;
  String? description;

  Owner(
      {this.icon,
      this.sId,
      this.fixedName,
      this.name,
      this.membersCount,
      this.description});

  Owner.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    sId = json['_id'];
    fixedName = json['fixedName'];
    name = json['name'];
    membersCount = json['membersCount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['_id'] = this.sId;
    data['fixedName'] = this.fixedName;
    data['name'] = this.name;
    data['membersCount'] = this.membersCount;
    data['description'] = this.description;
    return data;
  }
}

class FlairId {
  String? sId;
  String? text;
  String? backgroundColor;
  String? textColor;

  FlairId({this.sId, this.text, this.backgroundColor, this.textColor});

  FlairId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['backgroundColor'] = this.backgroundColor;
    data['textColor'] = this.textColor;
    return data;
  }
}
