import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_desgin_app/app/app_prefs.dart';
import 'package:mvvm_desgin_app/data/data_source/local_data_source.dart';
import 'package:mvvm_desgin_app/data/data_source/remote_data_source.dart';
import 'package:mvvm_desgin_app/data/network/app_api.dart';
import 'package:mvvm_desgin_app/data/network/dio_factory.dart';
import 'package:mvvm_desgin_app/data/network/network_info.dart';
import 'package:mvvm_desgin_app/data/repository/repository_impl.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/domain/repository/repository.dart';
import 'package:mvvm_desgin_app/domain/usecase/forgetpassword_usecase.dart';
import 'package:mvvm_desgin_app/domain/usecase/get_home_usecase.dart';
import 'package:mvvm_desgin_app/domain/usecase/login_usecase.dart';
import 'package:mvvm_desgin_app/presentation/foroget_password/view_model/forgot_password_view_model.dart';
import 'package:mvvm_desgin_app/presentation/login/view_model/login_view_model.dart';
import 'package:mvvm_desgin_app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:mvvm_desgin_app/presentation/register/view_model/register_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/register_use_case.dart';

final instance = GetIt.instance;

Future<void> initAppModel() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>((() => sharedPreferences));

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NewtworkInfo>(
      () => NetworkInfoImpi(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));
        instance.registerLazySingleton<LocalDataSource>(
      () =>LocalDataSourceImpl());

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

loginIntModel() {
  if (!instance.isRegistered<LoginViewModel>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repository>()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(instance<LoginUseCase>()));
  }
}

ForgetPasswordModel() {
  if (!instance.isRegistered<ForgetPasswordViewModel>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}
registerInitModel() {
  if (!instance.isRegistered<RegisterViewModel>()) {
    instance.registerFactory<RigisterUseCase>(
        () => RigisterUseCase(instance<Repository>()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance<RigisterUseCase>()));
  }
}
initHomeModel() {
  if (!instance.isRegistered<HomeViewModel>()) {
    instance.registerFactory<HomeUseCase>(
        () => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(instance()));
  }
}
