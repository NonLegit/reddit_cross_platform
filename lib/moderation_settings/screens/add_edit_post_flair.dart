import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post/moderation_settings/models/post_flair_model.dart';
import 'package:post/moderation_settings/provider/post_flair_provider.dart';
import 'package:post/moderation_settings/screens/post_flair.dart';
import 'package:post/moderation_settings/screens/post_flair_settings.dart';
import 'package:provider/provider.dart';

import '../widgets/alert_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class AddAndEditPostFllair extends StatefulWidget {
  AddAndEditPostFllair(
      {super.key,
      this.deleteFlair,
      this.backgroundColorText,
      this.changed,
      this.subredditName,
      this.post,
      this.textColor1,
      this.counter});

  static const routeName = '/add-edit-post-flair';
  PostFlairModel? post;
  bool? deleteFlair;
  String? changed = 'Type to edit';
  String? backgroundColorText;
  bool? textColor = false;
  String? textColor1;
  String? subredditName;
  int? counter = 0;
  @override
  State<AddAndEditPostFllair> createState() => AddAndEditPostFllairState();
}

class AddAndEditPostFllairState extends State<AddAndEditPostFllair> {
  bool _iselected = false;

  TextEditingController? _editPost = null;

  bool showWidget = false;

 //Used to change state of background color in text field
 //return value void
  _changeBackgroundColor(color) {
    setState(() {
      widget.backgroundColorText = color;
    });
  }
   //get remaining of characters 
   //return value void
  _setCounterState() {
    setState(() {
      widget.counter = 64 - widget.changed!.length;
    });
  }
  //Function called to show colors palette or not
  //return value void
  _showColorWidget() {
    setState(() {
      showWidget = !showWidget;
    });
  }
   //Used to change state of textColor in text field
    //return value void
  _changedTextColor() {
    setState(() {
      widget.textColor = !widget.textColor!;
      widget.textColor1 = (!widget.textColor!) ? '#000000' : '#FFFFFF';
    });
  }
  //Used to change state of text typed in text field
  //return value void
  _editText(value) {
    setState(() {
      widget.changed = value;
      _iselected = true;
    });
    _setCounterState();
  }

  @override
  void initState() {
    //  _init();
    super.initState();
    _setCounterState();
  }

//Call endpoint to clear selected flair
  _deletePostFlair() async {
    await Provider.of<PostFlairProvider>(context, listen: false)
        .deleteFlair(widget.subredditName, context, widget.post!.sId)
        .then((value) => Navigator.pop(context, true));
  }
//Save flair choose between whether flair was created recently to call addNewFlair or was being
//edited to call editFlair
  saveFlair() async {
    PostFlairModel post = PostFlairModel(
        text: widget.changed,
        backgroundColor: widget.backgroundColorText,
        textColor: widget.textColor1);
    if (!widget.deleteFlair!) {
      await Provider.of<PostFlairProvider>(context, listen: false)
          .addNewFlair(widget.subredditName, post, context)
          .then((value) {
        Navigator.pop(context, true);
      });
    } else {
      await Provider.of<PostFlairProvider>(context, listen: false)
          .editFlair(widget.subredditName, context, widget.post!.sId, post)
          .then((value) {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = _iselected
            ? await showDialog<bool>(
                context: context,
                builder: ((context) {
                  return const AlertDialog1();
                }),
              )
            : true;
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit post flair',
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              onPressed: () => saveFlair(),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.lightBlue),
              ),
            )
          ],
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          backgroundColor: Colors.grey[50],
          titleSpacing: 0,
          elevation: 2,
          shadowColor: Colors.white,
        ),
        body: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.only(top: 15, right: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  if (widget.deleteFlair!)
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black)),
                          color: Colors.white,
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Delete post flair',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  insetPadding: EdgeInsets.zero,
                                  content: SizedBox(
                                    width: 40.h,
                                    child: const Text(
                                      'You cannot undo this action',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  actions: [
                                    SizedBox(
                                      width: 20.h,
                                      height: 5.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          primary: Colors.grey[200],
                                          // backgroundColor: Colors.grey[200],
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.h,
                                      height: 5.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _deletePostFlair();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          primary: Colors.red,
                                          // backgroundColor: Colors.blue[800],
                                        ),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            // color: Colors.white,
                          )),
                    ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black)),
                        color: Colors.white,
                        shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(PostFlairSettings.routeName);
                        },
                        icon: const Icon(
                          Icons.settings,
                          // color: Colors.white,
                        )),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                  child: Text(
                widget.changed!,
                style: TextStyle(
                  color: widget.textColor1!.toColor(),
                  backgroundColor: widget.backgroundColorText!.toColor(),
                ),
              )),
              const Spacer(),
              if (showWidget) ShowColorWidget(onclick: _changeBackgroundColor),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.white),
                              bottom: BorderSide(color: Colors.white),
                              left: BorderSide(color: Colors.white),
                              right: BorderSide(color: Colors.white)),
                          color: Colors.white,
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {
                            _changedTextColor();
                          },
                          icon: Icon((!widget.textColor!)
                              ? Icons.brightness_6_outlined
                              : Icons.brightness_medium))),
                  Container(
                      decoration: BoxDecoration(
                          border: const Border(
                              top: BorderSide(color: Colors.white),
                              bottom: BorderSide(color: Colors.white),
                              left: BorderSide(color: Colors.white),
                              right: BorderSide(color: Colors.white)),
                          color: widget.backgroundColorText!.toColor(),
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: () {
                            _showColorWidget();
                          },
                          icon: Icon(
                            Icons.abc,
                            color: Colors.transparent,
                          ))),
                ],
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(
                    left: 15, bottom: 10, right: 15, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    const Text(
                      'Allows text only',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    TextFormField(
                      controller: _editPost,
                      cursorColor: Colors.black,
                      onChanged: (value) => _editText(value),
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          counterText: "",
                          filled: true,
                          hintText: 'Type to edit',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none),
                          suffixIcon: (widget.counter! > 0)
                              ? Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(widget.counter.toString()))
                              : null),
                      initialValue: widget.changed,
                      maxLength: 64,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//Build palette of color
class ShowColorWidget extends StatelessWidget {
  ShowColorWidget({
    super.key,
    required this.onclick,
  });
  Function onclick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.h,
      child: ListView(
        scrollDirection: Axis.horizontal, // Set the scroll direction
        shrinkWrap: true, // Set the shrinkWrap to true
        children: <Widget>[
          GestureDetector(
            onTap: () => onclick('#17202A'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.black),
          ),
          GestureDetector(
            onTap: () => onclick('#999999'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.grey),
          ),
          GestureDetector(
            onTap: () => onclick('#bcbcbc'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.black12),
          ),
          GestureDetector(
            onTap: () => onclick('#964B00'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.brown),
          ),
          GestureDetector(
            onTap: () => onclick('#2986cc'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.blue),
          ),
          GestureDetector(
            onTap: () => onclick('#008080'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.teal),
          ),
          GestureDetector(
            onTap: () => onclick('#00FFFF'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.cyan),
          ),
          GestureDetector(
            onTap: () => onclick('#00FF00'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.green),
          ),
          GestureDetector(
            onTap: () => onclick('#90EE90'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.lightGreen),
          ),
          GestureDetector(
            onTap: () => onclick('#FFFF00'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.yellow),
          ),
          GestureDetector(
            onTap: () => onclick('#FFA500'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.orange),
          ),
          GestureDetector(
            onTap: () => onclick('#FFCD91'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.orangeAccent),
          ),
          GestureDetector(
            onTap: () => onclick('#F25278'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.pink),
          ),
          GestureDetector(
            onTap: () => onclick('#FF0000'),
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 40,
                height: 40,
                color: Colors.red),
          ),

          // You can add as many as you want ...
        ],
      ),
    );
  }
}
