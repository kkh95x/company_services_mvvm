// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:mvvm_desgin_app/presentation/resource/assets_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/font_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/style_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';

enum StateRendererType {
  //POPUP STATE (DIALOG)
  poupLoadingState,
  popupErrorState,
  popupSuccessState,

  //FULL SCREEN STATE
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //general
  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType statRenderer;
  String message;
  String title;
  Function retryActionFunction;
  StateRenderer({
    required this.statRenderer,
    this.message = AppString.loading,
    this.title = "",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (statRenderer) {
      case StateRendererType.poupLoadingState:
        return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.ok, context)
        ]);

      //FULL SCREEN STATE
      case StateRendererType.fullScreenLoadingState:
        return _getColumnItems([_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.retryAgin, context)
        ]);
        ;
      case StateRendererType.fullScreenEmptyState:
        return _getColumnItems([_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      //general
      case StateRendererType.contentState:
       case StateRendererType.popupSuccessState:
       return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.success),_getMessage(message),
          _getRetryButton(AppString.ok, context)]);
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> chlidren) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: chlidren,
    );
  }

  Widget _getColumnItems(List<Widget> chlidren) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: chlidren,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPading.p8),
        child: Text(message,textAlign: TextAlign.center,
            style: getRegularStyle(
                color: ColorManager.black, fontSize: FontSize.s18)),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPading.p18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (statRenderer == StateRendererType.fullScreenErrorState) {
                    retryActionFunction.call();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }
}
