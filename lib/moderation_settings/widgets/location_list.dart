import 'package:flutter/material.dart';

class LocationList extends StatelessWidget {
  final List<String> regions;
  final Function(String) changeLocation;
  String? value;
  LocationList(
      {super.key,
      required this.regions,
      required this.changeLocation,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on_outlined),
        DropdownButton(

            // autofocus: true,
            elevation: 0,
            // Initial Value
            value: value,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: regions.map((String items) {
              return DropdownMenuItem(
                value: items.toLowerCase(),
                child: Text(items.toLowerCase()),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (newValue) {
              changeLocation(newValue! as String);
            }),
      ],
    );
  }
}
