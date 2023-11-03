import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/features/cities/presentation/bloc/cities_bloc.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../localization/domain/entities/language.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import '../../../data/models/cities_model.dart';

class CitiesList extends StatefulWidget {
  const CitiesList({super.key});

  @override
  State<CitiesList> createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  String dropdownValue = '';

  @override
  void initState() {
    Language language = context.read<LanguageBloc>().state.selectedLanguage;
    if (language.value == Language.english.value) {
      dropdownValue = "Riyadh";
    } else {
      dropdownValue = "الرياض";
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
          return BlocConsumer<CityBloc, CityState>(
              listener: (context, state) {},
              buildWhen: (prev, curr) => prev.cities != curr.cities,
              builder: (context, state) {
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.white)),
                    padding: const EdgeInsets.only(left: 10),
                    width: sw! / 2,
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
                      items: state.cities != null
                          ? state.cities!.isNotEmpty
                              ? language.selectedLanguage.value ==
                                      Language.english.value
                                  ? state.cities!.map<DropdownMenuItem<String>>(
                                      (CitiesModel value) {
                                      return DropdownMenuItem<String>(
                                          value: value.name,
                                          child: Text(value.name,
                                              style: TextStyles.inter
                                                  .copyWith(fontSize: 14)));
                                    }).toList()
                                  : state.cities!.map<DropdownMenuItem<String>>(
                                      (CitiesModel value) {
                                      return DropdownMenuItem<String>(
                                          value: value.nameAr,
                                          child: Text(value.nameAr,
                                              style: TextStyles.inter
                                                  .copyWith(fontSize: 14)));
                                    }).toList()
                              : []
                          : [],
                    ));
              });
        });
  }
}
