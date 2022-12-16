import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/createpost/finalpost.dart';
import '../../createpost/screens/createpost.dart';
import '../../createpost/screens/finalpost.dart';
import '../../createpost/screens/posttocommunity.dart';


import '../../home/providers/cubit/cubit.dart';
import '../../home/providers/cubit/states.dart';
import '../../icons/icon_broken.dart';


class createPostScreen extends StatefulWidget {

  const createPostScreen({Key? key}) : super(key: key);
  @override
  State<createPostScreen> createState() => _createPostScreenState();

}
// To grep the text entered at textFormField
var postTitle =TextEditingController();
var textPost =TextEditingController();
var urlPost=TextEditingController();
// default color for the icon button in createPost Screen
var colorOfMaterialButton=Colors.grey[100];
// to select the type of post image,video, title , text
dynamic typeOfPost;
class _createPostScreenState extends State<createPostScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    // TODO: Function to detect the type of post
    Widget f()
    {
      // If the type is url or post return the TextFormField if video of image container
      if (typeOfPost=="text")
      {
        return  TextFormField(
          controller: textPost,
          enabled: true,
          style: TextStyle(
              fontSize: 14.0
          ),
          showCursor: true,
          toolbarOptions: ToolbarOptions(copy: false, cut: false, paste: false),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          autofocus: true,
          maxLines: null,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              hintText: "Add optional body text",
              border: InputBorder.none
            //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
          ),
        );
      }
      else if(typeOfPost=="video")
      {
        return Container();
      }
      else if(typeOfPost=="url")
      {
        return  TextFormField(
          controller: urlPost,
          enabled: true,
          style: TextStyle(
              fontSize: 14.0
          ),
          showCursor: true,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              hintText: "URL",
              border: InputBorder.none
            //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
          ),
        );
      }
      else if (typeOfPost=="image")
      {
        return Container();
      }
      else
      {
        return Container();
      }
    }
    return BlocProvider(
      create: (BuildContext context)=>layoutCubit(),
      child: BlocConsumer<layoutCubit,layoutStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit=layoutCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              body:  Column(
                children: [
                  SizedBox(height: 40.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);

                        },
                        icon:Icon(Icons.close,size: 32.0,),
                        color: Colors.black45,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20.0),
                        child: MaterialButton(
                          onPressed: (){
                           // layoutCubit.get(context).submitpost(title:"newPost",kind: "textpost",text: "wed",URL: "we",owner: "ec",ownerType: "saf",nsfw:false);
                             Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>finalPostScreen()));
                          },
                          elevation: 0.0,
                          height: 35.0,
                          minWidth: 80.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          color: colorOfMaterialButton,
                          child: Text("Next",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10.0),
                      child: TextFormField(
                        onChanged: (value)
                        {
                          print(value);
                          setState(() {
                            if(value.isEmpty)
                            {
                              colorOfMaterialButton=Colors.grey[100];
                            }else{
                              colorOfMaterialButton=Colors.blue[900];
                              print("val is not empty");
                              print(postTitle.text);
                            }
                          });
                        },
                        controller: postTitle,
                        enabled: true,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700
                        ),
                        showCursor: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintText: "An interesting title",
                            border: InputBorder.none
                          //onfieldsubmitted : (string value ) {}دي بتاخد انونيمس فانكشن عشان لو اما اضغط علي سابمت يعمل اكشن معين
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
                        child: f()
                    ),
                  ),
                  ListTile(
                    onTap: ()
                    {
                      setState(() {
                        typeOfPost="image";
                      });
                    },
                    leading: Icon(IconBroken.Image_2),
                    title: Text("Image"),
                    horizontalTitleGap: 0.0,
                  ),
                  ListTile(
                    onTap: ()
                    {
                      setState(() {
                        typeOfPost="video";
                      });
                    },
                    leading: Icon(IconBroken.Video),
                    title: Text("Video"),
                    horizontalTitleGap: 0.0,
                  ),
                  ListTile(
                    onTap: ()
                    {
                      setState(() {
                        typeOfPost="text";
                      });
                    },
                    leading: Icon(IconBroken.Paper),
                    title: Text("Text"),
                    horizontalTitleGap: 0.0,
                  ),
                  ListTile(
                    onTap: ()
                    {
                      setState(() {
                        typeOfPost="url";
                      });
                    },
                    leading: Icon(IconBroken.Bookmark),
                    title: Text("Link"),
                    horizontalTitleGap: 0.0,
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

}
