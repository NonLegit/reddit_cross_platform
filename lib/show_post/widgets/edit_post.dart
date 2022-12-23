import 'package:flutter/material.dart';
import 'package:post/show_post/provider/edit_post_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditPost extends StatefulWidget {
  static const routeName = '/editpost-screen';
  EditPost({super.key, this.editText, this.postId, this.NSFW, this.spoiler});

  String? editText;
  String? postId;
  bool? NSFW;
  bool? spoiler;
  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> with TickerProviderStateMixin {
  _editPost() {}

  bool _isShown = false;
  bool NSFW = false;
  bool spoiler = false;
  bool validatedLink = false;
  bool validatedName = false;
  late AnimationController controller;
  late Animation<double> offset;
  final _nameController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = new CurvedAnimation(
      parent: controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );

    super.initState();
  }

  _changeState() {
    setState(() {
      if (_isShown) {
        _isShown = !_isShown;
        controller.forward(from: 0.0);
      } else {
        _isShown = !_isShown;
        controller.reverse(from: 1.0);
      }
    });
  }

  _validateName(String? name) {
    setState(() {
      validatedName = !_nameController.text.isEmpty;
      print(validatedName);
    });
  }

  _validateLink() {
    //  bool check = Uri.tryParse(link)?.hasAbsolutePath ?? false;
    setState(() {
      validatedLink = _linkController.text.contains('.com');
      print(validatedLink);
    });
  }

  _saveEdit() {
    //Provider.of<EditPostProvider>(context).editPost(data, postId)
  }

  // final _formKeyName = GlobalKey<FormState>();
  // final _formKeyLink = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text(
          'Edit post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: () => _editPost(),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.blue.shade900),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.editText,
                enabled: true,
                style: TextStyle(fontSize: 15.0),
                showCursor: true,
                toolbarOptions:
                    ToolbarOptions(copy: true, cut: true, paste: true),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                autofocus: true,
                maxLines: null,
                textAlign: TextAlign.start,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            const Spacer(),
            Container(
              height: 5.h,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _changeState();
                      },
                      icon: Icon(Icons.more_vert)),
                  AnimatedBuilder(
                    animation: offset,
                    builder: (context, child) => Visibility(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 3.h,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: StadiumBorder(),
                                    side: BorderSide(color: Colors.black),
                                    primary: (widget.NSFW!)
                                        ? Colors.red
                                        : Colors.white),
                                onPressed: () {
                                  setState(() {
                                    widget.NSFW = !widget.NSFW!;
                                    print(NSFW);
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.eight_k_plus,
                                        color: Colors.black45),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'NSFW',
                                      style: TextStyle(
                                          color: (widget.NSFW!)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 3.h,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: StadiumBorder(),
                                    side: BorderSide(color: Colors.black),
                                    primary: (widget.spoiler!)
                                        ? Colors.black
                                        : Colors.white),
                                onPressed: () {
                                  setState(() {
                                    widget.spoiler = !widget.spoiler!;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.warning, color: Colors.black45),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'SPOILER',
                                      style: TextStyle(
                                          color: (widget.spoiler!)
                                              ? Colors.white
                                              : Colors.black45),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      visible: _isShown,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: ,
    );
  }
}
