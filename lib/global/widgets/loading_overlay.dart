import 'dart:ui';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black.withOpacity(.1),
        child: const SpinKitSpinningLines(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: AppColors.primaryColor,
      size: 6 * SizeConfig.heightMultiplier,
    );
  }
}
