import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/features/banners/presentation/bloc/banner_bloc.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/loading_widget.dart';
import 'widgets/banner_error_widget.dart';
import 'widgets/banner_shimmer.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  late BannerBloc _bannerBloc;

  final PageController sliderController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();

    _bannerBloc = BlocProvider.of(context);
    _bannerBloc.add(const GetBannersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerBloc, BannerState>(
        listener: (context, state) {
          Timer.periodic(const Duration(seconds: 6), (Timer timer) {
            if (_currentPage == 2) {
              end = true;
            } else if (_currentPage == 0) {
              end = false;
            }

            if (end == false) {
              _currentPage++;
            } else {
              _currentPage--;
            }

            sliderController.animateToPage(
              _currentPage,
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
            );
          });
        },
        listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
        builder: (context, state) {
          Widget child = emptyWidget();

          if (state is BannerInProgressState) {
            child = Positioned(
                top: sh! * 0.125,
                right: sw! * 0.01,
                child: const BannerShimmer());
          }

          if (state is BannerLoadDataFailureState) {
            child = const BannerCustomErrorWidget();
          }
          if (state is BannerLoadDataSuccessState) {
            child = Positioned(
                top: sh! * 0.125,
                right: sw! * 0.01,
                child: Container(
                    width: sw! * 0.97,
                    height: sh! * 0.15,
                    // padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: PageView.builder(
                      allowImplicitScrolling: true,
                      onPageChanged: (value) {},
                      controller: sliderController,
                      itemCount: state.banners.length,
                      itemBuilder: (context, index) => CachedNetworkImage(
                          imageUrl:
                              Endpoints.storageUrl + state.banners[index].image,
                          placeholder: (context, url) => const LoadingWidget(
                                color: Colors.transparent,
                              ),
                          errorWidget: (context, url, error) => const SizedBox(
                              height: 60,
                              width: 60,
                              child: Icon(Icons.error, color: Colors.black)),
                          imageBuilder: (context, imageProvider) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                    width: sw! * 0.97,
                                    height: sh! * 0.15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: imageProvider))),
                              )),
                    ))));
          }

          return child;
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
