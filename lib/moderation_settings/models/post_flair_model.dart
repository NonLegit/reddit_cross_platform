class PostFlairModel {
  String? sId;
  String? text;
  String? backgroundColor;
  String? textColor;
  bool? deleteFlair;

  PostFlairModel({this.sId, this.text, this.backgroundColor, this.textColor,this.deleteFlair});

  PostFlairModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['backgroundColor'] = this.backgroundColor;
    data['textColor'] = this.textColor;
    return data;
  }
}
