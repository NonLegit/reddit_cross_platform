import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class schedulePostScreen extends StatefulWidget {
  const schedulePostScreen({Key? key}) : super(key: key);

  @override
  State<schedulePostScreen> createState() => _schedulePostScreenState();
}

class _schedulePostScreenState extends State<schedulePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 30.0,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Schedule Post",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          actions: [TextButton(onPressed: () {}, child: Text("Save"))],
        ),
        body: Column(children: [
          SizedBox(
            height: 7.0,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: Row(
              children: [Text("Starts")],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: Row(
              children: [
                Expanded(child: Text("Repeat weekly on Friday")),
                /*Padding(
                  padding: const EdgeInsetsDirectional.only(end: 15.0),
                  child: Container(
                    width: 100,
                    height: 40,
                    child: LiteRollingSwitch(
                     width: 100,
                      value: true,
                      colorOn: Colors.blue,
                      colorOff: Colors.grey,
                      onSwipe: (){},
                      onDoubleTap:  (){},
                      onChanged: (bool ) {  },
                      onTap:  (){},
                    ),
                  ),
                )*/
              ],
            ),
          )
        ]));
  }
}
