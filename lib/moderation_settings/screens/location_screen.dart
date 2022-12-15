import 'package:flutter/material.dart';
import '../../logins/models/status.dart';
import '../widgets/alert_dialog.dart';
import '../models/moderator_tools.dart';
import '../../widgets/loading_reddit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/countries.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../widgets/location_list.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';

  const LocationScreen({super.key});
  // postTypes({super.key});

  @override
  State<LocationScreen> createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  // TextEditingController postTypesController = TextEditingController();
  InputStatus postTypesStatus = InputStatus.original;
  String? initialpostTypes;
  String? subbredditName;
  bool isSlected = false;
  ModeratorToolsModel? moderatorToolsModel;

  String initialLocation = '';
  String location = '';
  bool fetchingDone = true;
  bool _isInit = true;
  final List<String> regions = Countries().countries;
  void changeLocation(String newLocation) {
    print(location);
    location = newLocation;
    print(location);
    if (location == initialLocation) {
      isSlected = false;
    } else {
      isSlected = true;
    }
  }

  // void change
  @override
  void initState() {
    //return hardcoded topics from constant folder
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      subbredditName = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as String
          : '';
      // subbredditName = 'Cooking';
      Provider.of<ModerationSettingProvider>(context, listen: false)
          .getCommunity(subbredditName!,context)
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;

        initialLocation = moderatorToolsModel!.region!;
        location = initialLocation;
        setState(() {
          fetchingDone = true;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> saveLocation() async {
    ////
    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);
    await provider.patchCommunity({
      "region": location,
    }, subbredditName!,context).then((response) {});

    if (provider.isError == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: true, text: provider.errorMessage, disableStatus: true),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change Location succefuly',
            disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 1));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = isSlected
            ? await showDialog<bool>(
                context: context,
                builder: ((context) {
                  return const AlertDialog1();
                }),
              )
            : true;
        return shouldPop!;
      },
      child: (!fetchingDone)
          ? const LoadingReddit()
          //Calls TopicMainScreen widget to build Topics Screen
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                title: Text('Location'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: isSlected ? saveLocation : null,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: isSlected
                                ? Color.fromARGB(255, 56, 93, 164)
                                : Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              ),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                          'Adding a location helps your community show up in search results and recommendations and helps local redditors find it easter',
                          style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(height: 5.h),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Region',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: LocationList(
                          regions: regions,
                          changeLocation: (String value) {
                            changeLocation(value);
                            setState(() {});
                          },
                          value: location),
                    ),
                  ]),
            ),
    );
  }
}
