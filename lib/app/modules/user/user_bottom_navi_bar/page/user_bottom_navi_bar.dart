import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hezr/app/modules/doctor/doctor_add_post/pages/doctor_add_post.dart';
import 'package:hezr/app/modules/doctor/doctor_appointment/pages/doctor_appointment_screen.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/app_bars/doctor_appointment_app_bar.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/app_bars/doctor_home_app_bar.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/app_bars/doctor_post_app_bar.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/app_bars/doctor_profile_app_bar.dart';
import 'package:hezr/app/modules/doctor/doctor_home/page/doctor_home_screen.dart';
import 'package:hezr/app/modules/doctor/doctor_profile/pages/doctor_profile.dart';
import 'package:hezr/app/modules/user/user_bottom_navi_bar/app_bars/user_home_app_bar.dart';
import 'package:hezr/app/modules/user/user_home/pages/user_home_screen.dart';
import 'package:hezr/app/modules/user/user_top_doctors/pages/user_top_doctor_screen.dart';
import 'package:hezr/generated/assets.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/size_config.dart';

class UserBottomNaviBar extends StatefulWidget {
  const UserBottomNaviBar({super.key});

  @override
  State<UserBottomNaviBar> createState() => _UserBottomNaviBarState();
}

class _UserBottomNaviBarState extends State<UserBottomNaviBar>
    with TickerProviderStateMixin {
  int currentValue = 0;

  AnimationController? _controller;
  Animation<double>? _animation;

  AnimationController? _controller2;
  Animation<double>? _animation2;

  AnimationController? _controller3;
  Animation<double>? _animation3;

  AnimationController? _controller4;
  Animation<double>? _animation4;

  AnimationController? _controller5;
  Animation<double>? _animation5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(
            begin: SizeConfig.heightMultiplier * 2.0,
            end: SizeConfig.heightMultiplier * 2.5)
        .animate(CurvedAnimation(
            parent: _controller!,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation2 = Tween<double>(
            begin: SizeConfig.heightMultiplier * 2.0,
            end: SizeConfig.heightMultiplier * 2.5)
        .animate(CurvedAnimation(
            parent: _controller2!,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation3 = Tween<double>(
            begin: SizeConfig.heightMultiplier * 2.8,
            end: SizeConfig.heightMultiplier * 3)
        .animate(CurvedAnimation(
            parent: _controller3!,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller4 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation4 = Tween<double>(
            begin: SizeConfig.heightMultiplier * 2.8,
            end: SizeConfig.heightMultiplier * 3)
        .animate(CurvedAnimation(
            parent: _controller4!,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller5 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation5 = Tween<double>(
            begin: SizeConfig.heightMultiplier * 2.8,
            end: SizeConfig.heightMultiplier * 3)
        .animate(CurvedAnimation(
            parent: _controller5!,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller2!.dispose();
    _controller3!.dispose();
    _controller4!.dispose();
    _controller5!.dispose();
    super.dispose();
  }

  final List _appBars = [
    const UserHomeAppBar(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  final List pagesList = [
    const UserHomeScreen(),
    const UserTopDoctorScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: _appBars[currentValue],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: pagesList[currentValue],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: size.width * .16,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.whiteBGColor,
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: const Color(0xffC4C4C4).withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _bottomIcons(
                      size: _animation!.value,
                      icon: Assets.homeIcon,
                      color: currentValue == 0
                          ? AppColors.primaryColor
                          : const Color(0xff979797),
                      ontap: () {
                        setState(() {
                          currentValue = 0;
                          _controller!.forward();
                          _controller2!.reverse();
                          _controller3!.reverse();
                          _controller4!.reverse();
                          _controller5!.reverse();
                          HapticFeedback.lightImpact();
                        });
                      }),
                  _bottomIcons(
                      size: _animation2!.value,
                      icon: Assets.addBottomIcon,
                      color: currentValue == 1
                          ? AppColors.primaryColor
                          : const Color(0xff979797),
                      ontap: () {
                        setState(() {
                          currentValue = 1;
                          _controller2!.forward();
                          _controller!.reverse();
                          _controller3!.reverse();
                          _controller4!.reverse();
                          _controller5!.reverse();
                          HapticFeedback.lightImpact();
                        });
                      }),
                  _bottomIcons(
                      size: _animation3!.value,
                      icon: Assets.reelIcon,
                      color: currentValue == 2
                          ? AppColors.primaryColor
                          : const Color(0xff979797),
                      ontap: () {
                        setState(() {
                          currentValue = 2;
                          _controller3!.forward();
                          _controller!.reverse();
                          _controller2!.reverse();
                          _controller4!.reverse();
                          _controller5!.reverse();
                          HapticFeedback.lightImpact();
                        });
                      }),
                  _bottomIcons(
                      size: _animation4!.value,
                      icon: Assets.calendarIcon,
                      color: currentValue == 3
                          ? AppColors.primaryColor
                          : const Color(0xff979797),
                      ontap: () {
                        setState(() {
                          currentValue = 3;
                          _controller4!.forward();
                          _controller!.reverse();
                          _controller2!.reverse();
                          _controller3!.reverse();
                          _controller5!.reverse();
                          HapticFeedback.lightImpact();
                        });
                      }),
                  _bottomIcons(
                      size: _animation5!.value,
                      icon: Assets.profileIcon,
                      color: currentValue == 4
                          ? AppColors.primaryColor
                          : const Color(0xff979797),
                      ontap: () {
                        setState(() {
                          currentValue = 4;
                          _controller5!.forward();
                          _controller!.reverse();
                          _controller2!.reverse();
                          _controller3!.reverse();
                          _controller4!.reverse();
                          HapticFeedback.lightImpact();
                        });
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _bottomIcons({
    required String icon,
    required double size,
    required Color color,
    required Function()? ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 2 * SizeConfig.heightMultiplier, horizontal: 8),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              // ignore: deprecated_member_use
              color: color,
              height: size,
            ),
          ],
        ),
      ),
    );
  }
}