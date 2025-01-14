import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';

class DoctorDrawerWidget extends StatelessWidget {
  const DoctorDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCupertinoButton(
      onTap: () {
        if (ZoomDrawer.of(context)!.isOpen()) {
          ZoomDrawer.of(context)!.close();
        } else {
          ZoomDrawer.of(context)!.toggle();
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 1 * SizeConfig.heightMultiplier,
            left: 3 * SizeConfig.widthMultiplier),
        height: 4 * SizeConfig.heightMultiplier,
        width: 4 * SizeConfig.widthMultiplier,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.menuIcon,
              height: 20,
              width: 20,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
