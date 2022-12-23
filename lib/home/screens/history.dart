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
import '../../post/widgets/post_list.dart';
import '../../widgets/loading_reddit.dart';
import '../controller/home_controller.dart';
class History extends StatefulWidget {
   History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}


class _HistoryState extends State<History>with TickerProviderStateMixin {
  final HomeController controller = Get.put(
    HomeController(),
  );
  late AnimationController loadingSpinnerAnimationController;
  @override
  void initState() {
    super.initState();
    loadingSpinnerAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    loadingSpinnerAnimationController.repeat();
    if (controller.allPosts.isEmpty) {
      controller.getHistory(sort: controller.sortHistoryBy.value, p: controller.pageNumberHistory.value,);
    }
  }
  void dispose() {
    loadingSpinnerAnimationController.dispose();
    super.dispose();
  }
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
                      onTap: ()
                      {
                        controller.historyPosts.clear();
                      },
                      leading: Icon(Icons.close_outlined),
                      title: Text(choice),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body:  RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue[900],
          onRefresh: () async {
            controller.historyPosts.clear();
            controller.pageNumberHistory.value = 1;
            controller.pageNumberHistory.update((val) {});
            controller.getHistory(sort: controller.sortHistoryBy.value, p: controller.pageNumberHistory.value,);
            controller.update();
            //Get.forceAppUpdate();
          },
          child: controller.isLoadingHistory.value
              ? Center(
            child: CircularProgressIndicator(
              valueColor: loadingSpinnerAnimationController.drive(
                ColorTween(
                  //begin: Colors.blueAccent,
                  end: Colors.blueAccent,
                ),
              ),
            ),
          )
              : controller.errorHistory.value
              ? ListView(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(150),
                child: Text("Unexpected Error Try Again.."),
              ),
            ],
          )
              : controller.historyPosts.isEmpty
              ? LoadingReddit()
              :
          PostList(
            userName: '${controller.myProfile!.userName}', updateData: (){
            controller.pageNumberHistory.value++;
            controller.pageNumberHistory.update((val) { });
            controller.getHistory(sort: controller.sortHistoryBy.value, p: controller.pageNumberHistory.value,);
          }, data: controller.historyPosts,
            topOfTheList:
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
                                      controller.sortHistoryBy.update((val) { });
                                      Get.back();

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
                                      controller.sortHistoryBy.update((val) { });
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
                                      controller.sortHistoryBy.update((val) { });
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
          ),
        ) ,
          ),

    );
  }
}
