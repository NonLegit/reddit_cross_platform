class userSubredditsResponse {
  String? icon;
  String? id;
  String? subredditName;
  int? membersCount;
  String? description;

  userSubredditsResponse(
      {this.icon,
      this.id,
      this.subredditName,
      this.membersCount,
      this.description});

  userSubredditsResponse.fromJson(Map<String, dynamic> json) {
    icon = //json['icon'];
        'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/31654_100661579985731_7481445_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGSUBKXvYU09Fg3jW1ZqDqRzHX4pfhTHOfMdfil-FMc57pdEjEJ1KtfYrGvqSbrlQffC8pXQZoBw7mz55jMjSUT&_nc_ohc=oke4MZxR9cMAX8wl9LW&_nc_ht=scontent.fcai19-6.fna&oh=00_AfCg5WFYggtU2b5vaQ87KBcI8KSeZnIpk3hhGRXayNFeyg&oe=63B31699';
    id = json['_id'];
    subredditName = json['fixedName'];
    membersCount = json['membersCount'];
    description = 'hello brother'; //json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = //this.icon;
        'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/31654_100661579985731_7481445_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGSUBKXvYU09Fg3jW1ZqDqRzHX4pfhTHOfMdfil-FMc57pdEjEJ1KtfYrGvqSbrlQffC8pXQZoBw7mz55jMjSUT&_nc_ohc=oke4MZxR9cMAX8wl9LW&_nc_ht=scontent.fcai19-6.fna&oh=00_AfCg5WFYggtU2b5vaQ87KBcI8KSeZnIpk3hhGRXayNFeyg&oe=63B31699';
    data['_id'] = this.id;
    data['fixedName'] = this.subredditName;
    data['membersCount'] = this.membersCount;
    data['description'] = this.description;
    return data;
  }
}
