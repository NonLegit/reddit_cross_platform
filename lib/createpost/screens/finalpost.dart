import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../icons/icon_broken.dart';
import './schedulepost.dart';

class finalPostScreen extends StatefulWidget {
  const finalPostScreen({Key? key}) : super(key: key);

  @override
  State<finalPostScreen> createState() => _finalPostScreenState();
}

class _finalPostScreenState extends State<finalPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 40.0),
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: Icon(
                  IconBroken.Arrow___Left_2,
                  size: 32.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 250.0,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 30.0),
                child: MaterialButton(
                  onPressed: () {},
                  elevation: 0.0,
                  height: 40.0,
                  minWidth: 80.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.blue[900],
                  child: Text(
                    "post",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0),
            child: Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Text(
                        "ascdavwVWRV",
                        style: TextStyle(color: Colors.black),
                      ),
                      label: Icon(
                        IconBroken.Arrow___Down_2,
                        color: Colors.black,
                        size: 15,
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        //fixedSize: MaterialStateProperty.all(Size(100.0, 20.0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                TextButton(
                    onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Center(
                                          child: Text("Community Standards"))),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("understand"))
                                ],
                              ),
                            )),
                    child: Text("Rules"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              enabled: false,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    fixedSize: MaterialStateProperty.all(Size(130.0, 20.0)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[100],
                    ),
                  ),
                  label: Text(
                    "NSFW",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  icon: Text(
                    "18",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  )),
              SizedBox(
                width: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  fixedSize: MaterialStateProperty.all(Size(122.0, 20.0)),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.grey[100],
                  ),
                ),
                label: Text(
                  "Spoiler",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                icon: Icon(
                  IconBroken.Danger,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          ListTile(
            horizontalTitleGap: 0.0,
            title: Text("Add flair"),
            leading: Icon(IconBroken.Edit),
            trailing: Icon(IconBroken.Arrow___Right_2),
          ),
          Divider(
            height: 10.0,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => schedulePostScreen()));
            },
            horizontalTitleGap: 0.0,
            title: Text("Schedule Post"),
            leading: Icon(Icons.access_time_outlined),
            trailing: Icon(IconBroken.Arrow___Right_2),
          ),
        ],
      ),
    );
  }
}
