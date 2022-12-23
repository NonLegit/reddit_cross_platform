import 'package:flutter/material.dart';
import 'package:post/comments/providers/comments_provider.dart';
import 'package:provider/provider.dart';

class AddReplyScreen extends StatefulWidget {
  const AddReplyScreen({Key? key}) : super(key: key);

  @override
  State<AddReplyScreen> createState() => _AddReplyScreenState();
}

class _AddReplyScreenState extends State<AddReplyScreen> {
  late String parentId;
  late String comment;
  late String authorName;
  late String createdAt;
  TextEditingController controller = TextEditingController();

  static String calculateHowOld(date) {
    String howOld;
    final difference = DateTime.now().difference(DateTime.parse(date));
    if (difference.inDays >= 365) {
      howOld = '${difference.inDays ~/ 365}y';
    } else if (difference.inDays >= 30) {
      howOld = '${difference.inDays ~/ 30}mo';
    } else if (difference.inDays >= 1) {
      howOld = '${difference.inDays}d';
    } else if (difference.inMinutes >= 60) {
      howOld = '${difference.inHours}h';
    } else if (difference.inSeconds >= 60) {
      howOld = '${difference.inMinutes}m';
    } else {
      howOld = '${difference.inSeconds}s';
    }
    return howOld;
  }

  @override
  void didChangeDependencies() {
    var temp =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    parentId = temp['parentId'];
    comment = temp['comment'];
    authorName = temp['authorName'];
    createdAt = temp['createdAt'];

    super.didChangeDependencies();
  }

  createComment(String text) async {
    if (await Provider.of<PostCommentsProvider>(context, listen: false)
        .postComment(parentId, 'Comment', text)) {}
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
            "Reply",
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
              Row(
                children: [
                  Text(
                    authorName,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  // (widget.userName == widget.authorName)
                  //     ? Icon(
                  //         Icons.person,
                  //         color: Colors.blue[600],
                  //         size: 18,
                  //       )
                  //     : const SizedBox(),

                  Container(
                    width: 3,
                    height: 3,
                    margin: const EdgeInsetsDirectional.only(end: 4, start: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    calculateHowOld(createdAt),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(comment),
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
                      hintText: "Your reply", border: InputBorder.none),
                ),
              ),
            ],
          ),
        ));
  }
}
