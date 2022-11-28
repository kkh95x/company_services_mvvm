import 'package:flutter/material.dart';
import 'package:mvvm_desgin_app/presentation/foroget_password/view/forgot_password_view.dart';
import 'package:mvvm_desgin_app/presentation/login/view/login_view.dart';
import 'package:mvvm_desgin_app/presentation/main/main_view.dart';
import 'package:mvvm_desgin_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:mvvm_desgin_app/presentation/register/view/register_view.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';
import 'package:mvvm_desgin_app/presentation/splash/splash_view.dart';
import 'package:mvvm_desgin_app/presentation/store_details/store_details.dart';

import '../../app/di.dart';

class Routes {
  static const String splashRoute = "/";
  static const String LoginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoardingRoute = "/onBoarding";
}

class RoutesGenerator {
  static Route<dynamic> getRpute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.LoginRoute:
        loginIntModel();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        registerInitModel();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        ForgetPasswordModel();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModel();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      default:
        return unDefindRoute();
    }
  }

  static Route<dynamic> unDefindRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppString.noRouteFound),
                centerTitle: true,
              ),
              body: const Center(
                child: Text(AppString.noRouteFound),
              ),
            ));
  }
}
