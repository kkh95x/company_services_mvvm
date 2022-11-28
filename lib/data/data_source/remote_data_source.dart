import 'package:mvvm_desgin_app/data/network/app_api.dart';
import 'package:mvvm_desgin_app/data/network/requests.dart';
import 'package:mvvm_desgin_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginReauest);
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPassswordRequest forgetPassswordRequest);
  Future<AuthenticationResponse> signIn(SignInRequest signInRequest);
    Future<HomeResponse> getHome();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) {
    return _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPassswordRequest forgetPassswordRequest) {
    return _appServiceClient.forgetPassword(forgetPassswordRequest.email);
  }

  @override
  Future<AuthenticationResponse> signIn(SignInRequest signInRequest) async {
    return await _appServiceClient.signUp(
        signInRequest.username,
        signInRequest.mobileNumber,
        signInRequest.email,
        signInRequest.password,
     );
  }
  
  @override
  Future<HomeResponse> getHome() async{
  return await _appServiceClient.getHome();
  }
}
