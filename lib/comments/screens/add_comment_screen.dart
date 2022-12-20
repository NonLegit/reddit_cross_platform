import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/comments/providers/comments_provider.dart';
import 'package:provider/provider.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({Key? key}) : super(key: key);

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  late String parentId;
  late String title;
  TextEditingController controller = TextEditingController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================Fetch subreddit data =======================================//

    var temp =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    parentId = temp['parentId'];
    title = temp['title'];
    super.didChangeDependencies();
  }

  createComment(String text) async {
    if (await Provider.of<PostCommentsProvider>(context, listen: false)
        .postComment(parentId, 'Post', text)) {
      print('created comment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add a comment",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: (controller.text.isNotEmpty)
                  ? () {
                      createComment(controller.text);
                      Navigator.pop(context);
                    }
                  : null,
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Column(
            children: [
              Text(title),
              Divider(
                height: 10,
              ),
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  enabled: true,
                  controller: controller,
                  style: const TextStyle(fontSize: 16.0),
                  showCursor: true,
                  cursorColor: Colors.blue,
                  cursorHeight: 20.0,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                      hintText: "write your comment here...",
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ));
  }
}
