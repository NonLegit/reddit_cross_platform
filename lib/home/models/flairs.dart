class FlairModel {
  String? sId;
  String? text;
  String? backgroundColor;
  String? textColor;
  String? permissions;

  FlairModel(
      {this.sId,
        this.text,
        this.backgroundColor,
        this.textColor,
        this.permissions});

  FlairModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
    permissions = json['permissions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['backgroundColor'] = this.backgroundColor;
    data['textColor'] = this.textColor;
    data['permissions'] = this.permissions;
    return data;
  }
}