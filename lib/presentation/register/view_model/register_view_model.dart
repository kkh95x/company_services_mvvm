import 'dart:async';

import 'package:analyzer/file_system/file_system.dart';
import 'package:mvvm_desgin_app/presentation/base/base_view_model.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';

import '../../../domain/usecase/register_use_case.dart';
import '../../common/freeed_data_class.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController usernameStreamController =
      StreamController<String>.broadcast();

  StreamController MobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();

  StreamController allInputAreVaildStreamController =
      StreamController<void>.broadcast();
  RegisterObject _registerObject = RegisterObject("", "", "", "");
  RigisterUseCase _rigisterUseCase;
  RegisterViewModel(this._rigisterUseCase);

  @override
  void start() {
    inputState.add(ContantState());
  }

  @override
  void dispose() {
    super.dispose();
    allInputAreVaildStreamController.close();

    passwordStreamController.close();
    emailStreamController.close();
    MobileNumberStreamController.close();

    usernameStreamController.close();
  }

  //--input

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => MobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePic => passwordStreamController.sink;

  @override
  Sink get inputUsername => usernameStreamController.sink;
  @override


  //----------output--------
  @override
  Stream<bool> get outputArrAllValide =>
      allInputAreVaildStreamController.stream.map((_) => _isAllValid());
  //username
  @override
  Stream<bool> get outputUsername => usernameStreamController.stream
      .map((username) => _isUsernameVaild(username));
  @override
  Stream<String?> get outputErrorUsername =>
      outputUsername.map((isUsernameVaild) =>
          isUsernameVaild ? null : AppString.registerUsernameError);

  //email
  @override
  Stream<bool> get outputEmail =>
      emailStreamController.stream.map((email) => _isEmail(email));

  @override
  Stream<String?> get outputErrorEmail => outputEmail.map(
      (isEmailVaild) => isEmailVaild ? null : AppString.registerEamilError);

//mobile number
  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputMobileNumber.map((isMobile) {
        return isMobile ? null : AppString.registerMobileNumberError;
      });

  @override
  Stream<bool> get outputMobileNumber => MobileNumberStreamController.stream
      .map((mobileNuber) => _isMobileNumber(mobileNuber));

//----password----//
  @override
  Stream<String?> get outputErrorPassword => outputPassword
      .map((isPassword) => isPassword ? null : AppString.passwordError);
  @override
  Stream<bool> get outputPassword =>
      passwordStreamController.stream.map((password) => _isPassword(password));

  // TODO: implement outputProfilePic

  //----------methoud-----------

  bool _isUsernameVaild(String username) {
    return (username.length > 6);
  }

  bool _isEmail(String email) {
    return (email.isNotEmpty);
  }

  bool _isMobileNumber(String number) {
    return (number.length > 9);
  }

  bool _isPassword(String password) {
    return password.length >= 8;
  }

  bool _isAllValid() {
    return _registerObject.username.isNotEmpty &&
        _registerObject.email.isNotEmpty &&
        _registerObject.password.isNotEmpty &&
        _registerObject.mobileNumber.isNotEmpty;
  }

  validetUpdateStreem() {
    inputArrAllVaild.add(null);
  }

  //-------Input Methoud-----//
  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.poupLoadingState));
    (await _rigisterUseCase.execute(RigisterUseCaseInput(
      username: _registerObject.username,
      mobileNumber: _registerObject.mobileNumber,
      email: _registerObject.email,
      password: _registerObject.password,
    )))
        .fold((l) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: l.message));
    }, (r) {
      inputState.add(SuccessState(
          stateRendererType: StateRendererType.popupSuccessState,
          message: AppString.successRigster));
    });
  }

  @override
  setEmail(String email) {
    if (_isEmail(email)) {
      _registerObject = _registerObject.copyWith(email: email);
      inputEmail.add(email);
    } else {
      _registerObject = _registerObject.copyWith(email: "");
    }
    validetUpdateStreem();
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (_isMobileNumber(mobileNumber)) {
      _registerObject = _registerObject.copyWith(mobileNumber: mobileNumber);
      inputMobileNumber.add(mobileNumber);
    } else {
      _registerObject = _registerObject.copyWith(mobileNumber: "");
    }
    validetUpdateStreem();
  }

  @override
  setPassword(String password) {
    if (_isPassword(password)) {
      _registerObject = _registerObject.copyWith(password: password);
      inputPassword.add(password);
    } else {
      _registerObject = _registerObject.copyWith(password: "");
    }
    validetUpdateStreem();
  }

  @override
  @override
  setUserName(String username) {
    if (_isUsernameVaild(username)) {
      _registerObject = _registerObject.copyWith(username: username);
      inputUsername.add(username);
    } else {
      _registerObject = _registerObject.copyWith(username: "");
    }
    validetUpdateStreem();
  }
  
  @override

  Sink get inputArrAllVaild => throw UnimplementedError();
}

abstract class RegisterViewModelInput {
  Sink get inputUsername;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;

  Sink get inputArrAllVaild;
  setUserName(String username);
  setPassword(String password);
  setMobileNumber(String mobileNumber);
  setEmail(String email);

  register();
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputUsername;
  Stream<bool> get outputMobileNumber;
  Stream<bool> get outputEmail;
  Stream<bool> get outputPassword;
  Stream<bool> get outputArrAllValide;

  Stream<String?> get outputErrorUsername;
  Stream<String?> get outputErrorMobileNumber;
  Stream<String?> get outputErrorEmail;
  Stream<String?> get outputErrorPassword;
}
