import 'package:flutter/material.dart';
import '../models/search_post.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:html/parser dart';
import 'dart:convert';

class PostView extends StatelessWidget {
  PostData postData;
  PostView({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    // print('r' + jsonEncode(postData.text!));
    String date = '';
    final createdDate = DateTime.parse(postData.createdAt as String);
    // final createdDate = DateTime.parse('2022-12-06T08:55:28.000Z');
    if (DateTime.now().year - createdDate.year > 0) {
      date = '${DateTime.now().year - createdDate.year}yr';
    } else if (DateTime.now().month - createdDate.month > 0) {
      date = '${DateTime.now().month - createdDate.month}mo';
    } else if (DateTime.now().day - createdDate.day > 0) {
      date = '${DateTime.now().day - createdDate.day}day';
    } else if (DateTime.now().hour - createdDate.hour > 0) {
      date = '${DateTime.now().hour - createdDate.hour}hr';
    } else {
      date = '${DateTime.now().minute - createdDate.minute}min';
    }
    return ListTile(
      title: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(
          backgroundImage: NetworkImage('${postData.author!.profilePicture}'),
          backgroundColor: Colors.black,
        ),
        title: Text('r/${postData.owner!.name}'),
        subtitle: Text('u/${postData.author!.displayName} . $date '),
      ),
      subtitle: ((postData.kind!) == 'image')
          ? Html(
              data: jsonEncode(postData.title!)
                  .substring(1, jsonEncode(postData.title!).length - 1),
              tagsList: Html.tags,
            )
          : Html(
              data: jsonEncode(postData.text!)
                  .substring(1, jsonEncode(postData.text!).length - 1),
              tagsList: Html.tags,
            ),
      trailing: ((postData.kind!) == 'image' && postData.images!.length > 0)
          ? Image(
              image: NetworkImage(postData.images![0]),
            )
          : null,
    );
  }
}
