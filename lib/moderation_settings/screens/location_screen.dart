import 'package:flutter/material.dart';
import '../widgets/status.dart';
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
  /// the route name of the screen

  static const routeName = '/location';

  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  /// the current Subrddit name of the screen

  String? subbredditName;

  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  ///model will be filed from the provider to take the data

  ModeratorToolsModel? moderatorToolsModel;

  ///the initiall value of the location
  String? initialLocation = '';

  /// the current value of the location when the user change it
  String? location = '';

  /// Whether fetching the data from server done or not

  bool fetchingDone = true;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  ///list of all regions comming from a constat list
  final List<String> regions = Countries().countries;

  ///change the isSelcted when change the location
  ///
  ///when the UserNmae input field and reason both are empty then the selected will be false
  ///other wise it will be true

  void changeLocation(String newLocation) {
    /// input:
    ///   newLocation:the new location value
    /// output: none

    location = newLocation;
    if (location == initialLocation) {
      isSlected = false;
    } else {
      isSlected = true;
    }
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
          .getCommunity(subbredditName!, context)
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;

        initialLocation = moderatorToolsModel!.region!.toLowerCase();
        if (initialLocation == 'unknown') {
          initialLocation = null;
        }
        location = initialLocation;
        fetchingDone = true;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  ///post the Location  changes to the sever
  ///
  /// take the data from location feild info model
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> saveLocation() async {
    /// input:  none
    /// output: none

    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);
    await provider.patchCommunity({
      "region": location,
    }, subbredditName!, context).then((response) {});

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
    isBuild = true;
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
