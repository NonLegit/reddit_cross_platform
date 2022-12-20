// import 'package:flutter/material.dart';
// class MessagesClassModel {
//   String? sId;
//   String? type;
//   From? from;
//   From? to;
//   Subreddit? subreddit;
//   String? createdAt;

//   MessagesClassModel(
//       {this.sId,
//       this.type,
//       this.from,
//       this.to,
//       this.subreddit,
//       this.createdAt,
//       });

//   MessagesClassModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     type = json['type'];
//     from = json['from'] != null ? new From.fromJson(json['from']) : null;
//     to = json['to'] != null ? new From.fromJson(json['to']) : null;
//     subreddit = json['subreddit'] != null
//         ? new Subreddit.fromJson(json['subreddit'])
//         : null;
//     createdAt = json['createdAt'];
//   }

// }

// class From {
//   String? sId;
//   String? userName;

//   From({this.sId, this.userName});

//   From.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userName = json['userName'];
//   }

// }

// class Subreddit {
//   String? sId;
//   String? fixedName;
//   String? name;
//  // List<Null>? rules;
//   String? icon;
//   String? backgroundImage;

//   Subreddit(
//       {this.sId,
//       this.fixedName,
//       this.name,
//     //  this.rules,
//       this.icon,
//       this.backgroundImage});

//   Subreddit.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     fixedName = json['fixedName'];
//     name = json['name'];
//     icon = json['icon'];
//     backgroundImage = json['backgroundImage'];
//   }

// }
