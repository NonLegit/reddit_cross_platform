import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:post/messages/Provider/message_provider.dart';
import 'package:provider/provider.dart';

import '../models/user_message.dart';
import 'reply_message_screen.dart';

class ShowMessageBody extends StatefulWidget {
  ShowMessageBody({super.key, this.appBarText, this.list, this.messageId});
  String? appBarText;
  String? messageId;
  List<ShowMessagesModel>? list = [];
  static const routeName = '/show-message-body';

  @override
  State<ShowMessageBody> createState() => _ShowMessageBodyState();
}

class _ShowMessageBodyState extends State<ShowMessageBody> {
  //List<String> messageBody = [];
  //String replyMessage = '';
  _saveReply(replyMessage) async {
    //print(replyMessage);
    widget.list!.forEach((element) {
      print(element.sId);
    });
    print('hiiiiiiiiiiii heal');
    print(widget.messageId);
    Provider.of<MessageProvider>(context, listen: false).replyMessage(
        {'text': replyMessage}, context, widget.messageId).then((value) {
      setState(() {
        // widget.list!.add(ShowMessagesModel(
        //     toUsername: widget.appBarText,
        //     text: replyMessage,
        //     createdAt: DateTime.now().toString(),
        //     type: 'userMessage'));
      });
    });
  }

  String getTimeOfNotification(date) {
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

  _acceptModeration(subredditName) {
    print(subredditName);
    Provider.of<MessageProvider>(context, listen: false)
        .acceptSubredditInvite(context, subredditName)
        .then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarText!
            //  'u/BasmaElhoseny01'
            ),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        backgroundColor: Colors.grey[50],
        titleSpacing: 0,
        elevation: 2,
        shadowColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(widget.list![0].subjectText!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true),
              ),
              const Divider(),
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              //softWrap: true,
                              text: TextSpan(
                                  text: '${widget.list![index].fromUsername}',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                  children: [
                                    const WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.grey,
                                        size: 4,
                                      ),
                                    ),
                                    TextSpan(
                                        text: getTimeOfNotification(widget
                                            .list![index].createdAt
                                            .toString()),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10))
                                  ])

                              //overflow: TextOverflow.clip,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.list![index].text!,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
                itemCount: widget.list!.length,
              ),
              if (widget.list![0].type == 'subredditModeratorInvite')
                TextButton(
                    onPressed: () {
                      _acceptModeration(widget.list![0].subredditName);
                    },
                    child: Text(
                      'Click to accept',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )),
              //const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (widget.list![0].type == 'userMessage')
          ? Container(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.height,
              color: Colors.white,
              padding: const EdgeInsets.all(3),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey.shade300),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReplyMessageScreen(
                                savePost: _saveReply,
                              )));
                  //Navigator.of(context).pushNamed(ReplyMessageScreen.routeName);
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Reply to message',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,

                        //backgroundColor: Colors.grey
                      )),
                ),
              ),
            )
          : null,
    );
  }
}
