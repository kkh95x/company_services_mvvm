import 'package:flutter/material.dart';
import 'package:mvvm_desgin_app/app/constants.dart';
import 'package:mvvm_desgin_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState(
      {required this.stateRendererType, String message = AppString.loading});
  @override
  String getMessage() => message ?? AppString.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState({required this.stateRendererType, required this.message});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContantState extends FlowState {
  ContantState();
  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}
class SuccessState extends FlowState {
StateRendererType stateRendererType;
  String message;
  SuccessState(
      {required this.stateRendererType,required this.message});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.poupLoadingState) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                statRenderer: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
        case SuccessState:
        {
           dissmisDialog(context);
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          
        }
      case ErrorState:
        {
          dissmisDialog(context);

          if (getStateRendererType() == StateRendererType.popupErrorState) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                statRenderer: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ContantState:
        {
          dissmisDialog(context);

          return contentScreenWidget;
        }
      case EmptyState:
        {
      

          return StateRenderer(
              statRenderer: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      default:
        {
          dissmisDialog(context);
          return contentScreenWidget;
        }
    }
  }

  dissmisDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              statRenderer: stateRendererType,
              message: message,
              retryActionFunction: () {},
            )));
  }
}
