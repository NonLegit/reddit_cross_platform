
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/subreddit_container.dart';

class buildSubreddit extends StatelessWidget {
  const buildSubreddit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Post to",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: (
                ){},
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start :5,top:12),
                  child: Container (
                    alignment: AlignmentDirectional.center,
                    height: 38,
                    width: 390,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      color: Colors.grey[300],
                    ),

                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 22.0,

                          ),
                          SizedBox(width: 7),
                          Text("Search",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true, // عشان اسمح بال سكرول
                    itemBuilder: (context , index) => subredditContainer() ,
                    itemCount: 20,
                  ),
                ],
              ),
            ],
          ),
        )

    );
  }
}
