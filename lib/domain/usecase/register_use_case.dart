import 'package:dartz/dartz.dart';

import '../../data/network/faliure.dart';
import '../../data/network/requests.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RigisterUseCase
    implements BaseUseCases<RigisterUseCaseInput, Authentication> {
  final Repository _repository;
  RigisterUseCase(this._repository);

  @override
  Future<Either<Faliuer, Authentication>> execute(
      RigisterUseCaseInput input) async {
    return await _repository.siginIn(SignInRequest(
        username: input.username,
   
        mobileNumber: input.mobileNumber,
       
        password: input.password,
        email: input.password));
  }
}

class RigisterUseCaseInput {
  String username;

  String mobileNumber;
  String email;
  String password;

  RigisterUseCaseInput({
    required this.username,

    required this.mobileNumber,
    required this.email,
    required this.password,

  });
}
