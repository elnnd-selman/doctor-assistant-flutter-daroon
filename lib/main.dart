import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hezr/app/routes/app_pages.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/constants/app_constants.dart';
import 'package:hezr/global/constants/size_config.dart';

void main() {
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: false,
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
          key: MyApp.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Hezr',
          getPages: AppPages.routes,
          defaultTransition: Transition.cupertino,
          initialRoute: AppPages.initial,
          theme: ThemeData(
            fontFamily: kFontFamily,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: AppColors.blackBGColor,
          ),
        );
      });
    });
  }
}
