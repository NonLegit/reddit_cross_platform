import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../widgets/profile_comments.dart';
import '../../widgets/profile_posts.dart';
import '../widgets/others_profile_about.dart';
import '../models/others_profile_data.dart';
import '../providers/other_profile_provider.dart';
class InviteButton extends StatelessWidget {
  const InviteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
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
                    Center(
                      child: Text('invite'),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ButtonStyle(
          side:
              MaterialStateProperty.all(const BorderSide(color: Colors.white)),
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(137, 33, 33, 33)),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
      child: const Icon(Icons.person_add_alt_sharp),
    );
  }
}