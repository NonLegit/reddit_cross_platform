import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditPost extends StatefulWidget {
  static const routeName = '/editpost-screen';
  const EditPost({super.key});

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
      validatedName = !name!.isEmpty;
      print(validatedName);
    });
  }

  _validateLink(link) {
    bool check = Uri.tryParse(link)?.hasAbsolutePath ?? false;
    setState(() {
      validatedLink = check;
      print(validatedLink);
    });
  }

  final _nameController = TextEditingController();
  final _linkController = TextEditingController();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyLink = GlobalKey<FormState>();
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
      body: TextField(
        enabled: true,
        style: TextStyle(fontSize: 15.0),
        showCursor: true,
        toolbarOptions: ToolbarOptions(copy: true, cut: true, paste: true),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        autofocus: true,
        maxLines: null,
        textAlign: TextAlign.start,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
      bottomNavigationBar: Container(
        height: 5.h,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: 18.h,
                        child: AlertDialog(
                          title: Text('Insert a link'),
                          actions: [
                            Form(
                              key: _formKeyLink,
                              child: TextFormField(
                                decoration: InputDecoration(hintText: 'Name'),
                                cursorColor: Colors.black,
                                controller: _nameController,

                                // validator: (value) => _validateName(value),
                              ),
                            ),
                            Form(
                              key: _formKeyName,
                              child: TextFormField(
                                decoration: InputDecoration(hintText: 'Link'),
                                cursorColor: Colors.black,
                                controller: _linkController,
                                //validator: (value) => _validateLink(value),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 17.h,
                                  height: 5.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                      _linkController.clear();
                                      _nameController.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
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
                                  width: 3.w,
                                ),
                                SizedBox(
                                  width: 17.h,
                                  height: 5.h,
                                  child: ElevatedButton(
                                    onPressed:
                                        (!validatedLink && !validatedName)
                                            ? () {
                                                Navigator.pop(context, true);
                                                _linkController.clear();
                                                _nameController.clear();
                                              }
                                            : null,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      primary: Colors.blue[800],
                                      // backgroundColor: Colors.blue[800],
                                    ),
                                    child: Text(
                                      'Insert',
                                      style: TextStyle(
                                          color:
                                              (!validatedLink && !validatedName)
                                                  ? Colors.white
                                                  : Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.link)),
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
                              primary: (NSFW) ? Colors.red : Colors.white),
                          onPressed: () {
                            setState(() {
                              NSFW = !NSFW;
                              print(NSFW);
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.eight_k_plus, color: Colors.black45),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                'NSFW',
                                style: TextStyle(
                                    color:
                                        (NSFW) ? Colors.white : Colors.black45),
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
                              primary: (spoiler) ? Colors.black : Colors.white),
                          onPressed: () {
                            setState(() {
                              spoiler = !spoiler;
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
                                    color: (spoiler)
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
    );
  }
}
