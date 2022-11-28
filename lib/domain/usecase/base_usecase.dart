import 'package:dartz/dartz.dart';
import 'package:mvvm_desgin_app/data/network/faliure.dart';

abstract class BaseUseCases<In,Out>{
  Future<Either<Faliuer,Out>> execute(In input);
}