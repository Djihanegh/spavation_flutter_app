import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/core/widgets/app_button.dart';
import 'package:spavation/features/salons/presentation/bloc/salon_bloc.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import 'widgets/filter_choice_box.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  DataMap filterOptions = {};
  late SalonBloc _salonBloc;

  @override
  void initState() {
    _salonBloc = BlocProvider.of(context);
    filterOptions = _salonBloc.state.filterOptions ?? {};

    if (filterOptions == null || filterOptions.isEmpty) {
      filterOptions = {'near_by': true, 'gender': 'men', 'open_now': true};
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: sh! * 0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'Search Filter',
                                  style: TextStyles.inter
                                      .copyWith(color: Colors.white),
                                ))),
                        const CustomBackButton(),
                      ],
                    ),
                    10.heightXBox,
                    Container(
                      width: sw! * 0.96,
                      padding: paddingAll(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*  AutoSizeText(
                            'Category',
                            style: TextStyles.inter
                                .copyWith(color: appPrimaryColor),
                          ),
                          10.heightXBox,
                          SizedBox(
                              width: sw!,
                              child: Wrap(
                                children: categories
                                    .map((item) => Padding(
                                        padding: paddingAll(3),
                                        child: Container(
                                          padding: paddingAll(3),
                                          height: 30,
                                          //width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              border: Border.all(
                                                  color: appPrimaryColor)),
                                          child: AutoSizeText(
                                            item,
                                            style: TextStyles.inter.copyWith(
                                                color: appPrimaryColor),
                                          ),
                                        )))
                                    .toList()
                                    .cast<Widget>(),
                              )),
                          const Divider(
                            thickness: 1,
                            color: dividerColor,
                          ),*/

                          AutoSizeText(
                            'Order By',
                            style: TextStyles.inter
                                .copyWith(color: appPrimaryColor),
                          ),
                          10.heightXBox,
                          const Divider(
                            thickness: 1,
                            color: dividerColor,
                          ),
                          5.heightXBox,
                          FilterChoiceBox(
                            onChanged: () {
                              setState(() {
                                filterOptions['near_by'] =
                                    !filterOptions['near_by'];
                              });
                            },
                            title: 'Near by',
                            isSelected:
                                filterOptions['near_by'] == true ? true : false,
                          ),
                          /*   5.heightXBox,
                           FilterChoiceBox(
                             onChanged: (){

                             },
                            title: 'Top rated',
                            isSelected: false,
                          ),*/
                          5.heightXBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FilterChoiceBox(
                                onChanged: () {
                                  setState(() {
                                    filterOptions['gender'] == 'men'
                                        ? filterOptions['gender'] = ''
                                        : filterOptions['gender'] = 'men';
                                  });
                                },
                                title: 'Men',
                                isSelected: filterOptions['gender'] == 'men'
                                    ? true
                                    : false,
                              ),
                              10.widthXBox,
                              FilterChoiceBox(
                                title: 'Women',
                                onChanged: () {
                                  setState(() {
                                    filterOptions['gender'] == 'women'
                                        ? filterOptions['gender'] = ''
                                        : filterOptions['gender'] = 'women';
                                  });
                                },
                                isSelected: filterOptions['gender'] == 'women'
                                    ? true
                                    : false,
                              ),
                              10.widthXBox,
                              FilterChoiceBox(
                                onChanged: () {
                                  setState(() {
                                    filterOptions['gender'] == 'both'
                                        ? filterOptions['gender'] = ''
                                        : filterOptions['gender'] = 'both';
                                  });
                                },
                                title: 'Men and Women',
                                isSelected: filterOptions['gender'] == 'both'
                                    ? true
                                    : false,
                              ),
                            ],
                          ),
                          5.heightXBox,
                          FilterChoiceBox(
                            onChanged: () {
                              setState(() {
                                filterOptions['open_now'] =
                                    !filterOptions['open_now'];
                              });
                            },
                            title: 'Open now',
                            isSelected: filterOptions['open_now'] == true
                                ? true
                                : false,
                          ),
                          (sh! * 0.05).heightXBox,
                          const Divider(
                            thickness: 1,
                            color: dividerColor,
                          ),
                          AppButton(
                              onPressed: () {
                                context
                                    .read<SalonBloc>()
                                    .add(SelectFilterOptions(filterOptions));
                                Navigator.pop(context);
                              },
                              title: 'Apply now',
                              color: appFilterCoLOR,
                              textColor: Colors.white)
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
                top: -10,
                left: -25,
                child: Container(
                  height: sh! * 0.17,
                  width: sw! * 0.35,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.35),
                      borderRadius: appCircular),
                )),
          ],
        )));
  }
}
