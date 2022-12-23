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
    owner = json['owner']['name'];
    ownerType = json['ownerType'];
    title = json['title'];
    json['comments'].forEach((comment) {
      createdAt = comment['createdAt'];
      votes = comment['votes'];
      text = comment['text'];
    });
  }
}
