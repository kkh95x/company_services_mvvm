// ignore_for_file: public_member_api_docs, sort_constructors_first
//onboarding model
class SlidObject {
  String title;
  String subTitle;
  String imgeAsset;
  SlidObject(
    this.title,
    this.subTitle,
    this.imgeAsset,
  );
}

class SliderViewObject {
  SlidObject slidObject;
  int numOfslides;
  int currentIndex;
  SliderViewObject(
    this.slidObject,
    this.numOfslides,
    this.currentIndex,
  );
}

class Customer {
  String id;
  String name;
  int numOfNotification;
  Customer({
    required this.id,
    required this.name,
    required this.numOfNotification,
  });
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class Authentication {
  Customer? customer;

  Contacts? contacts;
  Authentication({
    required this.customer,
    required this.contacts,
  });
}

class ForgetPassword {
  String support;
  ForgetPassword(this.support);
}

class Services {
  String id;
  String title;

  String image;
  Services(
    this.id,
    this.title,
    this.image,
  );
}

class BannerAd {
  String id;
  String title;
  String link;
  String image;
  BannerAd(
    this.id,
    this.title,
    this.image,
    this.link,
  );
}

class Store {
  String id;
  String title;

  String image;
  Store(
    this.id,
    this.title,
    this.image,
  );
}

class HomeData {
  List<Services> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(
    this.services,
    this.banners,
    this.stores,
  );
}

class HomeObject {
  HomeData data;

  HomeObject(
    this.data,
  );
}
