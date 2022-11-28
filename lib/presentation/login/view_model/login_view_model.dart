import 'dart:async';

import 'package:mvvm_desgin_app/domain/usecase/login_usecase.dart';
import 'package:mvvm_desgin_app/presentation/base/base_view_model.dart';
import 'package:mvvm_desgin_app/presentation/common/freeed_data_class.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with InputLoginViewModel, OutputLoginViewModel {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isLoginSuccessfullyStreamController =
      StreamController<bool>();

  LoginObject _loginObject = LoginObject("", "");
  final _appPref = instance<AppPreferences>();

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void start() {
    inputState.add(ContantState());
  }

  @override
  void dispose() {
    super.dispose();
    _areAllInputValidStreamController.close();
    _passwordStreamController.close();
    _usernameStreamController.close();
    isLoginSuccessfullyStreamController.close();
  }

//input ViewModel
  @override
  setPassword(String password) {
    _loginObject = _loginObject.copyWith(password: password);
    _passwordStreamController.add(password);
    areAllInputValid.add(null);
  }

  @override
  setUsername(String username) {
    _loginObject = _loginObject.copyWith(username: username);
    _usernameStreamController.add(username);
    areAllInputValid.add(null);
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.poupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(_loginObject.username, _loginObject.password)))
        .fold((faliuer) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: faliuer.message));
    }, (authentication) {
      inputState.add(ContantState());
      _appPref.setUserLogin();
      isLoginSuccessfullyStreamController.sink.add(true);
    });
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get areAllInputValid => _areAllInputValidStreamController.sink;

//output ViewModel
  @override
  Stream<bool> get outIsPasswordVaild => _passwordStreamController.stream
      .map((password) => _isPasswordVaild(password));

  @override
  Stream<bool> get outIsUsernameVaild => _usernameStreamController.stream
      .map((username) => _isUsernameVaild(username));
  @override
  Stream<bool> get outIsAreAllInputValid =>
      _areAllInputValidStreamController.stream
          .map((_) => _isAreAllInputValid());
  bool _isPasswordVaild(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameVaild(String username) {
    return username.isNotEmpty;
  }

  bool _isAreAllInputValid() => (_isPasswordVaild(_loginObject.password) &&
      _isUsernameVaild(_loginObject.username));
}

abstract class InputLoginViewModel {
  setUsername(String username);
  setPassword(String password);
  login();
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get areAllInputValid;
}

abstract class OutputLoginViewModel {
  Stream<bool> get outIsUsernameVaild;
  Stream<bool> get outIsPasswordVaild;
  Stream<bool> get outIsAreAllInputValid;
}
