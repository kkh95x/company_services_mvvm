import 'dart:async';

import 'package:mvvm_desgin_app/app/constants.dart';
import 'package:mvvm_desgin_app/domain/usecase/forgetpassword_usecase.dart';
import 'package:mvvm_desgin_app/presentation/base/base_view_model.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInput, ForgetPasswordViewModelOutPut {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController isForgetEmailfullyStreamController =
      StreamController<bool>();
  String _email = "";
  @override
  void start() {
    isForgetEmailfullyStreamController.add(Constant());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    isForgetEmailfullyStreamController.close();
  }

  @override
  setEmail(String email) {
    _email = email;
    emailInput.add(email);
  }

  @override
  Sink get emailInput => _emailStreamController.sink;

  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValidChecker(email));

  bool _isEmailValidChecker(String email) => email.isNotEmpty;

  @override
  forgetPasswordSend() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.poupLoadingState));


    (await _forgetPasswordUseCase.execute(_email)).fold((l) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: l.message));
    }, (r) {
      inputState.add(SuccessState(stateRendererType: StateRendererType.popupSuccessState,message: r.support,));
    });
  }
}

abstract class ForgetPasswordViewModelInput {
  setEmail(String email);
  forgetPasswordSend();
  Sink get emailInput;
}

abstract class ForgetPasswordViewModelOutPut {
  Stream<bool> get isEmailValid;
}
