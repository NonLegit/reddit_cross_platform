import 'package:flutter/material.dart';
import 'package:post/moderation_settings/screens/add_edit_post_flair.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/post_flair_model.dart';
import '../provider/post_flair_provider.dart';
import '../../widgets/loading_reddit.dart';

class PostFlairModerator extends StatefulWidget {
  PostFlairModerator({super.key});
  static const routeName = '/post-flair-moderator';

  @override
  State<PostFlairModerator> createState() => _PostFlairState();
}

class _PostFlairState extends State<PostFlairModerator> {
  List<PostFlairModel> flair = [];
  bool fetchingDone = false;
  bool _isInit = true;
  String? subredditName;
  _toEdit(index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddAndEditPostFllair(
              deleteFlair: true,
              backgroundColorText: flair[index].backgroundColor,
              subredditName: subredditName,
              changed: flair[index].text,
              post: flair[index],
              textColor1: flair[index].textColor),
        ));
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      subredditName = ModalRoute.of(context)!.settings.arguments.toString();
      setState(() {
        fetchingDone = false;
      });
      subredditName = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<PostFlairProvider>(context, listen: false)
          .fetchFlair(
              ModalRoute.of(context)?.settings.arguments as String, context
              // 'Cooking'
              )
          .then((_) {
        flair =
            Provider.of<PostFlairProvider>(context, listen: false).flairList;

        // choosenTopic = moderatorToolsModel!.choosenTopic1;
        // print(choosenTopic);
        setState(() {
          fetchingDone = true;
        });
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  // String text = 'hii';
  // String backgroundColor = '#ac1291';
  // String textColor = '#ac1291';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post Flair',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAndEditPostFllair(
                      deleteFlair: false,
                      textColor1: '#000000',
                      subredditName: subredditName,
                      backgroundColorText: '#bcbcbc',
                      changed: 'Type to edit',
                    ),
                  ),
                );
                //Navigator.of(context).pushNamed(AddAndEditPostFllair.routeName,);
              },
              icon: Icon(Icons.add)),
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        backgroundColor: Colors.grey[50],
        titleSpacing: 0,
        elevation: 2,
        shadowColor: Colors.white,
      ),
      body: Column(
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
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.grey,
              ),
              hintText: 'Search for a post flair',
            ),
          ),
          (fetchingDone)
              ? SingleChildScrollView(
                  child: Consumer<PostFlairProvider>(
                    builder: (context, value, child) => ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          _toEdit(index);
                        },
                        child: ListTile(
                          title: Text(
                            flair[index].text!,
                            style: TextStyle(
                                backgroundColor:
                                    flair[index].backgroundColor!.toColor(),
                                color: flair[index].textColor!.toColor()),
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                      itemCount: flair.length,
                    ),
                  ),
                )
              : const LoadingReddit()
        ],
      ),
    );
  }
}

extension ColorExtension on String {
  toColor() {
    var hexStringColor = this;
    final buffer = StringBuffer();

    if (hexStringColor.length == 6 || hexStringColor.length == 7) {
      buffer.write('ff');
      buffer.write(hexStringColor.replaceFirst("#", ""));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }
}
