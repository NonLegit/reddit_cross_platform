import 'package:flutter/material.dart';
import '../../screens/emptyscreen.dart';

class PopDownMenu extends StatelessWidget {
  const PopDownMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              // Some Features that User interact Like(send message , Block account,report account)
              showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: MediaQuery.of(context).size.width * 0.30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.local_post_office_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  EmptyScreen.routeName,
                                  arguments: 'send message');
                            },
                            title: const Text(
                              'Send a message',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Get them help and support',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.block_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Block account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.flag_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Report acount',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.more_vert_rounded,color: Colors.white,),
          ),
        ]);
  }
}
