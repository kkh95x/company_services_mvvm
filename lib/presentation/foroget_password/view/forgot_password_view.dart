import 'package:flutter/material.dart';
import 'package:mvvm_desgin_app/app/di.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer_impl.dart';

import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';

import '../../resource/assets_manager.dart';
import '../../resource/string_manager.dart';
import '../../resource/values_manager.dart';
import '../view_model/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _keyForm = GlobalKey();
  final _fpViewModel = instance<ForgetPasswordViewModel>();
  TextEditingController _emailTextEditController = TextEditingController();
  _bind() {
    _emailTextEditController.addListener(() {
      _fpViewModel.setEmail(_emailTextEditController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _fpViewModel.outputState,
      builder: (context, snapshot) {
        return Scaffold(
            backgroundColor: ColorManager.white,
            body: snapshot.data
                    ?.getScreenWidget(context, _getContentScreen(), () {}) ??
                _getContentScreen());
      },
    );
  }

  Widget _getContentScreen() {
    return Container(
        padding: const EdgeInsets.only(top: AppPading.p100),
        child: SingleChildScrollView(
            child: Form(
                key: _keyForm,
                child: StreamBuilder(
                  stream: _fpViewModel.isEmailValid,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        const Center(
                            child: Image(
                                image: AssetImage(ImageAssets.splashLogo))),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextEditController,
                          decoration: InputDecoration(
                              hintText: AppString.username,
                              labelText: AppString.username,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppString.usernameError),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _fpViewModel.forgetPasswordSend();
                                    }
                                  : null,
                              child: const Text(AppString.find)),
                        )
                      ],
                    );
                  },
                ))));
  }

  @override
  void dispose() {
    _fpViewModel.dispose();
    super.dispose();
  }
}
