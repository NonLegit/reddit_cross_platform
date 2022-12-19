import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/home/controller/home_controller.dart';
import 'package:post/icons/icon_broken.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../post/widgets/post.dart';

class History extends StatelessWidget {
   History({Key? key}) : super(key: key);
  final HomeController controller = Get.put(
    HomeController(),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
           icon:const Icon( IconBroken.Arrow___Left_2),
            onPressed: ()
            {
            Get.back();
            },
          ),
          title: const Text("History",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value){},
              itemBuilder: (BuildContext context) {
                return {'Clear History'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: ListTile(
                      leading: Icon(Icons.close_outlined),
                      title: Text(choice),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15,top: 5),
                child: Row(
                  children: [
                   const Icon(Icons.access_time_outlined,color: Colors.grey,size: 20,),
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) =>   GestureDetector(
                            onTap: () {},
                        child: Container(
                        padding: const EdgeInsets.all(30),
                        height: 30.h,
                        width: 30.w,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: Colors.white),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                        const Text('SORT HISTORY BY',
                        style: TextStyle(
                        color: Colors.grey,
                        )),
                        const Divider(height: 5,),
                          ListTile(
                            onTap: ()
                            {
                              controller.sortHistoryBy.value="upvoted";
                             Get.back();
                              //   Get.forceAppUpdate();
                             // controller.sortHistoryBy.update((val) { });
                            },
                            leading: Icon(
                                Typicons.up_outline,
                            color: (controller.sortHistoryBy.value=="upvoted")?Colors.black:Colors.grey[500]
                            ) ,
                            title: Text(
                              "Upvoted",
                              style: TextStyle(
                                color: (controller.sortHistoryBy.value=="upvoted")?Colors.black:Colors.grey[500]
                              ),
                            ) ,
                            trailing:(controller.sortHistoryBy.value=="upvoted")? Icon(Icons.done,color: Colors.green,):null ,
                          ),
                          ListTile(
                            onTap: ()
                            {
                              controller.sortHistoryBy.value="downvoted";
                              Get.back();
                            },
                            leading: Icon(
                                Typicons.down_outline,
                                color: (controller.sortHistoryBy.value=="downvoted")?Colors.black:Colors.grey[500]
                            ) ,
                            title: Text(
                              "Downvoted",
                              style: TextStyle(
                                  color: (controller.sortHistoryBy.value=="downvoted")?Colors.black:Colors.grey[500]
                              ),
                            ) ,
                            trailing:(controller.sortHistoryBy.value=="downvoted")? Icon(Icons.done,color: Colors.green,):null ,
                          ),
                          ListTile(
                            onTap: ()
                            {
                              controller.sortHistoryBy.value="hidden";
                              Get.back();
                            },
                            leading: Icon(
                                Icons.visibility_off,
                                color: (controller.sortHistoryBy.value=="hidden")?Colors.black:Colors.grey[500]
                            ) ,
                            title: Text(
                              "Hidden",
                              style: TextStyle(
                                  color: (controller.sortHistoryBy.value=="hidden")?Colors.black:Colors.grey[500]
                              ),
                            ) ,
                            trailing:(controller.sortHistoryBy.value=="hidden")? Icon(Icons.done,color: Colors.green,):null ,
                          ),
                        ],
                        ),
                        ),
                        )
                        );
                      },
                      icon: Text(
                        "${controller.sortHistoryBy.value.toUpperCase()}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      label: const Icon(
                        IconBroken.Arrow___Down_2,
                        color: Colors.grey,
                        size: 15,
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.grey[300]),
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 2,),
            Column(
              children: List.generate(controller.homePosts.length, (index) =>
                  Post.home(
                    data: controller.homePosts[index],

                  )
              ),
            )
            ],
            // body: controller.obx(
            //         (data) => ListView.separated(
            //       itemCount: data!.length,
            //       itemBuilder: (context, index) {
            //         return Text(data[index].title.toString());
            //       },
            //       separatorBuilder: (BuildContext context, int index) {
            //         return SizedBox(
            //           height: 10,
            //         );
            //       },
            //     ),
            //     onError: (error) => Center(
            //       child: Text(error.toString()),
            //     ),
            //     onEmpty: Center(
            //       child: Text('No Posts'),
            //     ),
            //     onLoading: LoadingReddit()),
          ),
        ),
      ),
    );
  }
}
