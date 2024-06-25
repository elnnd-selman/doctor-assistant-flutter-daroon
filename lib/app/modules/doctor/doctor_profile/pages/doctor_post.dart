import 'package:flutter/material.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/widget/doctor_image_post.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/widget/doctor_text_post.dart';

import 'package:hezr/global/constants/size_config.dart';

class DoctorPost extends StatelessWidget {
  const DoctorPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DoctorImagePostContainer(),
        SizedBox(height: 2 * SizeConfig.heightMultiplier),
        const DoctorTextPostContainer(),
        SizedBox(height: 10 * SizeConfig.heightMultiplier),
      ],
    );
  }
}