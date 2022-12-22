import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controllers/posts_controllers.dart';

class FlairList extends StatefulWidget {
  @override
  State<FlairList> createState() => _FlairListState();
}

class _FlairListState extends State<FlairList> {
  // const FinalPost({Key? key}) : super(key: key);
  final PostController controller = Get.put(
    PostController(),
  );

  Map selected = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 60,
        ),
        Expanded(
          child: Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                    children: List.generate(
                  controller.checking.length,
                  (index) => (index == 0)
                      ? CheckboxListTile(
                          checkboxShape: CircleBorder(),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          activeColor: Colors.blue[900],
                          value: controller.textOfFlair.value == "None"
                              ? true
                              : false,
                          onChanged: (value) {
                            controller.textOfFlair.value = "None";
                            controller.idOfFlair.value = "None";
                            controller.textColorOfFlair.value = "None";
                            controller.backgroundColorOfFlair.value = "None";
                            // print("the value of none is ${controller.checking[index]}");
                          },
                          title: Text("None"),
                        )
                      : CheckboxListTile(
                          checkboxShape: CircleBorder(),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          activeColor: Colors.blue[900],
                          title: Text(
                              controller.flairsOfSubreddit[index - 1].text!,
                              style: TextStyle(
                                  height: 1.5,
                                  color: HexColor(
                                      "${controller.flairsOfSubreddit[index - 1].textColor}"),
                                  backgroundColor: HexColor(
                                      "${controller.flairsOfSubreddit[index - 1].backgroundColor}"))),
                          value: controller.textOfFlair.value ==
                                  controller.flairsOfSubreddit[index - 1].text!
                              ? true
                              : false,
                          onChanged: (value) {
                            controller.textOfFlair.value =
                                controller.flairsOfSubreddit[index - 1].text!;
                            controller.idOfFlair.value =
                                controller.flairsOfSubreddit[index - 1].sId!;
                            controller.textColorOfFlair.value = controller
                                .flairsOfSubreddit[index - 1].textColor!;
                            controller.backgroundColorOfFlair.value = controller
                                .flairsOfSubreddit[index - 1].backgroundColor!;
                            print(
                                "the color is  ${controller.flairsOfSubreddit[index - 1].backgroundColor}");
                          },
                        ),
                )),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: ElevatedButton(
                  onPressed: () {
                    controller.idOfFlair.value = "None";
                    controller.textOfFlair.value = "None";
                    controller.backgroundColorOfFlair.value = "None";
                    controller.textColorOfFlair.value = "None";
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
