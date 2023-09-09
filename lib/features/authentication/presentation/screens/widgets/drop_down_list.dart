import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/size_config.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = gender.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: purple[2])),
        padding: const EdgeInsets.only(left: 10),
        width: sw!,
        child: DropdownButton<String>(
          alignment: Alignment.centerLeft,
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down_sharp,
            color: Colors.black,
          ),
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
          elevation: 16,
          style: TextStyles.inter.copyWith(fontSize: 14),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: gender.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: TextStyles.inter.copyWith(fontSize: 14)));
          }).toList(),
        ));
  }
}
