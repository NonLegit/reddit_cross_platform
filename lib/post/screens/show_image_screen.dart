import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({super.key});

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  late String imgUrl;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================Fetch subreddit data =======================================//

    var temp =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    imgUrl = temp['imgUrl'];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: imgUrl,
          ),
        ),
      ),
    );
  }
}
