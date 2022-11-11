import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reddit/layout/home_layout.dart';
import 'package:reddit/modules/createpost/finalpost.dart';
import 'package:reddit/modules/createpost/posttocommunity.dart';
import 'package:reddit/shared/style/icon_broken.dart';

class createPostScreen extends StatefulWidget {
  const createPostScreen({Key? key}) : super(key: key);

  @override
  State<createPostScreen> createState() => _createPostScreenState();
}

class _createPostScreenState extends State<createPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
     /* appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon:Icon(Icons.close,size: 32.0,),
          color: Colors.black45,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 30.0),
            child: MaterialButton(onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>finalPostScreen())
              );
            },
             elevation: 0.0,
              height: 0.0,
             minWidth: 80.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              color: Colors.grey[100],
              child: Text("Next",
              style: TextStyle(
                color: Colors.grey[400],
              ),
              ),
            ),
          )
        ],
      ),*/
      body:  Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: TextFormField(
                  enabled: true,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                    showCursor: true,
     textAlign: TextAlign.start,
     decoration: InputDecoration(
                 hintText: "An interesting title",

                 border: InputBorder.none
    //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
     )
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: TextFormField(
                    enabled: false,
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                    showCursor: true,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none
                      //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
                    )
                ),
              ),
            ),

                 ListTile(
                   leading: Icon(IconBroken.Image_2),
                   title: Text("Image"),
                   horizontalTitleGap: 0.0,
                 ),
                  ListTile(
                    leading: Icon(IconBroken.Video),
                    title: Text("Video"),
                    horizontalTitleGap: 0.0,
                  ),
                  ListTile(
                    leading: Icon(IconBroken.Paper),
                    title: Text("Text"),
                    horizontalTitleGap: 0.0,
                  ),
                  ListTile(
                    leading: Icon(IconBroken.Bookmark),
                    title: Text("Link"),
                    horizontalTitleGap: 0.0,
                  ),
               ],
        ),

    );
  }
}

