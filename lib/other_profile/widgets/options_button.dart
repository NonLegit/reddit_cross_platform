// import 'package:flutter/material.dart';
// //import 'package:flutter_code_style/analysis_options.yaml';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import './other_profile_card_information_web.dart';

// class OptionsButton extends StatefulWidget {
//    bool moreOptions;
//    OptionsButton({
//     Key? key,
//     required this.moreOptions,
//   }) : super(key: key);
//   @override
//   State<OptionsButton> createState() => _OptionsButtonState();
// }

// class _OptionsButtonState extends State<OptionsButton> {
//   void initState() {
//     //moreOptions = false;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         top: 340,
//         child: Column(
//           children: [
//             Visibility(
//               visible:OtherProfileCardInformationWeb.moreOptions,
//               child: Container(
//                   child: Column(
//                 children: [
//                   TextButton(
//                       onPressed: null,
//                       child: Text(
//                         'Send Message',
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15),
//                       )),
//                   TextButton(
//                       onPressed: null,
//                       child: Text(
//                         'Block User',
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15),
//                       )),
//                   TextButton(
//                       onPressed: null,
//                       child: Text(
//                         'Get Them Help and Support',
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15),
//                       )),
//                   TextButton(
//                       onPressed: null,
//                       child: Text(
//                         'Report User',
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15),
//                       ))
//                 ],
//               )),
//             ),
//             Container(
//                 width: 15.w,
//                 height: 6.h,
//                 child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                   OtherProfileCardInformationWeb.moreOptions= !OtherProfileCardInformationWeb.moreOptions;
//                     });
//                   },
//                   style: ButtonStyle(
//                       // backgroundColor: MaterialStateProperty.all(Colors.blue)
//                       ),
//                   child: Text(
//                     OtherProfileCardInformationWeb.moreOptions? 'More Options' : 'Less Options',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15),
//                   ),
//                 )),
//           ],
//         ));
  
//   }
// }
