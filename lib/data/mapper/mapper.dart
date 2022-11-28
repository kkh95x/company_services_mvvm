import 'package:mvvm_desgin_app/app/constants.dart';
import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/app/extension.dart';
import '../responses/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id.orEmpty() ?? Constant.empty,
        name: this?.name.orEmpty() ?? Constant.empty,
        numOfNotification: this?.numOfNotification.orZer() ?? Constant.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        phone: this?.phone ?? Constant.empty,
        email: this?.email ?? Constant.empty,
        link: this?.link ?? Constant.empty);
  }
}

extension ForgetPasswordExtension on ForgetPasswordResponse {
  ForgetPassword toDomain() {
    return ForgetPassword(support?.orEmpty() ?? Constant.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      contacts: this?.contacts.toDomain(),
      customer: this?.customer.toDomain(),
    );
  }
}

extension ServicesResponseMapper on ServicesResponse? {
  Services toDomain() {
    return Services(
      this?.id ?? Constant.empty,
      this?.title ?? Constant.empty,
      this?.image ?? Constant.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id ?? Constant.empty,
      this?.title ?? Constant.empty,
      this?.image ?? Constant.empty,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id ?? Constant.empty,
      this?.title ?? Constant.empty,
      this?.image ?? Constant.empty,
      this?.link ?? Constant.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Services> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            Iterable.empty())
        .cast<Services>()
        .toList();
     List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersResponse) => bannersResponse.toDomain()) ??
            Iterable.empty())
        .cast<BannerAd>()
        .toList();
            List<Store> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            Iterable.empty())
        .cast<Store>()
        .toList();

    HomeData data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}
