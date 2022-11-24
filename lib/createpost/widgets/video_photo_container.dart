//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../controllers/posts_controllers.dart';
//
// class photoLayout  extends StatelessWidget {
//   const photoLayout({
//     Key? key,
//      required this.controller,
//     required this.indexOfPhoto
//   }) : super(key: key);
//   final postController controller;
//   final indexOfPhoto;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: AlignmentDirectional.topEnd,
//       children: [
//        //Container(child: Image.file(File(controller.imageFileList![1].path), fit: BoxFit.fill),),
//         IconButton(onPressed :clearPhoto(indexOfPhoto) , icon: Icon(Icons.close))
//       ],
//     );
//   }
//    clearPhoto( index)
//   {
//     controller.imageFileList!.removeAt(index);
//   }
//
//
// }
