import 'package:mvvm_desgin_app/data/network/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/domain/repository/repository.dart';
import 'package:mvvm_desgin_app/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCases<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Faliuer, HomeObject>> execute(
      void input) async {
   return await _repository
        .getHome();
  }
}
