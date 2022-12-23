import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:post/comments/screens/add_reply_screen.dart';
import '../models/comment_model.dart';
import 'comment_popup_menu.dart';

class CommentFooter extends StatefulWidget {
  final int commentVoteStatus;
  final int votes;
  final CommentModel data;
  const CommentFooter(
      {super.key,
      required this.commentVoteStatus,
      required this.votes,
      required this.data});

  @override
  State<CommentFooter> createState() =>
      _CommentFooterState(commentVoteStatus, votes);
}

class _CommentFooterState extends State<CommentFooter> {
  int commentVoteStatus;
  int votes;
  _CommentFooterState(this.commentVoteStatus, this.votes);
// upVote() async {
//     if (postVoteStatus != 1) {
//       if (await Provider.of<PostProvider>(context, listen: false)
//           .updateVotes(widget.id, 1)) {
//         setState(() {
//           if (postVoteStatus == -1) {
//             votes = votes + 2;
//             widget.data.votes = (widget.data.votes! + 2);
//           } else {
//             ++votes;
//             widget.data.votes = (widget.data.votes! + 1);
//           }
//           postVoteStatus = 1;
//           widget.data.postVoteStatus = 1.toString();
//         });
//       }
//     } else {
//       if (await Provider.of<PostProvider>(context, listen: false)
//           .updateVotes(widget.id, 0)) {
//         setState(() {
//           postVoteStatus = 0;
//           widget.data.postVoteStatus = 0.toString();
//           widget.data.votes = (widget.data.votes! - 1);
//           --votes;
//         });
//       }
//     }
//   }

//   downVote() async {
//     if (postVoteStatus != -1) {
//       if (await Provider.of<PostProvider>(context, listen: false)
//           .updateVotes(widget.id, -1)) {
//         setState(() {
//           if (postVoteStatus == 1) {
//             votes = votes - 2;
//             widget.data.votes = (widget.data.votes! - 2);
//           } else {
//             --votes;
//             widget.data.votes = (widget.data.votes! - 1);
//           }
//           postVoteStatus = -1;
//           widget.data.postVoteStatus = (-1).toString();
//         });
//       }
//     } else {
//       if (await Provider.of<PostProvider>(context, listen: false)
//           .updateVotes(widget.id, 0)) {
//         setState(() {
//           postVoteStatus = 0;
//           widget.data.postVoteStatus = 0.toString();

//           ++votes;
//           widget.data.votes = (widget.data.votes! + 1);
//         });
//       }
//     }
//   }

  upVote() {}
  downVote() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 10, end: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommentPopUpMenu(isSaved: true),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              print(widget.data.sId);
              print(widget.data.text);
              print(widget.data.author?.userName);
              print(widget.data.createdAt);
              Get.to(AddReplyScreen(), arguments: {
                'parentId': widget.data.sId,
                'comment': widget.data.text,
                'authorName': widget.data.author?.userName,
                'createdAt': widget.data.createdAt,
              });
            },
            child: Row(
              children: [
                Icon(
                  Entypo.level_up,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                highlightColor: Colors.orange[300],
                focusColor: Colors.orange[300],
                splashColor: Colors.orange[300],
                hoverColor: Colors.orange[300],
                borderRadius: BorderRadius.circular(25.0),
                onTap: upVote,
                child: Tooltip(
                  message: 'Upvote',
                  child: Container(
                    padding: EdgeInsetsDirectional.all(8),
                    child: (commentVoteStatus != 1)
                        ? Icon(
                            Typicons.up_outline,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : Icon(
                            Typicons.up,
                            color: Colors.red[400],
                          ),
                  ),
                ),
              ),
              Text(NumberFormat.compact().format(votes).toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
              InkWell(
                highlightColor: Colors.indigo[100],
                focusColor: Colors.indigo[100],
                splashColor: Colors.indigo[100],
                hoverColor: Colors.indigo[100],
                borderRadius: BorderRadius.circular(25.0),
                onTap: downVote,
                child: Tooltip(
                  message: 'Downvote',
                  child: Container(
                    padding: EdgeInsetsDirectional.all(8),
                    child: (commentVoteStatus != -1)
                        ? Icon(
                            Typicons.down_outline,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : Icon(
                            Typicons.down,
                            color: HexColor('#7192FE'),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
