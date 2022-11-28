import 'package:flutter/material.dart';

import 'package:mvvm_desgin_app/app/di.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:mvvm_desgin_app/presentation/register/view_model/register_view_model.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';

import '../../resource/assets_manager.dart';
import '../../resource/routes_manager.dart';
import '../../resource/string_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _rViewModel = instance<RegisterViewModel>();
  GlobalKey _keyForm = GlobalKey<FormState>();

  final TextEditingController _usernamrTextEditingController =
      TextEditingController();
  final TextEditingController _passworTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _numberTextEditingController =
      TextEditingController();
  _bind() {
    _rViewModel.start();
    _usernamrTextEditingController.addListener(() {
      _rViewModel.setUserName(_usernamrTextEditingController.text);
    });
    _passworTextEditingController.addListener(() {
      _rViewModel.setPassword(_passworTextEditingController.text);
    });
    _emailTextEditingController.addListener(() {
      _rViewModel.setEmail(_emailTextEditingController.text);
    });
    _numberTextEditingController.addListener(() {
      _rViewModel.setMobileNumber(_numberTextEditingController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _rViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getScreenWidget(context, _getConectWidget(), () {}) ??
              _getConectWidget();
        },
      ),
    );
  }

  Widget _getConectWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPading.p18),
      child: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder<String?>(
                    stream: _rViewModel.outputErrorUsername,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.text,
                        controller: _usernamrTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppString.name,
                            labelText: AppString.name,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder<String?>(
                    stream: _rViewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppString.email,
                            labelText: AppString.email,
                            errorText: snapshot.data
                            ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder<String?>(
                    stream: _rViewModel.outputErrorMobileNumber,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.number,
                        controller: _numberTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppString.mobileNumber,
                            labelText: AppString.mobileNumber,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder<String?>(
                    stream: _rViewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passworTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppString.password,
                            labelText: AppString.password,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPading.p28),
                child: StreamBuilder<bool>(
                    stream: _rViewModel.outputArrAllValide,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _rViewModel.register();
                                  }
                                : null,
                            child: const Text(AppString.register)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPading.p18,
                    left: AppPading.p28,
                    right: AppPading.p28),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppString.alredyHaveAcount,
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _rViewModel.dispose();
  }
}
