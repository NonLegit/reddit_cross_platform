import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:editable/editable.dart';

class TrafficTable extends StatelessWidget {
  const TrafficTable({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Table(
      defaultColumnWidth: FixedColumnWidth(120.0),
      border: TableBorder.all(
          color: Colors.black, style: BorderStyle.solid, width: 2),
      children: [
        TableRow(children: [
          Column(children: [Text('Website', style: TextStyle(fontSize: 20.0))]),
          Column(
              children: [Text('Tutorial', style: TextStyle(fontSize: 20.0))]),
          Column(children: [Text('Review', style: TextStyle(fontSize: 20.0))]),
        ]),
        TableRow(children: [
          Column(children: [Text('Javatpoint')]),
          Column(children: [Text('Flutter')]),
          Column(children: [Text('5*')]),
        ]),
        TableRow(children: [
          Column(children: [Text('Javatpoint')]),
          Column(children: [Text('MySQL')]),
          Column(children: [Text('5*')]),
        ]),
        TableRow(children: [
          Column(children: [Text('Javatpoint')]),
          Column(children: [Text('ReactJS')]),
          Column(children: [Text('5*')]),
        ]),
      ],
    );
  }
}
