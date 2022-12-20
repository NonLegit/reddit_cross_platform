class ModeratedSubbredditUserData {
  String? icon;
  String? subredditName;
  ModeratedSubbredditUserData(
      {required this.icon, required this.subredditName,
      });

  ModeratedSubbredditUserData.fromJson(Map<String, dynamic> json) {
    icon = json['icon'].toString();
    subredditName = json['fixedName'].toString();

  }
}
