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
  static const routeName = '/traficstate';
  const TraficState({super.key});

  @override
  State<TraficState> createState() => _TraficStateState();
}

class _TraficStateState extends State<TraficState> {
  bool fetchingDone = true;
  bool _isInit = true;
  bool _isBuild = false;
  int index = 0;
  static const startYear = 1990;
  List<String> days = [];
  List<double> daysValues = List<double>.generate(7, (int index) => 0);
  int maxDay = 0;

  List<String> weeks = [];
  List<double> weeksValues = List<double>.generate(52, (int index) => 0);
  int maxWeek = 0;

  List<String> months = [];
  List<double> monthsValues = List<double>.generate(12, (int index) => 0);
  int maxMonth = 0;

  List<String> years = [];
  List<double> yearsValues = List<double>.generate(
      DateTime.now().year - startYear + 1, (int index) => 0);

  int maxYear = 0;

  // int max = 1;
  List<Feature> features = [];
  TrafficData maxi(TrafficData a, TrafficData b) {
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
        print(provider.dayTraffic);
        print(provider.weekTraffic);
        print(provider.monthTraffic);
        print(provider.yearTraffic);
        maxDay = provider.dayTraffic.data!.reduce(maxi).numOfUsers!;
        maxWeek = provider.weekTraffic.data!.reduce(maxi).numOfUsers!;
        maxMonth = provider.monthTraffic.data!.reduce(maxi).numOfUsers!;
        maxYear = provider.yearTraffic.data!.reduce(maxi).numOfUsers!;

        for (int i = 0; i < provider.dayTraffic.data!.length; i += 1) {
          daysValues[provider.dayTraffic.data![i].iId! - 1] =
              provider.dayTraffic.data![i].numOfUsers!.toDouble();
          if (maxDay != 0) {
            daysValues[provider.dayTraffic.data![i].iId! - 1] /=
                maxDay.toDouble();
          }
          // if (provider.dayTraffic.data![i].numOfUsers! > maxDay) {
          //   maxDay = provider.dayTraffic.data![i].numOfUsers!;
          // }
        }
        for (int i = 0; i < provider.weekTraffic.data!.length; i += 1) {
          weeksValues[provider.weekTraffic.data![i].iId! - 1] =
              provider.weekTraffic.data![i].numOfUsers!.toDouble();
          if (maxWeek != 0) {
            weeksValues[provider.weekTraffic.data![i].iId! - 1] /= maxWeek;
          }
          // if (provider.weekTraffic.data![i].numOfUsers! > maxWeek) {
          //   maxWeek = provider.weekTraffic.data![i].numOfUsers!;
          // }
        }
        for (int i = 0; i < provider.monthTraffic.data!.length; i += 1) {
          monthsValues[provider.monthTraffic.data![i].iId! - 1] =
              provider.monthTraffic.data![i].numOfUsers!.toDouble();
          if (maxMonth != 0) {
            monthsValues[provider.monthTraffic.data![i].iId! - 1] /= maxMonth;
          }
          // if (provider.monthTraffic.data![i].numOfUsers! > maxMonth) {
          //   maxMonth = provider.monthTraffic.data![i].numOfUsers!;
          // }
        }
        for (int i = 0; i < provider.yearTraffic.data!.length; i += 1) {
          yearsValues[provider.yearTraffic.data![i].iId! - startYear] =
              provider.yearTraffic.data![i].numOfUsers!.toDouble();
          if (maxYear != 0) {
            yearsValues[provider.yearTraffic.data![i].iId! - startYear] /=
                maxYear;
          }
          // if (provider.yearTraffic.data![i].numOfUsers! > maxYear) {
          //   maxYear = provider.yearTraffic.data![i].numOfUsers!;
          // }
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
                                        '${(maxmembers * .1)}',
                                        '${(maxmembers * .2)}',
                                        '${(maxmembers * .3)}',
                                        '${(maxmembers * .4)}',
                                        '${(maxmembers * .5)}',
                                        '${(maxmembers * .6)}',
                                        '${(maxmembers * .7)}',
                                        '${(maxmembers * .8)}',
                                        '${(maxmembers * .9)}',
                                        '${(maxmembers * 1)}'
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
