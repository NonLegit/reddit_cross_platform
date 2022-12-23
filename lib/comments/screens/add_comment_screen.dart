import 'package:flutter/material.dart';
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
    var temp =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    parentId = temp['parentId'];
    title = temp['title'];
    super.didChangeDependencies();
  }

  createComment(String text) async {
    if (await Provider.of<PostCommentsProvider>(context, listen: false)
        .postComment(parentId, 'Post', text)) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
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
              child: const Text(
                "Post",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.all(10),
          child: Column(
            children: [
              Text(title),
              const Divider(
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
