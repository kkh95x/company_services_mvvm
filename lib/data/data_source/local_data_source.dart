import 'package:analyzer/dart/element/type.dart';
import 'package:mvvm_desgin_app/data/network/error_handler.dart';

import '../responses/responses.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeInCache(HomeResponse homeResponse);
  void clear();
  void clearByKey(String key);
}

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CURRET_TIME_CHASHE = 60000;

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CashItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHome() async {
    CashItem? cashItem = cacheMap[CACHE_HOME_KEY];

    if (cashItem != null && cashItem.isVaildTime(CURRET_TIME_CHASHE)) {
      return cashItem.data;
    } else {
      throw ErrorHandler.handel(ResponseCode.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeInCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CashItem(homeResponse);
  }

  @override
  void clear() {
    cacheMap.clear();
  }

  @override
  void clearByKey(String key) {
    cacheMap.remove(key);
  }
}

class CashItem {
  dynamic data;
  int cachTime = DateTime.now().millisecondsSinceEpoch;
  CashItem(this.data);
}

extension CasheItemExtension on CashItem? {
  bool isVaildTime(int correntTme) {
    if (this == null)
      return false;
    else {
      int dateNow = DateTime.now().millisecondsSinceEpoch;
      bool isvalid = dateNow - this!.cachTime < correntTme;
      return isvalid;
    }
  }
}
