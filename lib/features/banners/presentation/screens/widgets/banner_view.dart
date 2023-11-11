import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/utils/size_config.dart';

import '../../../../../core/utils/endpoint.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../data/models/banner_model.dart';

class BannerView extends StatelessWidget {
  const BannerView(
      {super.key, required this.banners, required this.controller});

  final List<BannerModel> banners;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              controller: controller,
              itemCount: banners.length,
              itemBuilder: (context, index) => CachedNetworkImage(
                  imageUrl: Endpoints.storageUrl + banners[index].image,
                  placeholder: (context, url) => const LoadingWidget(
                        color: Colors.transparent,
                      ),
                  errorWidget: (context, url, error) => const SizedBox(
                      height: 60,
                      width: 60,
                      child: Icon(Icons.error, color: Colors.black)),
                  imageBuilder: (context, imageProvider) => Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                            width: sw! * 0.97,
                            height: sh! * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover, image: imageProvider))),
                      )),
            ))));
  }
}
