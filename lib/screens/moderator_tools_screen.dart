import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sw_code/screens/topics_screen.dart';

class ModeratorTools extends StatelessWidget {
  static const routeName = '/moderatortools';

  final generalListTools = {
    'Topics': Icons.topic,
    'Description': Icons.create_outlined,
  };

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
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade300,
            width: 100.h,
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var key = generalListTools.keys.elementAt(index);
              return GestureDetector(
                onTap: () {
                  //WILL BE CHANGED WHEN COMPLETED ALL TOOLS
                  Navigator.of(context).pushNamed(TopicsScreen.routeName);
                },
                child: //Column(children: [
                    ListTile(
                  leading: Icon(generalListTools[key]),
                  trailing: const Icon(Icons.arrow_forward),
                  title: Text(key),
                ),
              );
            },
            itemCount: generalListTools.length,
          )
        ],
      ),
    );
  }
}
