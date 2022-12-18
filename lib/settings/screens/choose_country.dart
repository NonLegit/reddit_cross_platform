import 'package:flutter/material.dart';
import '../../constants/countries.dart';
import '../provider/user_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_snack_bar.dart';

class ChooseCountry extends StatelessWidget {
  static const routeName = '/choosecountry';
  final UserSettingsProvider? provider;
  final Function handler;
  ChooseCountry({Key? key, this.provider, required this.handler})
      : super(key: key);
  final countries = Countries().countries;
  void choseCountry(context, index) async {
    provider?.userPrefrence!.country = countries[index];
    await provider!.ChangePrefs(provider!.userPrefrence!.toJson(), context);
    handler();
    Navigator.of(context).pop();
    if (provider!.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change allow fllowing you  succefuhly',
            disableStatus: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select country/region'),
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
            separatorBuilder: (_, __) => const Divider(
                  height: 0,
                  thickness: 2,
                ),
            itemCount: countries.length));
  }
}
