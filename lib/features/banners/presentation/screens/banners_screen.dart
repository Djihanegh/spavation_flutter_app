import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/features/banners/presentation/bloc/banner_bloc.dart';

import '../../../../core/utils/size_config.dart';
import 'widgets/banner_error_widget.dart';
import 'widgets/banner_shimmer.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  late BannerBloc _bannerBloc;

  PageController sliderController =
      PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
    _bannerBloc = BlocProvider.of(context);
    _bannerBloc.add(const GetBannersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerBloc, BannerState>(
        listener: (context, state) {},
        listenWhen: (prev, curr) => prev.status != curr.status,
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          if (state.status == FormzSubmissionStatus.inProgress) {
            return Positioned(
                top: sh! * 0.125,
                right: sw! * 0.01,
                child: const BannerShimmer());
          }

          if (state.status == FormzSubmissionStatus.failure) {
            return const BannerErrorWidget();
          }

          return Positioned(
              top: sh! * 0.125,
              right: sw! * 0.01,
              child: Container(
                  width: sw! * 0.98,
                  height: sh! * 0.15,
                  // padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: PageView.builder(
                    onPageChanged: (value) {},
                    controller: sliderController,
                    itemCount: state.banners?.length ?? 0,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    Endpoints.storageUrl +
                                        state.banners![index].image,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const BannerShimmer();
                                    },
                                    errorBuilder:
                                        ((context, error, stackTrace) =>
                                            SizedBox(
                                                width: sw! * 0.99,
                                                height: sh! * 0.15,
                                                child: const Icon(Icons.error,
                                                    color: Colors.black))),
                                    fit: BoxFit.cover,
                                  ).image)),
                          width: sw! * 0.99,
                          height: sh! * 0.15,
                        )),
                  ))));
        });
  }
}
