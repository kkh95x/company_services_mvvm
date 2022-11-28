import 'package:dartz/dartz.dart';
import 'package:mvvm_desgin_app/data/network/faliure.dart';
import 'package:mvvm_desgin_app/data/network/requests.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';

abstract class Repository {
  Future<Either<Faliuer, Authentication>> login(LoginRequest loginReauest);
    Future<Either<Faliuer, ForgetPassword>> forgetPassword(ForgetPassswordRequest forgetPassswordRequest);
  Future<Either<Faliuer, Authentication>> siginIn(SignInRequest signInRequest);
    Future<Either<Faliuer, HomeObject>> getHome();

}
