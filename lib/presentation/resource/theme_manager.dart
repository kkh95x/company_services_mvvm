import 'package:flutter/material.dart';
import 'package:mvvm_desgin_app/presentation/resource/color_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/font_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/style_manager.dart';
import 'package:mvvm_desgin_app/presentation/resource/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //main colors

      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,

      //card view theme

      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      //appBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white),
      ),

      //button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.lightPrimary),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s17,
            ),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
            )),
      ),

      //text theme
      textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16,),
          headlineLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          headlineMedium:getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s14) ,
          titleSmall: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16) ,
              labelSmall: getBoldStyle(
              color: ColorManager.primary, fontSize: FontSize.s12), 
          bodyMedium:getRegularStyle(color: ColorManager.grey2,fontSize: AppSize.s12) ,
              //skip
          titleMedium: getMediumStyle(color: ColorManager.primary,fontSize: AppSize.s14) ,
          titleLarge: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          bodyLarge: getRegularStyle(color: ColorManager.grey1),
          bodySmall: getRegularStyle(color: ColorManager.grey)),

      //input decoration theme (text from filed)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPading.p8),
        hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
