import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/home/screens/saved.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../home/screens/history.dart';
import '../../create_community/screens/create_community.dart';
import '../../icons/icon_broken.dart';
import '../../myprofile/screens/myprofile_screen.dart';
import '../../settings/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
class endDrawer extends StatelessWidget {

   endDrawer({
    required this.controller
    ,Key? key}) : super(key: key);
  final HomeController controller;
  bool isOnline = true;

  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') as String;
  }

  String userName = 'A';

  @override
  Widget build(BuildContext context) {
    print(userName);
    return FutureBuilder(
      future: getUserName(),
      builder: (context, snapshot) => Drawer(
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
                  width: 220.0,
                  height: 220.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              '${controller.myProfile!.profilePicture}'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'u/$userName',
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
                              // setState(() {
                              //   if (isOnline) {
                              //     isOnline = false;
                              //   } else {
                              //     isOnline = true;
                              //   }
                              // });
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
                                        borderRadius:
                                        BorderRadius.circular(20.0),
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
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  GestureDetector(
                     onTap: (){
                       showDialog(
                         context: context,
                         builder: (ctx) => AlertDialog(
                             content: Container(
                                 decoration: BoxDecoration(
                                   borderRadius:BorderRadius.circular(20),
                                 ),
                                 width: MediaQuery.of(context).size.width/1,
                                 height: MediaQuery.of(context).size.height/2,
                                 child: (
                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children:  [
                                         SizedBox(height: 30,),
                                         CircleAvatar(
                                           radius:70,
                                           backgroundImage: NetworkImage("${controller.myProfile!.profilePicture}"),
                                         ),
                                         SizedBox(height: 130,),
                                         Padding(
                                           padding: const EdgeInsetsDirectional.only(end: 30),
                                           child: Text(
                                             'u/${controller.myProfile!.displayName}',
                                             style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Expanded(
                                           child: Row(
                                             children: [
                                               Expanded(
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text("${controller.myProfile!.postKarma}"),
                                                      Text("Post Karma",
                                                        style: TextStyle(
                                                            color: Colors.grey[400],
                                                            fontSize: 14
                                                        ),
                                                      ),
                                                   ],
                                                 ),
                                               ),
                                               SizedBox(width:20,),
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text("${controller.myProfile!.commentkarma}"),
                                                    Text("Comment Karma",
                                                   style: TextStyle(
                                                     color: Colors.grey[400],
                                                     fontSize: 14
                                                   ),
                                                   ),
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                         SizedBox(height: 10,),
                                         Padding(
                                           padding: const EdgeInsetsDirectional.only(end: 10),
                                           child:  ListTile(
                                             onTap: ()
                                             {
                                               Navigator.of(context).pushNamed(MyProfileScreen.routeName,
                                                   arguments: userName);
                                             },
                                             leading: Icon(Icons.account_circle,color: Colors.black,),
                                             title: Text("View profile",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                             horizontalTitleGap: 0,
                                           ),
                                         )
                                       ],
                                     )
                                 )
                             )
                         ),
                       );
                     },
                      child: Row(
                    children: [
                      Icon(Icons.ac_unit_outlined,color: Colors.blue[700],),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${controller.myProfile!.postKarma}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text("karma",
                          style: TextStyle(
                            color: Colors.grey
                          ),
                          )
                        ],
                      )
                    ],
                  )),
                 SizedBox(width: 10,),

                    SizedBox(width: 10,),
                    GestureDetector(child: Row(
                      children: [
                        Icon(Icons.text_snippet_rounded,color: Colors.blue[700],),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("1m 2d",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("Reddit ago",
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                  ],
                ),
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
                  Navigator.of(context).pushNamed(MyProfileScreen.routeName,
                      arguments: userName);
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
                 Get.to(Saved());
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
                 Get.to(History());
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
                  Navigator.of(context).pushNamed(Settings.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}