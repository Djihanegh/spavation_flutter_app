import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/features/banners/presentation/bloc/banner_bloc.dart';
import '../../../../core/utils/size_config.dart';
import 'widgets/banner_error_widget.dart';
import 'widgets/banner_shimmer.dart';
import 'widgets/banner_view.dart';

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
        listener: (context, state) => _onStateListenHandler(),
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
            child = BannerView(
              banners: state.banners,
              controller: sliderController,
            );
          }

          return child;
        });
  }

  void _onStateListenHandler() {
    Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (sliderController.hasClients) {
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
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    sliderController.dispose();
  }
}
