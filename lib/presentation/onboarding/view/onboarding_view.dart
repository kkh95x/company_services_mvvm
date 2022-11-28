// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:mvvm_desgin_app/domain/model/model.dart';
import 'package:mvvm_desgin_app/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:mvvm_desgin_app/presentation/resource/assets_manager.dart';

import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/constants_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/routes_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../resource/string_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final _appPref = instance<AppPreferences>();

  _bind() {
    _appPref.setOnBoardingViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
      stream: _viewModel.outputSilderViewObject,
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: AppSize.s0,
          backgroundColor: ColorManager.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfslides,
            onPageChanged: ((index) {
              _viewModel.onPageChanged(index);
            }),
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderViewObject.slidObject);
            }),

        //bottom controller
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //skip button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: (() {
                      Navigator.pushReplacementNamed(
                          context, Routes.LoginRoute);
                    }),
                    child: Text(
                      style: Theme.of(context).textTheme.titleMedium,
                      AppString.skip,
                      textAlign: TextAlign.end,
                    )),
              ),

              //bootm lef slider right
              Container(
                color: ColorManager.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //move left page
                    Padding(
                      padding: const EdgeInsets.all(AppPading.p14),
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                              _viewModel.goPreviouse(),
                              duration: const Duration(
                                  milliseconds: AppConstants.slidAnimationTime),
                              curve: Curves.bounceInOut);
                        },
                        child: SizedBox(
                          width: AppSize.s22,
                          height: AppSize.s22,
                          child: SvgPicture.asset(ImageAssets.leftArrowIc),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < sliderViewObject.numOfslides; i++)
                          Padding(
                            padding: const EdgeInsets.all(AppPading.p8),
                            child: _getProperCircle(
                                i, sliderViewObject.currentIndex),
                          )
                      ],
                    ),

                    //move right page
                    Padding(
                      padding: const EdgeInsets.all(AppPading.p14),
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(_viewModel.goNext(),
                              duration: const Duration(
                                  milliseconds: AppConstants.slidAnimationTime),
                              curve: Curves.bounceInOut);
                        },
                        child: SizedBox(
                          width: AppSize.s22,
                          height: AppSize.s22,
                          child: SvgPicture.asset(ImageAssets.rightArrowIc),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  _getProperCircle(int index, int courrentIndex) {
    if (index == courrentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCirlceIc);
    } else {
      return SvgPicture.asset(ImageAssets.soildCircleIc);
    }
  }
}

//page of onBoalding
class OnBoardingPage extends StatelessWidget {
  final SlidObject _slidObject;
  const OnBoardingPage(this._slidObject);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPading.p8),
          child: Text(
            _slidObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPading.p8),
          child: Text(
            _slidObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_slidObject.imgeAsset)
      ],
    );
  }
}
