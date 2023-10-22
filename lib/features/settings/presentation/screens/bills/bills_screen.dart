import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_back_button.dart';
import 'widgets/bills_item.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: sh!,
                  color: Colors.white,
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(top: sh! * 0.12, right: 0),
                    // top: (sh! * 0.12),
                    //  right: 0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: const Center(
                                        child: Icon(
                                      //  splashRadius: 10,
                                      //  iconSize: 20,
                                      //   padding: paddingAll(0),

                                      Icons.navigate_next,
                                      color: appPrimaryColor,
                                      size: 20,

                                      //  onPressed: () => ,
                                    )),
                                  ))
                            ],
                          )
                        ]),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.only(top: sh! * 0.1),
                      child: Container(
                        width: sw!,
                        height: sh! * 0.2,
                        decoration: BoxDecoration(
                          boxShadow: boxShadow2,
                          borderRadius: BorderRadius.circular(25),
                          color: appPrimaryColor.withOpacity(0.22),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: sh! * 0.05),
                            child: AutoSizeText(
                              'Bills',
                              style: TextStyles.inter.copyWith(
                                  fontSize: 40,
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            )),
                      )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Positioned(
                    top: sh! * 0.25,
                    bottom: 0,
                    child: Container(
                        width: sw!,
                        height: sh!,
                        margin: const EdgeInsets.only(bottom: 80),
                        decoration: const BoxDecoration(
                          //  boxShadow: boxShadow2,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          color: appPrimaryColor,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, item) =>
                                    const BillsItem())))),
              ],
            )));
  }
}
