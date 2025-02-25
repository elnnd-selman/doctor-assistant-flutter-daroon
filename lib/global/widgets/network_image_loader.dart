import 'package:cached_network_image/cached_network_image.dart';
import 'package:daroon_doctor/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetWorkImageLoader extends StatelessWidget {
  final String imageURL;
  final double height;
  final double width;
  final BoxShape? shape;
  final Color? containerColor;
  final BoxFit? boxFit;

  const NetWorkImageLoader({
    super.key,
    required this.imageURL,
    required this.height,
    this.shape = BoxShape.rectangle,
    this.containerColor = Colors.black54,
    required this.width,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      fit: BoxFit.cover,
      width: width,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: boxFit),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: containerColor,
            shape: shape!,
          ),
          child: const Icon(Icons.error),
        );
      },
      placeholder: (context, url) {
        return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: containerColor,
              shape: shape!,
            ),
            child: const Center(child: LoadingWidget()));
      },
      placeholderFadeInDuration: 0.75.seconds,
    );
  }
}
