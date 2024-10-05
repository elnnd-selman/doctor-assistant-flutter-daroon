import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferAddSuccesfully extends StatelessWidget {
  const OfferAddSuccesfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15 * SizeConfig.heightMultiplier),
          Center(
            child: Image.asset(
              'assets/images/successfullyOffer.png',
              height: 20 * SizeConfig.heightMultiplier,
            ),
          ),
          SizedBox(height: 4 * SizeConfig.heightMultiplier),
          Text(
            "Great! you add new offer\nsuccessfully.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bold.copyWith(
              fontSize: 22,
              color: const Color(0xff11142D),
            ),
          ),
          SizedBox(height: 4 * SizeConfig.heightMultiplier),
          Text(
            "it will be published with the key #123BC4\nwhen admin review it.",
            textAlign: TextAlign.center,
            style: AppTextStyles.normal.copyWith(
              fontSize: 14,
              color: const Color(0xff707281),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonButton(
                ontap: () {
                  Get.back();
                  Get.back();
                },
                name: 'Go To Offers'),
          )
        ],
      ),
    );
  }
}
