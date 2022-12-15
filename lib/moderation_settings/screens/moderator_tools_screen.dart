import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import './topics_screen.dart';
import 'description_screen.dart';
import 'post_types_screen.dart';
import './location_screen.dart';
import './community_type_screen.dart';

class ModeratorTools extends StatefulWidget {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ListView(
            shrinkWrap: true,
            children: [
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(TopicsScreen.routeName,
                      arguments:
                          //'Cooking'
                          ModalRoute.of(context)?.settings.arguments as String),
                  'Topics',
                  Icons.topic),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(Description.routeName,
                      arguments:
                          //'Cooking'

                          (ModalRoute.of(context)?.settings.arguments != null)
                              ? ModalRoute.of(context)?.settings.arguments
                                  as String
                              : ''),
                  'Description',
                  Icons.topic),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      PostTypesScreen.routeName,
                      arguments: (ModalRoute.of(context)?.settings.arguments !=
                              null)
                          ? ModalRoute.of(context)?.settings.arguments as String
                          : ''),
                  'Post Types',
                  Icons.topic),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      ComuunityTypesScreen.routeName,
                      arguments: (ModalRoute.of(context)?.settings.arguments !=
                              null)
                          ? ModalRoute.of(context)?.settings.arguments as String
                          : ''),
                  'community type',
                  Icons.topic),
              buildGeneralOptions(
                  context,
                  () => Navigator.of(context).pushNamed(
                      LocationScreen.routeName,
                      arguments: (ModalRoute.of(context)?.settings.arguments !=
                              null)
                          ? ModalRoute.of(context)?.settings.arguments as String
                          : ''),
                  'location',
                  Icons.topic),
            ],
          )
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
