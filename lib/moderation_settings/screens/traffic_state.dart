import 'dart:math';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post/logins/providers/authentication.dart';
import 'package:post/moderation_settings/models/traffic.dart';
import '../../widgets/loading_reddit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../provider/moderation_general_data.dart';
import 'package:provider/provider.dart';
import 'package:editable/editable.dart';

class TraficState extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/traficstate';
  const TraficState({super.key});

  @override
  State<TraficState> createState() => _TraficStateState();
}

class _TraficStateState extends State<TraficState> {
  /// Whether fetching the data from server done or not

  bool fetchingDone = true;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  /// Whether the build fuction calling at least one time or not

  bool _isBuild = false;

  /// index will control wich graph will appare
  int index = 0;

  /// the starting year of years graph
  static const startYear = 2018;

  ///the list that will carry the name of 7 days of week
  List<String> days = [];

  ///the list that will carry the number of members joined at each day

  List<double> daysValues = List<double>.generate(7, (int index) => 0);

  ///the max number of members joined at any day of the week
  int maxDay = 0;

  ///the list that will carry the 52  week of the year

  List<String> weeks = [];

  ///the list that will carry the number of members joined at each week

  List<double> weeksValues = List<double>.generate(52, (int index) => 0);

  ///the max number of members joined at any week of the year

  int maxWeek = 0;

  ///the list that will carry the name of the 12s month of the year

  List<String> months = [];

  ///the list that will carry the number of members joined at each month

  List<double> monthsValues = List<double>.generate(12, (int index) => 0);

  ///the max number of members joined at any month of the year

  int maxMonth = 0;

  ///the list that will carry a string represent each year from starting year until now

  List<String> years = [];

  ///the list that will carry the number of members joined at each year

  List<double> yearsValues = List<double>.generate(
      DateTime.now().year - startYear + 1, (int index) => 0);

  ///the max number of members joined at any year

  int maxYear = 0;

  ///list of feautures used in the linear graph
  /// that single feauture represent the values of y access of the graph
  List<Feature> features = [];

  /// get the maximum of two trafic data instance acording to its numOfUsers
  TrafficData maxi(TrafficData a, TrafficData b) {
    ///Input :
    /// a,b the two inputs we want to compare between them
    /// return the max between a,b according the number of users
    return (a.numOfUsers! >= b.numOfUsers!) ? a : b;
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      /////prepare days in xaxes and y axise
      ///start with x axise
      ///and the y axis will be inside the then of the provider
      days = ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat'];
      for (int i = 1; i <= 52; i += 1) {
        weeks.add('week $i');
      }
      months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      for (int i = startYear; i <= DateTime.now().year; i += 1) {
        years.add('$i');
      }

      final provider =
          Provider.of<ModerationGeneralDataProvider>(context, listen: false);
      fetchingDone = false;
      final subredditName = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as String
          : '';

      provider.gettrafficData(subredditName, context).then((value) {
        provider.dayTraffic.data = [];
        maxDay = (provider.dayTraffic.data!.isEmpty)
            ? 0
            : (provider.dayTraffic.data!.length == 1)
                ? provider.dayTraffic.data![0].numOfUsers!
                : provider.dayTraffic.data!.reduce(maxi).numOfUsers!;

        maxWeek = (provider.weekTraffic.data!.isEmpty)
            ? 0
            : (provider.weekTraffic.data!.length == 1)
                ? provider.weekTraffic.data![0].numOfUsers!
                : provider.weekTraffic.data!.reduce(maxi).numOfUsers!;
        maxMonth = (provider.monthTraffic.data!.isEmpty)
            ? 0
            : (provider.monthTraffic.data!.length == 1)
                ? provider.monthTraffic.data![0].numOfUsers!
                : provider.monthTraffic.data!.reduce(maxi).numOfUsers!;
        maxYear = (provider.yearTraffic.data!.isEmpty)
            ? 0
            : (provider.yearTraffic.data!.length == 1)
                ? provider.yearTraffic.data![0].numOfUsers!
                : provider.yearTraffic.data!.reduce(maxi).numOfUsers!;

        for (int i = 0; i < provider.dayTraffic.data!.length; i += 1) {
          daysValues[provider.dayTraffic.data![i].iId! - 1] =
              provider.dayTraffic.data![i].numOfUsers!.toDouble();
          if (maxDay != 0) {
            daysValues[provider.dayTraffic.data![i].iId! - 1] /=
                maxDay.toDouble();
          }
        }
        for (int i = 0; i < provider.weekTraffic.data!.length; i += 1) {
          weeksValues[provider.weekTraffic.data![i].iId! - 1] =
              provider.weekTraffic.data![i].numOfUsers!.toDouble();
          if (maxWeek != 0) {
            weeksValues[provider.weekTraffic.data![i].iId! - 1] /= maxWeek;
          }
        }
        for (int i = 0; i < provider.monthTraffic.data!.length; i += 1) {
          monthsValues[provider.monthTraffic.data![i].iId! - 1] =
              provider.monthTraffic.data![i].numOfUsers!.toDouble();
          if (maxMonth != 0) {
            monthsValues[provider.monthTraffic.data![i].iId! - 1] /= maxMonth;
          }
        }
        for (int i = 0; i < provider.yearTraffic.data!.length; i += 1) {
          yearsValues[provider.yearTraffic.data![i].iId! - startYear] =
              provider.yearTraffic.data![i].numOfUsers!.toDouble();
          if (maxYear != 0) {
            yearsValues[provider.yearTraffic.data![i].iId! - startYear] /=
                maxYear;
          }
        }
        fetchingDone = true;

        if (_isBuild) setState(() {});
      });
      ;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List rows = [
    {
      "name": 'James LongName Joe',
      "date": '23/09/2020',
      "month": 'June',
      "status": 'completed'
    },
    {
      "name": 'Daniel Paul',
      "month": 'March',
      "status": 'new',
      "date": '12/4/2020',
    },
    {
      "month": 'May',
      "name": 'Mark Zuckerberg',
      "date": '09/4/1993',
      "status": 'expert'
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
  ];
  List cols = [
    {"title": 'Name', 'widthFactor': 0.2, 'key': 'name', 'editable': false},
    {"title": 'Date', 'widthFactor': 0.2, 'key': 'date'},
    {"title": 'Month', 'widthFactor': 0.2, 'key': 'month'},
    {"title": 'Status', 'key': 'status'},
  ];
  @override
  Widget build(BuildContext context) {
    _isBuild = true;
    features = [
      Feature(
        title: "joined members",
        color: Colors.blue,
        data: (index == 0)
            ? daysValues
            : (index == 1)
                ? weeksValues
                : (index == 2)
                    ? monthsValues
                    : yearsValues,
        // :false;
      ),
    ];
    final maxmembers = (index == 0)
        ? maxDay
        : (index == 1)
            ? maxWeek
            : (index == 2)
                ? maxMonth
                : maxYear;
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 231, 239),
            body: Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 60.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Container(
                              width: 40.w,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LineGraph(
                                      features: features,
                                      size: Size(420, 450),
                                      labelX: (index == 0)
                                          ? days
                                          : (index == 1)
                                              ? weeks
                                              : (index == 2)
                                                  ? months
                                                  : years,
                                      labelY: [
                                        '${double.parse(((maxmembers * .1)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .2)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .3)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .4)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .5)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .6)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .7)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .8)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * .9)).toStringAsFixed(2))}',
                                        '${double.parse(((maxmembers * 1)).toStringAsFixed(2))}',
                                      ],
                                      showDescription: true,
                                      graphColor: Colors.black87,
                                      graphOpacity: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 30,
                            // ),
                            Container(
                              // width: 15.w,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: index == 0,
                                        onChanged: (newValue) {
                                          if ((newValue) == true) index = 0;
                                          setState(() {});
                                        },
                                      ),
                                      Text('Day'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: index == 1,
                                        onChanged: (newValue) {
                                          if ((newValue) == true) {
                                            index = 1;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                      Text('week'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: index == 2,
                                        onChanged: (newValue) {
                                          if ((newValue) == true) index = 2;
                                          setState(() {});
                                        },
                                      ),
                                      Text('month'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: index == 3,
                                        onChanged: (newValue) {
                                          if ((newValue) == true) index = 3;
                                          setState(() {});
                                        },
                                      ),
                                      Text('year'),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   color: Colors.white,
                      //   child: Editable(
                      //     // key: _editableKey,
                      //     columns: cols,
                      //     rows: rows,
                      //     zebraStripe: true,
                      //     stripeColor1: Colors.blue,
                      //     stripeColor2: Colors.grey,
                      //     onRowSaved: (value) {
                      //       print(value);
                      //     },
                      //     onSubmitted: (value) {
                      //       print(value);
                      //     },
                      //     borderColor: Colors.blueGrey,
                      //     tdStyle: TextStyle(fontWeight: FontWeight.bold),
                      //     trHeight: 80,
                      //     thStyle: TextStyle(
                      //         fontSize: 15, fontWeight: FontWeight.bold),
                      //     thAlignment: TextAlign.center,
                      //     thVertAlignment: CrossAxisAlignment.end,
                      //     thPaddingBottom: 3,
                      //     showSaveIcon: true,
                      //     saveIconColor: Colors.black,
                      //     showCreateButton: true,
                      //     tdAlignment: TextAlign.left,
                      //     tdEditableMaxLines:
                      //         100, // don't limit and allow data to wrap
                      //     tdPaddingTop: 0,
                      //     tdPaddingBottom: 14,
                      //     tdPaddingLeft: 10,
                      //     tdPaddingRight: 8,
                      //     focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.blue),
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(0))),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
