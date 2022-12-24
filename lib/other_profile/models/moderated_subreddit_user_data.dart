class ModeratedSubbredditUserData {
  String? icon;
  String? subredditName;
  ModeratedSubbredditUserData(
      {required this.icon, required this.subredditName,
      });
  // ===================================this function used to===========================================//
//=================to change json to model===========================//
  ModeratedSubbredditUserData.fromJson(Map<String, dynamic> json) {
    icon = json['icon'].toString();
    subredditName = json['fixedName'].toString();

  }
}
