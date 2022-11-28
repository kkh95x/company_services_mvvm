import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mvvm_desgin_app/presentation/resource/assets_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/constants_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/routes_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  //for splash screen closed
  Timer? _timer;
  final _appPref = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(Duration(seconds: AppConstants.splashDely), _goNext);
  }

  _goNext() async {
    _appPref.isUerLogin().then((isUerLogin) {
      if (isUerLogin) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPref.isOnBoardingViewed().then((isOnBoardingViewed) {
          if(isOnBoardingViewed){
           Navigator.pushReplacementNamed(context, Routes.LoginRoute);

          }else{
           Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);

          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: Image(
        image: AssetImage(ImageAssets.splashLogo),
      )),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
