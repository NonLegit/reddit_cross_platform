import 'package:flutter/material.dart';
import 'package:post/moderation_settings/screens/post_flair.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../icons/icon_broken.dart';
import './topics_screen.dart';
import 'description_screen.dart';
import 'post_types_screen.dart';
import './location_screen.dart';
import './community_type_screen.dart';

import './approved_users_screen.dart';
import './banned_user_sceen.dart';
import './muted_user_screen.dart';
import './moderators_screen.dart';
import './traffic_state.dart';
class ModeratorTools extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/moderatortools';

  const ModeratorTools({super.key});

  @override
  State<ModeratorTools> createState() => _ModeratorToolsState();
}

class _ModeratorToolsState extends State<ModeratorTools> {
  List<String>? topics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //leading if there is no button when pushing add it don't forget
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            'Moderator tools',
          ),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          backgroundColor: Colors.grey[50],
          titleSpacing: 0,
          elevation: 2,
          shadowColor: Colors.white,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            color: Colors.grey.shade300,
            width: 100.h,
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: const Text(
              'GENERAL',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          // SingleChildScrollView(
          //   child:
          ListView(
            shrinkWrap: true,
            children: [
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(Description.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Description',
                  Icons.edit_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(TopicsScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Topics',
                  Icons.local_offer_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      ComuunityTypesScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'CommunityT Type',
                  Icons.lock_outline),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      PostTypesScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Post Types',
                  Icons.library_books_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(TopicsScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Discovery',
                  IconBroken.Discovery),
              // buildGeneralOptions(
              //     context,
              //     () => Navigator.of(context).pushNamed(
              //         LocationScreen.routeName,
              //         arguments:
              //             //'Cooking'
              //             ModalRoute.of(context)?.settings.arguments as String),
              //     'Loction',
              //     Icons.location_on_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(TopicsScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Archive Posts',
                  Icons.view_agenda_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      LocationScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Loction',
                  Icons.location_on_outlined),
            ],
          ),
          // ),
          Container(
            color: Colors.grey.shade300,
            width: 100.h,
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: const Text(
              'CONTENT & REGULATIONS',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // SingleChildScrollView(
          //   child:
          ListView(
            shrinkWrap: true,
            children: [
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      PostFlairModerator.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Post Flair',
                  Icons.local_offer_outlined),
            ],
          ),
          // ),
          Container(
            color: Colors.grey.shade300,
            width: 100.h,
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: const Text(
              'USER MANAGEMENT',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // SingleChildScrollView(
          //   child:
          ListView(
            shrinkWrap: true,
            children: [
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      ModeratorsScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Moderators',
                  Icons.shield_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      ApprovedScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Approved users',
                  Icons.person_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(MutedScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Muted users',
                  Icons.block_outlined),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(BannedScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Banned users',
                  Icons.gavel_outlined),
                  buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(TraficState.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Traffic Status',
                  Icons.view_agenda_outlined),
            ],
          ),
          // ),
        ],
      ),
    );
  }

  //call buildGeneralOptions to create the widget of each option in moderation setting
  //return value is Gesture Detector
  //Inputs : context of widget , function to call on tapping gesture, header of settings e.g Topics,Description,.. , next:Icon of each setting
  GestureDetector buildGeneralOptions(
      BuildContext context, VoidCallback onTap, String text, IconData next) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(next),
        trailing: const Icon(Icons.arrow_forward),
        title: Text(text),
      ),
    );
  }
}
