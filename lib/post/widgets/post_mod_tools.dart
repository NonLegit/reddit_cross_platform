import 'package:flutter/material.dart';
import 'package:post/post/widgets/post_mod_popup.dart';

class PostModTools extends StatefulWidget {
  final bool isApproved;
  final bool isNSFW;
  final bool isSpoiler;
  final Function approve;
  final Function nsfw;
  final Function spoiler;

  const PostModTools(
      {super.key,
      required this.isApproved,
      required this.isNSFW,
      required this.isSpoiler,
      required this.approve,
      required this.nsfw,
      required this.spoiler});

  @override
  State<PostModTools> createState() =>
      _PostModTools(isApproved, isNSFW, isSpoiler);
}

class _PostModTools extends State<PostModTools> {
  bool isApproved;
  bool isNSFW;
  bool isSpoiler;
  _PostModTools(this.isApproved, this.isNSFW, this.isSpoiler);

  spoiler() {
    widget.spoiler();
    setState(() {
      isSpoiler = !isSpoiler;
    });
  }

  nsfw() {
    widget.nsfw();
    setState(() {
      isNSFW = !isNSFW;
    });
  }

  approve() {
    widget.approve();
    isApproved = !isApproved;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 2),
      child: Material(
        color: Theme.of(context).colorScheme.brightness == Brightness.light
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: isApproved ? null : approve,
                    child: Tooltip(
                      message: 'Approve',
                      child: Container(
                        padding: EdgeInsetsDirectional.all(10),
                        child: (!isApproved)
                            ? Icon(
                                Icons.done,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : Icon(
                                Icons.done,
                                color: Colors.green[500],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(25.0),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => PostModPopUp(
                      isApproved: isApproved,
                      approve: approve,
                      isNSFW: isNSFW,
                      isSpoiler: isSpoiler,
                      nsfw: nsfw,
                      spoiler: spoiler,
                    ),
                  );
                },
                child: Tooltip(
                  message: 'More options',
                  child: Container(
                      padding: EdgeInsetsDirectional.all(10),
                      child: Icon(
                        Icons.format_list_bulleted,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
