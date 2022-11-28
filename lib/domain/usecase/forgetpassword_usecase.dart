import 'package:mvvm_desgin_app/data/network/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_desgin_app/data/network/requests.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/domain/repository/repository.dart';
import 'package:mvvm_desgin_app/domain/usecase/base_usecase.dart';

class ForgetPasswordUseCase implements BaseUseCases<String, ForgetPassword> {
  Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Faliuer, ForgetPassword>> execute(String email) async {
    return await _repository.forgetPassword(ForgetPassswordRequest(email));
  }
}
