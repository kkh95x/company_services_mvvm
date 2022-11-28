import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:mvvm_desgin_app/app/di.dart';

import 'package:mvvm_desgin_app/presentation/login/view_model/login_view_model.dart';
import 'package:mvvm_desgin_app/presentation/resource/assets_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../resource/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final _formKey = GlobalKey();

  _bind() {
    _loginViewModel.start();
    _usernameEditingController.addListener(() {
      _loginViewModel.setUsername(_usernameEditingController.text);
    });
    _passwordEditingController.addListener(() {
      _loginViewModel.setPassword(_passwordEditingController.text);
    });
    _loginViewModel.isLoginSuccessfullyStreamController.stream
        .listen((islogin) {
      if (islogin) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _loginViewModel.outputState,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: snapshot.data
                  ?.getScreenWidget(context, _getConectWidget(), () {}) ??
              _getConectWidget(),
        );
      },
    );
  }

  Widget _getConectWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPading.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder(
                    stream: _loginViewModel.outIsUsernameVaild,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameEditingController,
                        decoration: InputDecoration(
                            hintText: AppString.username,
                            labelText: AppString.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppString.usernameError),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder(
                    stream: _loginViewModel.outIsPasswordVaild,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordEditingController,
                        decoration: InputDecoration(
                          hintText: AppString.password,
                          labelText: AppString.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.passwordError,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder(
                    stream: _loginViewModel.outIsAreAllInputValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _loginViewModel.login();
                                  }
                                : null,
                            child: const Text(AppString.login)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPading.p8,
                    left: AppPading.p28,
                    right: AppPading.p28),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppString.forgetPassword,
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppString.registerText,
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewModel.dispose();
    
  }
}
