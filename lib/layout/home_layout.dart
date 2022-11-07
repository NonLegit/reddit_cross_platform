


import 'package:flutter_code_style/flutter_code_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit/modules/chat/chat.dart';
import 'package:reddit/modules/createpost/createpost.dart';
import 'package:reddit/modules/discover/discover.dart';

import 'package:reddit/modules/notifications/notifications.dart';
import 'package:reddit/shared/style/icon_broken.dart';
class homeLayoutScreen extends StatefulWidget {

  @override
  State<homeLayoutScreen> createState() => _homeLayoutScreenState();
}

class _homeLayoutScreenState extends State<homeLayoutScreen> {
  //indeces of each screen
  int currentIndex=0;

  // body screens
  List<Widget> screens = [


    discoverScreen(),
   createPostScreen(),
    chatScreen(),
    notificationsScreen(),
  ];
  //Model Reccent visited
  List<ListTile> recentlyVisited =[
    ListTile(leading:
    CircleAvatar(radius: 10,
      backgroundColor: Colors.blue,
    ),
      title: Text(
          "r/"+"Cross_platform"
      ),
      horizontalTitleGap: 0,
    ),
    ListTile(leading:
    CircleAvatar(radius: 10,
      backgroundColor: Colors.blue,
    ),
      title: Text(
          "r/"+"Egypt"
      ),
      horizontalTitleGap: 0,
    ),
    ListTile(leading:
    CircleAvatar(radius: 10,
      backgroundColor: Colors.blue,
    ),
      title: Text(
          "r/"+"memes"
      ),
      horizontalTitleGap: 0,
    ),
  ];
  // COMMUNITIES YOU ARE MODERATOR IN
  //Model Reccent visited
  List<ListTile> Communoties =[
    ListTile(
      trailing: IconButton(onPressed: (){},icon: Icon(IconBroken.Star,)),
       leading:
    CircleAvatar(radius: 10,
      backgroundColor: Colors.blue,
    ),
      title: Text(
          "r/"+"Cross_platform"
      ),
      horizontalTitleGap: 0,
    ),
    ListTile(
      trailing: IconButton(onPressed: (){},icon: Icon(IconBroken.Star,)),
      leading:
    CircleAvatar(radius: 10,
      backgroundColor: Colors.blue,
    ),
      title: Text(
          "r/"+"Egypt"
      ),
      horizontalTitleGap: 0,
    ),
    ListTile(
      trailing: IconButton(onPressed: (){},icon: Icon(IconBroken.Star,)),
      leading:
    CircleAvatar(radius: 10,
      backgroundColor: Colors.blue,
    ),
      title: Text(
          "r/"+"memes"
      ),
      horizontalTitleGap: 0,
    ),
  ];

  // Icons when expansion
  dynamic icRecent =Icon(IconBroken.Arrow___Right_2);
  dynamic icModerating =Icon(IconBroken.Arrow___Right_2);
  dynamic icYourCommunities =Icon(IconBroken.Arrow___Right_2);
  // bools
  bool isRecentlyVisitedPannelExpanded =true;
  bool isModeratingPannelExpanded =false;
  bool isOnline=true;
  //KEYS
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  // drawer functions
  void showDrawer(BuildContext context)
  {
    Scaffold.of(context).openDrawer();
  }
  void showEndDrawer(BuildContext context)
  {
    Scaffold.of(context).openEndDrawer();
  }
// for dropdown list
  String dropValue="Home";
  List<DropdownMenuItem>dropdownItems=[DropdownMenuItem(child: ButtonBar(children: [Text("Home")],)),DropdownMenuItem(child: ButtonBar(children: [Text("Popular")],))];



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
       elevation: 1.0,
       backgroundColor: Colors.white,
       leading:  Builder(
         builder: (context) {
           return IconButton(onPressed:() =>showDrawer(context) ,
               icon :Icon(Icons.menu_rounded,color: Colors.black,size: 30),
           );
         }
       ),
       title:
           ElevatedButton.icon(onPressed: (){print("ell");},

             icon:  Text("Home",
           style: TextStyle(
             color: Colors.black,
         fontSize: 17.0,
         fontWeight: FontWeight.w600
     ) ,
           ),
           label:Icon(IconBroken.Arrow___Down_2,color: Colors.black,),
           style:ButtonStyle(
             elevation: MaterialStateProperty.all<double>(0),
             fixedSize: MaterialStateProperty.all(Size(100.0, 20.0)),
             backgroundColor:MaterialStateProperty.all(Colors.grey[300]),
           ) ,
           ),
         actions: [
         IconButton(onPressed: () {  },
      icon: Icon(IconBroken.Search,color: Colors.black87,size: 28.0,),
    ),
         Builder(
      builder: (context) {
        return IconButton(onPressed: ()=>showEndDrawer(context),
        icon: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
        CircleAvatar(
        backgroundImage: NetworkImage('https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=59w3a9OIYjgAX-DIVxB&_nc_ht=scontent.fcai22-1.fna&oh=00_AfDExECk12hg-Wxp7SUTHUKhxwHyLKMXI-J897Yi-zlNiQ&oe=63670608'),
        radius: 30.0,
        ),
        CircleAvatar(backgroundColor: Colors.white,radius: 6,),
        Padding(
        padding: const EdgeInsetsDirectional.only(end:2,bottom:2  ),
        child: CircleAvatar(backgroundColor: Colors.green,radius: 4,),
        )
        ],
        ),
        );
      }
    ),
        ]
    ),

      bottomNavigationBar: 
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 10.0),
          child: Container(
            height: 90.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: BottomNavigationBar(
              elevation: 0,
              selectedItemColor:Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index)
              {
                setState(() {
                  currentIndex=index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon:Icon(IconBroken.Home,color: Colors.black),
                    onPressed: (){},
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon:Icon(IconBroken.Discovery,color: Colors.black,),
                    onPressed: (){},
                  ),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    focusColor: Colors.black,
                    icon:Icon(Icons.add,size: 30.0,color: Colors.black,),
                    onPressed: (){
                      Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>
                          createPostScreen()
                          )
                      );
                    },
                  ),
                  label: 'post',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                      focusColor: Colors.black,
                    icon:Icon(IconBroken.Chat,color: Colors.black),
                    onPressed: (){},
                  ),
                  label: 'chat',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon:Icon(IconBroken.Notification,color: Colors.black),
                    onPressed: (){},
                  ),
                  label: 'notifications',
                ),
              ],
            ),
          ),
        ),


     endDrawer: Drawer(
          elevation: 20.0,
              width: 250.0,
              child: Column(
                children: [
                   SizedBox(height: 80.0,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
          ),
                      width:250.0,
                     height: 250.0,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     CircleAvatar(radius: 60.0,
                    backgroundImage: NetworkImage('https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/295620039_2901815830124147_3894684143253429188_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGDVvYYeYLBEsnfJgcK_2QhCG0mhWDK5bUIbSaFYMrltfF8DvgnVQPwnfPB7cJzH5SuwGPsFFNnQRI-_iJriHBi&_nc_ohc=59w3a9OIYjgAX9qgpNN&_nc_ht=scontent.fcai22-1.fna&oh=00_AfDCEaASy3nQJ8_HOTdw6aQgAlOoL7Ygc5L6haOnlanzmA&oe=63690048'),

          ),
                     SizedBox(height: 10.0,),
                      Text('u/'+'Ahmed Fawzy',
           style: TextStyle(
                     fontWeight: FontWeight.w600,
                     fontSize: 17.0,
                     color: Colors.black
           ),
         ),
                        SizedBox(height: 5.0,),
                        SizedBox(
                          width: 200.0,
                          height: 30.0,
                          child: ElevatedButton.icon(onPressed: ()
                          {
                            setState(() {
                              if (isOnline) {
                                isOnline = false;
                              } else {
                                isOnline = true;
                              }
                            });
                          },
                            icon: CircleAvatar(radius: 4,
                              backgroundColor:isOnline?Colors.green:Colors.grey[200],
                            ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                              backgroundColor:MaterialStateProperty.all(Colors.grey[200]),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: isOnline?Colors.green:Colors.black54)
                            )
                          )
                          ),
                            label: Text(
                              "Online Status: "+ "${isOnline?"On":"Off"}",
                              style: TextStyle(
                                color: isOnline?Colors.green:Colors.black54
                              ),
                            ),


                          ),
                        ),
                        ]
                     )
     ),
                  SizedBox(
                    height: 20.0,
                  ),
               SizedBox(height: 10,),

                  Divider(thickness: 1,),

                  ListTile(
                    horizontalTitleGap: 3,
                    leading: Icon(Icons.account_circle_outlined),
                    title: Text('My profile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 3,
                    leading: Icon(IconBroken.Category),
                    title: Text('Create a community',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 3,
                    leading: Icon(Icons.save),
                    title: Text('Saved',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    horizontalTitleGap: 3,
                    leading: Icon(Icons.access_time_outlined),
                    title: Text('History',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                 SizedBox(height: 230.0,),
                  Expanded(
                    child: ListTile(
                      horizontalTitleGap: 3,
                      leading: Icon(IconBroken.Setting),
                      title: Text('Settings',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                ],
              ),



     ),
     drawer: Drawer(
       elevation: 20.0,
       child:SingleChildScrollView(
         child: Column(
           children: [
             SizedBox(height: 40,),
             Divider(height: 3,),
            ExpansionTile(
              onExpansionChanged: (isRecentlyVisitedPannelExpanded){
                setState(() {
                  if(isRecentlyVisitedPannelExpanded)
                  {
                    icRecent=TextButton(onPressed: (){}, child: Text("See all",style:
                      TextStyle(color: Colors.black),), );
                  }
                  else
                  {
                    icRecent=IconButton(onPressed: (){}, icon: Icon(IconBroken.Arrow___Right_2));
                  }
                });
              },
              initiallyExpanded: isRecentlyVisitedPannelExpanded,
              expandedAlignment: Alignment.bottomRight,
              trailing:icRecent ,
              title:
                 Text("Recently Visited",
                 style: TextStyle(
                   fontWeight: FontWeight.w500,
                   fontSize: 15,
                   color: Colors.black
                 ),
                 ),
              children: [
                   Container(
                          height: recentlyVisited.length*70,
                          child: ListView.builder(
                               itemCount: recentlyVisited.length,
                            itemBuilder: (context,index)
                            {
                              return recentlyVisited[index];
                            },
                             ),
                        ),

              ],
            ),
             ExpansionTile(
               onExpansionChanged: (isRecentlyVisitedPannelExpanded){
                 setState(() {
                   if(isRecentlyVisitedPannelExpanded)
                   {
                     icModerating=Icon(IconBroken.Arrow___Down_2,color: Colors.black,);
                   }
                   else
                   {
                     icModerating=IconButton(onPressed: (){}, icon: Icon(IconBroken.Arrow___Right_2));
                   }
                 });
               },
               initiallyExpanded: isRecentlyVisitedPannelExpanded,
               expandedAlignment: Alignment.bottomRight,
               trailing:icModerating ,
               title:
               Text("Moderating",
                 style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 15,
                     color: Colors.black
                 ),
               ),
               children: [
                 ListTile(
                   horizontalTitleGap: 0.0,
                   leading: Icon(Icons.shield_outlined, ),
                   title: Text("Mod Feed"),

                 ),
                 ListTile(
                   horizontalTitleGap: 0.0,
                   leading: Icon(Icons.quick_contacts_dialer_rounded,),
                   title: Text("Mod Queue"),

                 ),
                 ListTile(
                   horizontalTitleGap: 0.0,
                   leading: Icon(Icons.mail,),
                   title: Text("Modmail"),

                 ),
                 Container(
                   height: Communoties.length*70,
                   child: ListView.builder(
                     itemCount: Communoties.length,
                     itemBuilder: (context,index)
                     {
                       return Communoties[index];
                     },
                   ),
                 ),

               ],
             ),
             ExpansionTile(
               onExpansionChanged: (isRecentlyVisitedPannelExpanded){
                 setState(() {
                   if(isRecentlyVisitedPannelExpanded)
                   {
                     icYourCommunities=Icon(IconBroken.Arrow___Down_2,color: Colors.black,);
                   }
                   else
                   {
                     icYourCommunities=IconButton(onPressed: (){}, icon: Icon(IconBroken.Arrow___Right_2));
                   }
                 });
               },
               initiallyExpanded: isRecentlyVisitedPannelExpanded,
               expandedAlignment: Alignment.bottomRight,
               trailing:icModerating ,
               title:
               Text("Your Communities",
                 style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 15,
                     color: Colors.black
                 ),
               ),
               children: [
                 ListTile(
                   horizontalTitleGap: 0.0,
                   leading: Icon(Icons.add, size: 30.0,),
                   title: Text("Create a community")

                 ),
                 Container(
                   height: Communoties.length*70,
                   child: ListView.builder(
                     itemCount: Communoties.length,
                     itemBuilder: (context,index)
                     {
                       return Communoties[index];
                     },
                   ),
                 ),

               ],
             ),
             ListTile(
               onTap: (){},
                 horizontalTitleGap: 0.0,
                 leading: Icon(Icons.stacked_bar_chart, size: 25.0,),
                 title: Text("All")

             ),

           ],
         ),
       ),
         
         
     ),

    );
  }
}
