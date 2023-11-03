import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/format_date.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../reservation/data/models/reservation_model.dart';

class BillsDetailsScreen extends StatefulWidget {
  const BillsDetailsScreen({super.key, required this.reservationModel});

  final ReservationModel reservationModel;

  @override
  State<BillsDetailsScreen> createState() => _BillsDetailsScreenState();
}

class _BillsDetailsScreenState extends State<BillsDetailsScreen> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    date = convertStringToDateTime(widget.reservationModel.createdAt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                Positioned(
                    top: (sh! * 0.12),
                    right: 0,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomBackButton(),
                            ],
                          )
                        ])),
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
                              l10n.bills,
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
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: paddingAll(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                  Endpoints.storageUrl +
                                      widget.reservationModel.logo,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              20.heightXBox,
                              const AutoSizeText(
                                'فاتورة ضريبية مبسطة',
                                style: TextStyle(
                                    fontFamily: 'Tahoma',
                                    fontWeight: FontWeight.bold),
                              ),
                              const AutoSizeText(
                                'Simplified Tax Invoice',
                                style: TextStyle(
                                    fontFamily: 'Tahoma',
                                    fontWeight: FontWeight.bold),
                              ),
                              20.heightXBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    widget.reservationModel.taxNumber,
                                    style: const TextStyle(
                                        fontFamily: 'Tahoma',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        'رقم التعريف الضريبي',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      ),
                                      AutoSizeText(
                                        'Tax Identification Number',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),

                              ///
                              ///
                              ///
                              20.heightXBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "${widget.reservationModel.id}",
                                    style: const TextStyle(
                                        fontFamily: 'Tahoma',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        'رقم الفاتورة / الطلب',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      ),
                                      AutoSizeText(
                                        'Invoice Number / Order Request',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),

                              ///
                              ///
                              ///
                              20.heightXBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    '${date.day}/${date.month}/${date.year}',
                                    style: const TextStyle(
                                        fontFamily: 'Tahoma',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        'تاريخ الفاتورة',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      ),
                                      AutoSizeText(
                                        'Invoice Date',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),

                              20.heightXBox,
                              const DottedLine(
                                dashLength: 5,
                                dashGapLength: 5,
                                lineThickness: 1,
                                dashColor: lightPurple,
                              ),
                              10.heightXBox,

                              const Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText('تفاصيل الفاتورة',
                                      style: TextStyle(
                                          fontFamily: 'Tahoma',
                                          fontWeight: FontWeight.bold))),
                              const Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText('Details',
                                      style: TextStyle(
                                          fontFamily: 'Tahoma',
                                          fontWeight: FontWeight.bold))),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    '${widget.reservationModel.serviceFee} SR',
                                    style: const TextStyle(
                                        fontFamily: 'Tahoma',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        'رسوم الخدمة',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      ),
                                      AutoSizeText(
                                        'Service Fees',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),

                              10.heightXBox,

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    '${widget.reservationModel.taxRate} %',
                                    style: const TextStyle(
                                        fontFamily: 'Tahoma',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        'معدل ضريبة القيمة المضافة',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      ),
                                      AutoSizeText(
                                        'VAT',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),

                              ///
                              ///
                              ///
                              10.heightXBox,

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    '${widget.reservationModel.totalTax} SR',
                                    style: const TextStyle(
                                        fontFamily: 'Tahoma',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        'إجمالي ضريبة القيمة المضافة التي جمعها',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      ),
                                      AutoSizeText(
                                        'Total VAT Collected',
                                        style: TextStyle(
                                            fontFamily: 'Tahoma',
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              30.heightXBox,
                              const DottedLine(
                                dashLength: 5,
                                dashGapLength: 5,
                                lineThickness: 1,
                                dashColor: lightPurple,
                              ),
                              10.heightXBox,

                              const Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'رمز الاستجابة السريع',
                                  style: TextStyle(
                                      fontFamily: 'Tahoma',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'QR Codes',
                                  style: TextStyle(
                                      fontFamily: 'Tahoma',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),

                              RepaintBoundary(
                                  key: const Key('1'),
                                  child: QrImageView(
                                    data:
                                        '{reservation status: ${widget.reservationModel.status} , reservation number: ${widget.reservationModel.id}, amount paid : ${widget.reservationModel.total} SR }',
                                    padding: const EdgeInsets.all(30),
                                    backgroundColor: Colors.white,
                                  ))
                            ],
                          )))),
                )
              ],
            )));
  }
}
