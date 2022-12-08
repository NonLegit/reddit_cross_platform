import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/home/widgets/community_container.dart';
import 'package:post/home/widgets/subscribed_community_container.dart';
import 'package:post/networks/const_endpoint_data.dart';

import '../../create_community/screens/create_community.dart';
import '../../createpost/controllers/posts_controllers.dart';
import '../../icons/icon_broken.dart';

class MyDrawer extends StatelessWidget {
 // const MyDrawer({Key? key}) : super(key: key);
  final HomeController controller = Get.put(
    HomeController(),
  );
  final postController controllerForCreatePost = Get.put(
    postController(),
  );
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      elevation: 20.0,
     child: SingleChildScrollView(
       child: Column(
         children: [
           const SizedBox(
             height: 40,
           ),
           const Divider(
             height: 3,
           ),
           Obx(
               ()=> ExpansionTile(
                 initiallyExpanded: true,
               onExpansionChanged: (value){

                     controller.isRecentlyVisitedPannelExpanded.value=value;
               },
               title:  Text(
                 "Recently Visited",
                 style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 15,
                     color: Colors.black),
               ),
               trailing: (controller.isRecentlyVisitedPannelExpanded.value==true)?
                TextButton(
                 onPressed: (){},
                   child: Text(
                     "See all",
                     style: TextStyle(color: Colors.black),
                   ),
               ): Icon(IconBroken.Arrow___Right_2,color: Colors.black,),
               children:List.generate(3, (index) => CommunityContainer(nameOfSubreddit: "cross-platform", iconOfSubreddit: "https://png.pngtree.com/element_our/20190530/ourmid/pngtree-correct-icon-image_1267804.jpg"))
             ),
           ),
           Obx(
                 ()=> ExpansionTile(
                   initiallyExpanded: true,
                 onExpansionChanged: (value){
                   controller.isModeratingPannelExpanded.value=value;
                 },
                     title: const Text(
                       "Moderating",
                       style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 15,
                           color: Colors.black),
                     ),
                 trailing: (controller.isModeratingPannelExpanded.value==true)?
                   const Icon(IconBroken.Arrow___Down_2,color: Colors.black,): const Icon(IconBroken.Arrow___Right_2,color: Colors.black,),
                   children: [
                     const ListTile(
                       horizontalTitleGap: 0.0,
                       leading: Icon(
                         Icons.shield_outlined,
                         color: Colors.black,
                       ),
                       title: Text("Mod Feed",style: TextStyle(color: Colors.black),),
                     ),
                     const ListTile(
                       horizontalTitleGap: 0.0,
                       leading: Icon(
                         color: Colors.black,
                         Icons.quick_contacts_dialer_rounded,
                       ),
                       title: Text("Mod Queue",style: TextStyle(color: Colors.black)),
                     ),
                     const ListTile(
                       horizontalTitleGap: 0.0,
                       leading: Icon(
                         color: Colors.black,
                         Icons.mail,
                       ),
                       title: Text("Modmail",style: TextStyle(color: Colors.black)),
                     ),
                   Column(
                      children:List.generate(controllerForCreatePost.moderatedSubreddits.length, (index) => CommunityContainer(nameOfSubreddit:controllerForCreatePost.moderatedSubreddits[index].subredditName! , iconOfSubreddit:controllerForCreatePost.moderatedSubreddits[index].icon! ),)
                   )
                   ],
               //  children:List.generate(20, (index) => CommunityContainer(nameOfSubreddit: "as", iconOfSubreddit: "sa"))
             ),
           ),
           Obx(
                 ()=> ExpansionTile(
               initiallyExpanded: true,
               onExpansionChanged: (value){
                 controller.isYourCommunitiesPannelExpanded.value=value;
               },
               title: Text(
                 "Your Communities",
                 style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 15,
                     color: Colors.black),
               ),
               trailing: (controller.isYourCommunitiesPannelExpanded.value==true)?
               Icon(IconBroken.Arrow___Down_2,color: Colors.black,): Icon(IconBroken.Arrow___Right_2,color: Colors.black,),
               children: [
                 ListTile(
                     onTap: () {
                       Navigator.of(context)
                           .pushNamed(CreateCommunity.routeName);
                     },
                     horizontalTitleGap: 0.0,
                     leading: Icon(
                       Icons.add,
                       size: 30.0,
                     ),
                     title: Text("Create a community")),
                 Column(
                     children:List.generate(controllerForCreatePost.subscribedSubreddits.length, (index) => SubScribedCommunityContainer(nameOfSubreddit:controllerForCreatePost.subscribedSubreddits[index].subredditName! , iconOfSubreddit:controllerForCreatePost.subscribedSubreddits[index].icon! ),)
                 )
               ],
               //  children:List.generate(20, (index) => CommunityContainer(nameOfSubreddit: "as", iconOfSubreddit: "sa"))
             ),
           ),
           (controller.following.length==0) ? SizedBox():Obx(
                 ()=> ExpansionTile(
               initiallyExpanded: true,
               onExpansionChanged: (value){
                 controller.isFollowingPannelExpanded.value=value;
               },
               title: Text(
                 "Following",
                 style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 15,
                     color: Colors.black),
               ),
               trailing: (controller.isFollowingPannelExpanded.value==true)?
               Icon(IconBroken.Arrow___Down_2,color: Colors.black,): Icon(IconBroken.Arrow___Right_2,color: Colors.black,),
                     children:List.generate(2, (index) => CommunityContainer(nameOfSubreddit: "Eman", iconOfSubreddit: "https://png.pngtree.com/element_our/20190530/ourmid/pngtree-correct-icon-image_1267804.jpg"),)
               //  children:List.generate(20, (index) => CommunityContainer(nameOfSubreddit: "as", iconOfSubreddit: "sa"))
             ),
           ),
           ListTile(
               onTap: () {},
               horizontalTitleGap: 0.0,
               leading: Icon(
                 Icons.stacked_bar_chart,
                 size: 25.0,
               ),
               title: Text("All")),
         ],
       ),
     ),
    );
  }

}