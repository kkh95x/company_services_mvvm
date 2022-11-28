import 'package:mvvm_desgin_app/data/network/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_desgin_app/data/network/requests.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/domain/repository/repository.dart';
import 'package:mvvm_desgin_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCases<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Faliuer, Authentication>> execute(
      LoginUseCaseInput input) async {
   return await _repository
        .login(LoginRequest(email: input.email, password: input.Password));
  }
}

class LoginUseCaseInput {
  String email;
  String Password;
  LoginUseCaseInput(this.email, this.Password);
}
