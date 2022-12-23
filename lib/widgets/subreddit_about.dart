import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../networks/const_endpoint_data.dart';
import '../models/subreddit_about _rules.dart';
import '../screens/contact_mod_message_screen.dart';
import '../myprofile/screens/myprofile_screen.dart';
import '../other_profile/screens/others_profile_screen.dart';

class SubredditAbout extends StatefulWidget {
  List<SubredditAboutRules> rules;
  List<String> moderators;
  String userName;
  SubredditAbout({required this.rules, required this.moderators,required this.userName});

  @override
  State<SubredditAbout> createState() => _SubredditAboutState();
}

class _SubredditAboutState extends State<SubredditAbout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.h,
      child: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 120),
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text('Subreddit Rules',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const Divider(),
              _renderrules(),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: (40 + widget.moderators.length + 5).h,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Moderators',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      IconButton(
                          onPressed: () => Navigator.pushNamed(
                              context, ContactModMessageScreen.routeName),
                          icon: const Icon(
                            Icons.mail_outlined,
                            color: Colors.grey,
                          )),
                    ],
                  )),
              const Divider(),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.moderators.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if(userName!=widget.moderators[index])
                          Navigator.pushNamed(
                              context, OthersProfileScreen.routeName, arguments: {'userName': widget.userName});
                              else
                              Navigator.pushNamed(
                              context, MyProfileScreen.routeName, arguments: {'userName': widget.userName});
                        },
                        title: Text('u/${widget.moderators[index]}'),
                      );
                    }),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _renderrules() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          print(widget.rules.length);
          widget.rules[index].isExpanded = !isExpanded;
        });
      },
      children: widget.rules.map<ExpansionPanel>((SubredditAboutRules rule) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(rule.title),
            );
          },
          body: ListTile(
            title: Text(rule.body),
          ),
          isExpanded: rule.isExpanded,
        );
      }).toList(),
    );
  }
}
