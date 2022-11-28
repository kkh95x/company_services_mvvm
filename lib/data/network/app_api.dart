import 'package:dio/dio.dart';
import 'package:mvvm_desgin_app/app/constants.dart';

import 'package:retrofit/http.dart';

import '../responses/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);
  @POST("/customer/forgetpassword")
  Future<ForgetPasswordResponse > forgetPassword(
      @Field("email") String email, );
    @POST("/customers/signup")
  Future<AuthenticationResponse > signUp(
      @Field("username") String username, 
       
          @Field("mobile-number") String mobileNumber, 
            @Field("email") String email, 
              @Field("password") String password, 

      
      );
        @GET("/home")
  Future<HomeResponse> getHome();
}
