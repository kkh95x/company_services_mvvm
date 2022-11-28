import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mvvm_desgin_app/data/responses/responses.dart';

abstract class NewtworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpi implements NewtworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImpi(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
