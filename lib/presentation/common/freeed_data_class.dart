
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freeed_data_class.freezed.dart';
@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}
@freezed
class  RegisterObject with _$RegisterObject {
  factory RegisterObject(
     String username,
  String mobileNumber,
  String email,
  String password,
    ) = _RegisterObject;
}
