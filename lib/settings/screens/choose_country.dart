import 'package:flutter/material.dart';
import '../../constants/countries.dart';

class ChooseCountry extends StatelessWidget {
  static const routeName = '/choosecountry';
  ChooseCountry({Key? key}) : super(key: key);
  final countries = Countries().countries;
  void choseCountry(context, index) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select country/region'),
        ),
        body: ListView.separated(
            itemBuilder: (_, index) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0, padding: EdgeInsets.all(0)),
                onPressed: () {
                  choseCountry(context, index);
                },
                child: ListTile(
                    leading: Text(textAlign: TextAlign.left, countries[index])),
              );
            },
            separatorBuilder: (_, __) => Divider(
                  height: 0,
                  thickness: 2,
                ),
            itemCount: countries.length));
  }
}
