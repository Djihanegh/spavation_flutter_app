import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';
import 'package:spavation/features/localization/presentation/bloc/language_bloc.dart';

import '../../bloc/authentication_bloc.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key, required this.onChanged});

  final Function(String?) onChanged;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = '';

  @override
  void initState() {
    Language language = context.read<LanguageBloc>().state.selectedLanguage;
    if (language.value == Language.english.value) {
      dropdownValue = genderEn.first;
    } else {
      dropdownValue = genderAr.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, language) {},
        buildWhen: (prev, curr) =>
            prev.selectedLanguage != curr.selectedLanguage,
        builder: (context, language) {
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
                    widget.onChanged(value);
                  });
                },
                items: language.selectedLanguage.value == Language.english.value
                    ? genderEn.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style:
                                    TextStyles.inter.copyWith(fontSize: 14)));
                      }).toList()
                    : genderAr.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style:
                                    TextStyles.inter.copyWith(fontSize: 14)));
                      }).toList(),
              ));
        });
  }
}
