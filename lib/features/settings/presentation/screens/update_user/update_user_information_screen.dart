import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/widgets/app_snack_bar.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/services/location_service.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../home/presentation/screens/filter/widgets/filter_choice_box.dart';
import '../../../../salons/presentation/screens/widgets/salon_error_widget.dart';
import '../../bloc/settings_bloc.dart';
import 'widgets/update_user_info_loading_widget.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  const UpdateUserInfoScreen({super.key, required this.onPageChanged});

  final Function onPageChanged;

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
  String gender = '', token = '';

  Position? currentPosition;

  @override
  void initState() {
    token = Prefs.getString(Prefs.TOKEN) ?? '';
    getCurrentPosition();

    _settingsBloc = BlocProvider.of(context);
    _settingsBloc.add(GetUserDetailsEvent(token));

    super.initState();
  }

  void _refresh() {
    _settingsBloc.add(GetUserDetailsEvent(token));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocConsumer<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (_settingsBloc.state.customers != {} &&
                  _settingsBloc.state.customers != null &&
                  _settingsBloc.state.action != RequestType.updateUser) {
                user = _settingsBloc.state.customers!;

                isMale = user['gender'] == 'Male' ? true : false;

                mobileController.text = user['phone'] ?? '';
                emailController.text = user['email'] ?? '';
                nameController.text = user['fullname'] ?? '';
                addressController.text = user['address'] ?? '';
              }

              if (state.action == RequestType.updateUser) {
                if (state.status == FormzSubmissionStatus.success) {
                  openSnackBar(context, state.successMessage,
                      AnimatedSnackBarType.success);
                }

                if (state.status == FormzSubmissionStatus.failure) {
                  openSnackBar(
                      context, state.errorMessage, AnimatedSnackBarType.error);
                }
              }
            },
            listenWhen: (prev, curr) => prev.status != curr.status,
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              Widget? child;

              if (state.status == FormzSubmissionStatus.inProgress ||
                  state.status == FormzSubmissionStatus.initial) {
                child = const UpdateUserInfoLoadingWidget();
              }
              if (state.status == FormzSubmissionStatus.failure) {
                child = SalonErrorWidget(
                  onRefresh: () => _refresh(),
                  errorMessage: state.errorMessage,
                );
              }

              if (state.customers == {} && user == {}) {
                child = Text(l10n.userNotFound);
              }
              if (state.customers != {} && state.customers != null) {
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
                              l10n.name,
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
                              l10n.email,
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
                              l10n.address,
                              style: TextStyles.inter
                                  .copyWith(color: Colors.white, fontSize: 16),
                            ),
                            CustomTextFormField(
                              controller: addressController,
                              enabled: true,
                              onSaved: (e) {},
                              onChanged: (e) {},
                              keyboardType: TextInputType.text,
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
                              l10n.mobile,
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
                              l10n.gender,
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
                                  title: l10n.male,
                                  isSelected: isMale && gender.isEmpty
                                      ? true
                                      : gender == 'male'
                                          ? true
                                          : false,
                                ),
                                10.widthXBox,
                                FilterChoiceBox(
                                  onChanged: () {
                                    setState(() {
                                      gender = 'female';
                                    });
                                  },
                                  title: l10n.female,
                                  isSelected: !isMale && gender.isEmpty
                                      ? true
                                      : gender == 'female'
                                          ? true
                                          : false,
                                ),
                              ],
                            )
                          ],
                        )),
                    ...[
                      10.heightXBox,
                      AppButton(
                        title: l10n.update,
                        color: appFilterCoLOR,
                        borderColor: borderColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              addressController.text.isNotEmpty &&
                              mobileController.text.isNotEmpty) {
                            context.read<SettingsBloc>().add(UpdateUserEvent({
                                  'fullname': nameController.text,
                                  'phone': mobileController.text,
                                  'address': addressController.text,
                                  'gender': gender.isNotEmpty
                                      ? gender
                                      : isMale
                                          ? 'male'
                                          : 'female',
                                  'latitude': currentPosition?.latitude,
                                  'longitude': currentPosition?.longitude,
                                  'image': 'bbvnv',
                                  'birthday': "string",
                                }));
                          }
                        },
                      ),
                      10.heightXBox,
                      AppButton(
                          onPressed: () => widget.onPageChanged(),
                          borderColor: appFilterCoLOR,
                          title: l10n.cancel,
                          color: Colors.white,
                          textColor: appPrimaryColor),
                      20.heightXBox,
                    ]
                  ],
                );
              }
              return child!;
            }));
  }

  void getCurrentPosition() async {
    //  setState(() async {
    currentPosition = await Location().determinePosition();
    //  });
  }
}
