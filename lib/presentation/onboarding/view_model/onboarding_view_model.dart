import 'dart:async';

import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/presentation/base/base_view_model.dart';


import '../../resource/assets_manager.dart';
import '../../resource/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoaedingViewModelOutput {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SlidObject> _list;
  int _currentIndex = 0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
   
    int nextIndex = ++_currentIndex;
    if (nextIndex >= _list.length) {
      nextIndex = 0;
    }

    return nextIndex;
  }

  @override
  int goPreviouse() {
    int previousIndex = --_currentIndex;
    if (previousIndex < 0) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSilderViewObject
  Stream<SliderViewObject> get outputSilderViewObject =>
      _streamController.stream.map((event) => event);

  //private function

  List<SlidObject> _getSliderData() => [
        SlidObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
            ImageAssets.onboardingLogo1),
        SlidObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
            ImageAssets.onboardingLogo2),
        SlidObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            ImageAssets.onboardingLogo3),
        SlidObject(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4,
            ImageAssets.onboardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//inputs mean Order that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); //when user clicks on right arrow or swipe left
  int goPreviouse(); //when user clicks on right arrow or swipe right
  void onPageChanged(int index); //get current index page from OnChange func
  Sink get inputSliderViewObject;
}

abstract class OnBoaedingViewModelOutput {
  Stream<SliderViewObject> get outputSilderViewObject;
}
