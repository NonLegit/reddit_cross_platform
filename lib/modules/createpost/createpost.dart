import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
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
            padding: const EdgeInsetsDirectional.only(end: 20.0),
            child: Container(
            width:80.0 ,
             // height: 20.0,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: MaterialButton(onPressed: (){},
               height: 40.0,

                child: Text("Next",
                style: TextStyle(color: Colors.grey[400]),),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10.0),
            child: TextFormField(
              enabled: true,
              style: TextStyle(
                fontSize: 20.0
              ),
                showCursor: true,
     textAlign: TextAlign.start,
     decoration: InputDecoration(
             labelText: "An interesting title",

             border: InputBorder.none
    //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
     )
            ),
          ),
        ],
      ),
    );
  }
}
