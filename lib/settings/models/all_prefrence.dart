
class Prefrence {
  bool? canbeFollowed;
  bool? nsfw;
  String? gender;
  bool? adultContent;
  bool? autoplayMedia;
  String? displayName;
  String? profilePicture;
  String? profileBackground;
  String? description;
  String? email;
  List<SocialLinks>? socialLinks;
  String? country;
  String? sortHomePosts;

  Prefrence(
      {this.canbeFollowed,
      this.nsfw,
      this.gender,
      this.adultContent,
      this.autoplayMedia,
      this.displayName,
      this.profilePicture,
      this.profileBackground,
      this.description,
      this.email,
      this.socialLinks,
      this.country});

  Prefrence.fromJson(
    Map<String, dynamic> json,
  ) {
    canbeFollowed = json['canbeFollowed'];
    nsfw = json['nsfw'];
    gender = json['gender'];
    adultContent = json['adultContent'];
    autoplayMedia = json['autoplayMedia'];
    displayName = json['displayName'];
    profilePicture = json['profilePicture'];
    profileBackground = json['profileBackground'];
    description = json['description'];
    email = json['email'];
    if (json['socialLinks'] != null) {
      socialLinks = <SocialLinks>[];
      json['socialLinks'].forEach((v) {
        socialLinks!.add(new SocialLinks.fromJson(v));
      });
    }
    country = json['country'];

    ///coming from the prefrence but provider will handle it
    sortHomePosts = json['sortHomePosts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canbeFollowed'] = this.canbeFollowed;
    data['nsfw'] = this.nsfw;
    data['gender'] = this.gender;
    data['adultContent'] = this.adultContent;
    data['autoplayMedia'] = this.autoplayMedia;
    data['displayName'] = this.displayName;
    data['profilePicture'] = this.profilePicture;
    data['profileBackground'] = this.profileBackground;
    data['description'] = this.description;
    data['email'] = this.email;
    if (this.socialLinks != null) {
      data['socialLinks'] = this.socialLinks!.map((v) => v.toJson()).toList();
    }
    data['country'] = this.country;
    return data;
  }
}

class SocialLinks {
  Social? social;
  String? sId;
  String? displayText;
  String? userLink;

  SocialLinks({this.social, this.sId, this.displayText, this.userLink});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    social =
        json['social'] != null ? new Social.fromJson(json['social']) : null;
    sId = json['_id'];
    displayText = json['displayText'];
    userLink = json['userLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    data['_id'] = this.sId;
    data['displayText'] = this.displayText;
    data['userLink'] = this.userLink;
    return data;
  }
}

class Social {
  String? baseLink;
  String? placeholderLink;
  String? sId;
  String? type;
  String? icon;
  String? check;

  Social(
      {this.baseLink,
      this.placeholderLink,
      this.sId,
      this.type,
      this.icon,
      this.check});

  Social.fromJson(Map<String, dynamic> json) {
    baseLink = json['baseLink'];
    placeholderLink = json['placeholderLink'];
    sId = json['_id'];
    type = json['type'];
    icon = json['icon'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseLink'] = this.baseLink;
    data['placeholderLink'] = this.placeholderLink;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['check'] = this.check;
    return data;
  }
}
