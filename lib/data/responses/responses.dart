// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_desgin_app/data/responses/responses.dart';


part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotification")
  int? numOfNotification;
  CustomerResponse(
    this.id,
    this.name,
    this.numOfNotification,
  );
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> tojson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(
    this.phone,
    this.email,
    this.link,
  );
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> tojson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(
    this.customer,
    this.contacts,
  );

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> tojson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgetPasswordResponse(
    this.support,
  );
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "image")
  String? image;
  ServicesResponse(
    this.id,
    this.title,
    this.image,
  );
  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;
  BannerResponse(
    this.id,
    this.title,
    this.image,
    this.link
  );
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "image")
  String? image;
  StoreResponse(
    this.id,
    this.title,
    this.image,
  );
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServicesResponse>? services;
  @JsonKey(name: "banners")
  List<BannerResponse>? banners;
  @JsonKey(name: "stores")
  List<StoreResponse>? stores;

  
  HomeDataResponse(
    this.services,
    this.banners,
    this.stores,
  );
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse? data;


  
  HomeResponse(
    this.data,

  );
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}