import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../../../../core/widgets/app_button.dart';
import '../../../../home/presentation/screens/filter/widgets/filter_choice_box.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
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
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                      onSaved: (e) {},
                      onChanged: (e) {},
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
            Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                                      color: appPrimaryColor, fontSize: 14),
                                  doneStyle: TextStyles.inter.copyWith(
                                      color: appPrimaryColor, fontSize: 14)),
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
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                        const FilterChoiceBox(
                          title: 'Male',
                          isSelected: true,
                        ),
                        10.widthXBox,
                        const FilterChoiceBox(
                          title: 'Female',
                          isSelected: false,
                        ),
                      ],
                    )
                  ],
                )),
            ...[
              10.heightXBox,
              const AppButton(
                  title: 'Update',
                  color: appFilterCoLOR,
                  borderColor: borderColor,
                  textColor: Colors.white),
              10.heightXBox,
              const AppButton(
                  borderColor: appFilterCoLOR,
                  title: 'Cancel',
                  color: Colors.white,
                  textColor: appPrimaryColor),
            ]
          ],
        ));
  }
}
