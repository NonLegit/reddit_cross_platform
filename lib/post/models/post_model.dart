import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostModel {
  String? sId;
  String? ownerType;
  List<dynamic>? replies;
  String? title;
  String? kind;
  String? text;
  List<dynamic>? images;
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
  FlairId? flairId;
  bool? isHidden;
  bool? isSaved;
  Owner? owner;
  Author? author;
  String? postVoteStatus;
  bool? isSpam;
  String? url;
  String? video;
  Size? maxHeightImageSize;
  int imageNumber;
  VideoPlayerController? videoController;
  bool? isModerator;
  bool? approved;
  bool? removed;

  PostModel(
      {this.sId,
      this.ownerType,
      this.replies,
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
      this.flairId,
      this.isHidden,
      this.isSaved,
      this.owner,
      this.author,
      this.postVoteStatus,
      this.isSpam,
      this.url,
      this.video,
      this.maxHeightImageSize,
      this.imageNumber = 0,
      this.videoController,
      this.isModerator,
      this.approved,
      this.removed});

  Future<Size> _calculateImageSize(link) {
    Completer<Size> completer = Completer();
    Image image = Image(
        image: CachedNetworkImageProvider(
            link.toString())); // I modified this line
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());

          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  Future<List<Size>> getSizeList(dynamic links) async {
    List<Size> heightList = [];
    for (var link in links) {
      heightList.add(await _calculateImageSize(link));
    }
    return Future.value(heightList);
  }

  Future<Size> getMaxHeight(dynamic links) async {
    double max = 0;
    double widthOfMax = 0;
    Size temp = const Size(0, 0);
    List<Size> list = await getSizeList(links);
    print(list);
    for (var size in list) {
      if (size.height > max) {
        max = size.height;
        widthOfMax = size.width;
      }
    }
    temp = Size(widthOfMax, max);

    return Future.value(temp);
  }

  Future<VideoPlayerController> getController(url) async {
    VideoPlayerController controller = VideoPlayerController.network(url);
    await controller.initialize();
    return controller;
  }

  Future<void> fromJson(Map<String, dynamic> json) async {
    print(json['_id'].runtimeType);
    print(json['ownerType'].runtimeType);
    print(json['replies'].runtimeType);
    print(json['title'].runtimeType);
    print(json['kind'].runtimeType);
    print(json['text'].runtimeType);
    print(json['images'].runtimeType);
    print(json['createdAt'].runtimeType);
    print(json['locked'].runtimeType);
    print(json['isDeleted'].runtimeType);
    print(json['sendReplies'].runtimeType);
    print(json['nsfw'].runtimeType);
    print(json['spoiler'].runtimeType);
    print(json['votes'].runtimeType);
    print(json['views'].runtimeType);
    print(json['commentCount'].runtimeType);
    print(json['shareCount'].runtimeType);
    print(json['suggestedSort'].runtimeType);
    print(json['scheduled'].runtimeType);
    print(json['flairId'].runtimeType);
    print(json['isHidden'].runtimeType);
    print(json['isSaved'].runtimeType);
    print(json['owner'].runtimeType);
    print(json['author'].runtimeType);
    print(json['postVoteStatus'].runtimeType);
    print(json['isSpam'].runtimeType);
    print(json['url'].runtimeType);

    sId = json['_id'];
    ownerType = json['ownerType'] ?? 'Subreddit';
    replies = json['replies'];
    title = json['title'] ?? '';
    kind = json['kind'] ?? 'self';
    text = json['text'] ?? '';
    images = json['images'] ?? [];
    createdAt = json['createdAt'] ?? '2017-07-21T17:32:28Z';
    locked = json['locked'] ?? false;
    isDeleted = json['isDeleted'] ?? false;
    sendReplies = json['sendReplies'] ?? false;
    nsfw = json['nsfw'] ?? false;
    spoiler = json['spoiler'] ?? false;
    votes = json['votes'] ?? 0;
    views = json['views'] ?? 0;
    commentCount = json['commentCount'] ?? 0;
    shareCount = json['shareCount'] ?? 0;
    suggestedSort = json['suggestedSort'] ?? '';
    scheduled = json['scheduled'] ?? false;
    flairId =
        json['flairId'] != null ? new FlairId.fromJson(json['flairId']) : null;
    isHidden = json['isHidden'] ?? false;
    isSaved = json['isSaved'] ?? false;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    postVoteStatus = json['postVoteStatus'].toString();
    isSpam = json['isSpam'] ?? false;
    url = (json['url'] != null) ? json['url'] : '';
    video = (json['video'] != null) ? json['video'] : '';
    if (kind == 'image') {
      maxHeightImageSize = await getMaxHeight(images ?? ['']);
    }
    imageNumber = 0;
    if (kind == 'video') {
      videoController = await getController(video);
    }
    approved = json['isApproved'] ?? false;
    removed = json['isRemoved'] ?? false;
  }
}

class FlairId {
  String? sId;
  String? text;
  String? backgroundColor;
  String? textColor;
  String? permission;

  FlairId(
      {this.sId,
      this.text,
      this.backgroundColor,
      this.textColor,
      this.permission});

  FlairId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
    permission = json['permission'];
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
}

class Author {
  String? sId;
  String? name;
  String? icon;

  Author({this.sId, this.name, this.icon});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
  }
}
