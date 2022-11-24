

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../create_community/screens/create_community.dart';
import '../../icons/icon_broken.dart';
import '../../myprofile/screens/myprofile_screen.dart';

class endDrawer extends StatefulWidget {
  const endDrawer({Key? key}) : super(key: key);
  @override
  State<endDrawer> createState() => _endDrawerState();
}

class _endDrawerState extends State<endDrawer> {
  bool isOnline=true;
  @override
  Widget build(BuildContext context) {
    return   Drawer(
      elevation: 20.0,
      width: 250.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80.0,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 250.0,
                height: 250.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfDtKbIed-hxraIzyhrh3idtNM-BDhP8dvZT6sKo7tAZsA&oe=6396FDE4'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'u/' + 'Ahmed Fawzy',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: 200.0,
                        height: 30.0,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (isOnline) {
                                isOnline = false;
                              } else {
                                isOnline = true;
                              }
                            });
                          },
                          icon: CircleAvatar(
                            radius: 4,
                            backgroundColor:
                            isOnline ? Colors.green : Colors.grey[200],
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.grey[200]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: isOnline
                                              ? Colors.green
                                              : Colors.black54)))),
                          label: Text(
                            "Online Status: " + "${isOnline ? "On" : "Off"}",
                            style: TextStyle(
                                color:
                                isOnline ? Colors.green : Colors.black54),
                          ),
                        ),
                      ),
                    ])),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.account_circle_outlined),
              title: Text(
                'My profile',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MyProfileScreen.routeName, arguments: 'ahmed');
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(IconBroken.Category),
              title: Text(
                'Create a community',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(CreateCommunity.routeName);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.save),
              title: Text(
                'Saved',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(Icons.access_time_outlined),
              title: Text(
                'History',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            ListTile(
              horizontalTitleGap: 3,
              leading: Icon(IconBroken.Setting),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
