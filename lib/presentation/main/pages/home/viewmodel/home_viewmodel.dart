import 'dart:async';
import 'dart:ffi';

import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/domain/usecase/get_home_usecase.dart';
import 'package:mvvm_desgin_app/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  StreamController _homeObjectStreamController = BehaviorSubject<HomeObject>();

  HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  //---------------------------------input
  @override
  void start() {
    _callApi();
  }

  _callApi() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold((faliuer) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: faliuer.message));
    }, (homeObject) {
      inputState.add(ContantState());
      inputHomeObject.add(homeObject);
  
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Sink get inputHomeObject =>_homeObjectStreamController.sink;

  @override
  Stream<HomeObject> get outputHomeObject => _homeObjectStreamController.stream.map((homeObject) => homeObject);

  //-----------------------------------------------------------output

}

abstract class HomeViewModelInput {
  Sink get inputHomeObject;
}

abstract class HomeViewModelOutput {
  Stream<HomeObject> get outputHomeObject;
}
