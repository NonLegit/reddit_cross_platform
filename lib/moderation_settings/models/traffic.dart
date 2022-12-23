class Traffic {
  List<TrafficData>? data;

  Traffic({this.data});

  Traffic.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TrafficData>[];
      json['data'].forEach((v) {
        data!.add(new TrafficData.fromJson(v));
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

class TrafficData {
  int? iId;
  int? numOfUsers;

  TrafficData({this.iId, this.numOfUsers});

  TrafficData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    numOfUsers = json['numOfUsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['numOfUsers'] = this.numOfUsers;
    return data;
  }
}
