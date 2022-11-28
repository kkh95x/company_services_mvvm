import 'package:mvvm_desgin_app/data/mapper/mapper.dart';
import 'package:mvvm_desgin_app/data/network/error_handler.dart';
import 'package:mvvm_desgin_app/data/network/network_info.dart';
import 'package:mvvm_desgin_app/data/responses/responses.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';

import 'package:mvvm_desgin_app/data/network/requests.dart';

import 'package:mvvm_desgin_app/data/network/faliure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository/repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

class RepositoryImpl implements Repository {
  final NewtworkInfo _networkInfoImpi;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  RepositoryImpl(
      this._networkInfoImpi, this._remoteDataSource, this._localDataSource);
  @override
  Future<Either<Faliuer, Authentication>> login(
      LoginRequest loginReauest) async {
    if (await _networkInfoImpi.isConnected) {
      //try get data from server by dio
      try {
        final AuthenticationResponse response =
            await _remoteDataSource.login(loginReauest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Faliuer(
              code: ApiInternalStatus.FALIUER,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      }
      //if have error dio handle it by ErrorHandler
      catch (error) {
        return left(ErrorHandler.handel(error).faliuer);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFaliuer());
    }
  }

  @override
  Future<Either<Faliuer, ForgetPassword>> forgetPassword(
      ForgetPassswordRequest forgetPassswordRequest) async {
    if (await _networkInfoImpi.isConnected) {
      try {
        final ForgetPasswordResponse response =
            await _remoteDataSource.forgetPassword(forgetPassswordRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return left(Faliuer(
              code: ApiInternalStatus.FALIUER,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        return left(ErrorHandler.handel(e).faliuer);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFaliuer());
    }
  }

  @override
  Future<Either<Faliuer, Authentication>> siginIn(
      SignInRequest signInRequest) async {
    if (await _networkInfoImpi.isConnected) {
      try {
        final AuthenticationResponse respose =
            await _remoteDataSource.signIn(signInRequest);
        if (respose.status == ApiInternalStatus.SUCCESS) {
          return right(respose.toDomain());
        } else {
          return left(Faliuer(
              code: respose.status ?? ApiInternalStatus.FALIUER,
              message: respose.message ?? ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return left(ErrorHandler.handel(err).faliuer);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFaliuer());
    }
  }

  @override
  Future<Either<Faliuer, HomeObject>> getHome() async {
    try {
      final respose = await _localDataSource.getHome();

      return right(respose.toDomain());
    } catch (err) {
      if (await _networkInfoImpi.isConnected) {
        try {
          final respose = await _remoteDataSource.getHome();
          if (respose.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveHomeInCache(respose);
            return right(respose.toDomain());
          } else {
            return left(Faliuer(
                code: respose.status ?? ApiInternalStatus.FALIUER,
                message: respose.message ?? ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return left(ErrorHandler.handel(err).faliuer);
        }
      } else {
        return left(DataSource.NO_INTERNET_CONNECTION.getFaliuer());
      }
    }
  }
}
