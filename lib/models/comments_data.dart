class CommentsData {
  String? title;
  String? owner;
  String? ownerType;
  String? createdAt;
  int? votes;
  String? text;
  CommentsData(
      {required this.title,
      required this.owner,
      required this.ownerType,
      required this.createdAt,
      required this.votes,
      required this.text});
  CommentsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    owner = json['owner'];
    ownerType = json['ownerType'];
    createdAt = json['createdAt'];
    votes = json['votes'];
    text = json['text'];
  }
}
