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

  upVote() {}
  downVote() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CommentPopUpMenu(isSaved: true),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(const AddReplyScreen(), arguments: {
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
                    padding: const EdgeInsetsDirectional.all(8),
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
                    padding: const EdgeInsetsDirectional.all(8),
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
