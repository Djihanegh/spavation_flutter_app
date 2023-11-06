import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/cities/presentation/bloc/cities_bloc.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../localization/domain/entities/language.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import '../../../../salons/presentation/bloc/salon_bloc.dart';
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
        //   buildWhen: (prev, curr) =>
        //     prev.selectedLanguage != curr.selectedLanguage,
        builder: (context, language) {
          return BlocConsumer<CityBloc, CityState>(
              listener: (context, state) {
                DataMap query =
                    context.read<SalonBloc>().state.filterOptions ?? {};
                List<CitiesModel> cities =
                    context.read<CityBloc>().state.cities ?? [];
                CitiesModel? defaultCity;
                if (cities.isNotEmpty) {
                  defaultCity = cities
                      .firstWhere((element) => element.nameAr == "الرياض");
                }

                if (defaultCity != null) {
                  query['city'] = "${defaultCity.id}";
                  context.read<SalonBloc>().add(GetSalonsEvent(query));
                }
              },
              buildWhen: (prev, curr) => prev.cities != curr.cities,
              builder: (context, state) {
                DataMap query =
                    context.read<SalonBloc>().state.filterOptions ?? {};
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      alignment: Alignment.centerLeft,
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.white,
                      ),
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      elevation: 16,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      dropdownColor: appPrimaryColor.withOpacity(0.9),
                      style: TextStyles.inter
                          .copyWith(fontSize: 14, color: Colors.white),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });

                        if (language.selectedLanguage.value ==
                            Language.english.value) {
                          CitiesModel? city = state.cities != null
                              ? state.cities!.isNotEmpty
                                  ? state.cities!.firstWhere(
                                      (element) => element.name == value)
                                  : null
                              : null;

                          if (city != null) {
                            query['city'] = "${city.id}";
                            context
                                .read<SalonBloc>()
                                .add(GetSalonsEvent(query));
                          }
                        } else {
                          CitiesModel? city = state.cities != null
                              ? state.cities!.isNotEmpty
                                  ? state.cities!.firstWhere(
                                      (element) => element.nameAr == value)
                                  : null
                              : null;

                          if (city != null) {
                            query['city'] = "${city.id}";
                            context
                                .read<SalonBloc>()
                                .add(GetSalonsEvent(query));
                          }
                        }
                      },
                      items: state.cities != null
                          ? state.cities!.isNotEmpty
                              ? language.selectedLanguage.value ==
                                      Language.english.value
                                  ? state.cities!.map<DropdownMenuItem<String>>(
                                      (CitiesModel value) {
                                      return DropdownMenuItem<String>(
                                          value: value.name,
                                          child: AutoSizeText(value.name,
                                              style: TextStyles.inter.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.white)));
                                    }).toList()
                                  : state.cities!.map<DropdownMenuItem<String>>(
                                      (CitiesModel value) {
                                      return DropdownMenuItem<String>(
                                          value: value.nameAr,
                                          child: AutoSizeText(value.nameAr,
                                              style: TextStyles.inter.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.white)));
                                    }).toList()
                              : []
                          : [],
                    ));
              });
        });
  }
}
