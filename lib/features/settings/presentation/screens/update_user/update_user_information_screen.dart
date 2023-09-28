import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:formz/formz.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../../../../core/widgets/app_button.dart';
import '../../../../home/presentation/screens/filter/widgets/filter_choice_box.dart';
import '../../../../salons/presentation/screens/widgets/salon_error_widget.dart';
import '../../../../salons/presentation/screens/widgets/salon_loadig_widget.dart';
import '../../bloc/settings_bloc.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  const UpdateUserInfoScreen({super.key});

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late SettingsBloc _settingsBloc;

  Map<String, dynamic> user = {};
  bool isMale = false;
  String gender = 'male', token = '';

  @override
  void initState() {
    token = Prefs.getString(Prefs.TOKEN) ?? '';

    _settingsBloc = BlocProvider.of(context);
    _settingsBloc.add(GetUserDetailsEvent(token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (state.customers != {} && state.customers != null) {
                user = state.customers!;
              }
            },
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              Widget? child;

              if (state.status == FormzSubmissionStatus.inProgress) {
                child = const SalonShimmer();
              }
              if (state.status == FormzSubmissionStatus.failure) {
                child = const SalonErrorWidget();
              }

              if (state.status == FormzSubmissionStatus.initial) {
                child = const SalonShimmer();
              }

              if (state.customers == {} && user == {}) {
                child = const Text('Not found ');
              }
              if (state.customers != {} && state.customers != null) {
                user = state.customers!;
                isMale = user['gender'] == 'Male' ? true : false;

                mobileController.text = user['phone'] ?? '';
                emailController.text = user['email'] ?? '';
                nameController.text = user['fullname'] ?? '';

                child = Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20, top: 20),
                        // , left: 20, right: 20
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Name',
                              style: TextStyles.inter
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            CustomTextFormField(
                              controller: nameController,
                              onSaved: (e) {},
                              onChanged: (e) {},
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        // , left: 20, right: 20
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Email',
                              style: TextStyles.inter
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            CustomTextFormField(
                              controller: emailController,
                              enabled: false,
                              onSaved: (e) {},
                              onChanged: (e) {},
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        // , left: 20, right: 20
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Address',
                              style: TextStyles.inter
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            CustomTextFormField(
                              controller: addressController,
                              enabled: true,
                              onSaved: (e) {},
                              onChanged: (e) {},
                              keyboardType: TextInputType.streetAddress,
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        // , left: 20, right: 20
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Mobile',
                              style: TextStyles.inter
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            CustomTextFormField(
                              controller: mobileController,
                              onSaved: (e) {},
                              onChanged: (e) {},
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        )),
                    /*  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      // , left: 20, right: 20
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Birthday',
                            style: TextStyles.inter
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                          GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    theme: picker.DatePickerTheme(
                                        headerColor: Colors.white,
                                        backgroundColor: appPrimaryColor,
                                        itemStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                        cancelStyle: TextStyles.inter.copyWith(
                                            color: appPrimaryColor,
                                            fontSize: 14),
                                        doneStyle: TextStyles.inter.copyWith(
                                            color: appPrimaryColor,
                                            fontSize: 14)),
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime.now(),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  birthdayController.text =
                                      '${date.day}/${date.month}/${date.year}';
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: CustomTextFormField(
                                controller: birthdayController,
                                enabled: false,
                                onSaved: (e) {},
                                onChanged: (e) {},
                                keyboardType: TextInputType.phone,
                              )),
                        ],
                      )),*/
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        // , left: 20, right: 20
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Gender',
                              style: TextStyles.inter
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            10.heightXBox,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FilterChoiceBox(
                                  onChanged: () {
                                    setState(() {
                                      gender = 'male';
                                    });
                                  },
                                  title: 'Male',
                                  isSelected: gender == 'male' ? true : false,
                                ),
                                10.widthXBox,
                                FilterChoiceBox(
                                  onChanged: () {
                                    setState(() {
                                      gender = 'female';
                                    });
                                  },
                                  title: 'Female',
                                  isSelected: gender == 'female' ? true : false,
                                ),
                              ],
                            )
                          ],
                        )),
                    ...[
                      10.heightXBox,
                      AppButton(
                        title: 'Update',
                        color: appFilterCoLOR,
                        borderColor: borderColor,
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      10.heightXBox,
                      const AppButton(
                          borderColor: appFilterCoLOR,
                          title: 'Cancel',
                          color: Colors.white,
                          textColor: appPrimaryColor),
                    ]
                  ],
                );
              }
              return child!;
            }));
  }
}
