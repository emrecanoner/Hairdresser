import 'package:flutter/material.dart';

class CustomColor {
  static const Color kWhiteColor = Colors.white;
  static const Color kBlackColor = Colors.black;
  static const Color kGreyColor = Colors.grey;
  static const Color transparent = Colors.transparent;
}

class FontSize {
  static const double text1 = 10;
  static const double text1_5 = 12.5;
  static const double text2 = 15;
  static const double text2_5 = 17.5;
  static const double text3 = 25;
  static const double text3_5 = 27.5;
}

class CustomStyle {
  static const TextStyle onBoardTitle = TextStyle(
    fontSize: FontSize.text3_5,
    fontWeight: FontWeight.bold,
    color: CustomColor.kBlackColor,
  );

  static const TextStyle onBoardItem =
      TextStyle(fontSize: FontSize.text1_5, color: CustomColor.kBlackColor);

  static const TextStyle onBoardButton = TextStyle(
    color: CustomColor.kWhiteColor,
    fontSize: FontSize.text2,
  );

  static const TextStyle headerWords = TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);

  static const TextStyle textFormField = TextStyle(color: Colors.grey);

  static const TextStyle blackColor = TextStyle(color: CustomColor.kBlackColor);

  static const TextStyle greyColor = TextStyle(color: CustomColor.kGreyColor);

  static const TextStyle reservationTitle = TextStyle(
      color: CustomColor.kWhiteColor,
      fontSize: FontSize.text2_5,
      fontWeight: FontWeight.bold);

  static const TextStyle reservationHairdresser =
      TextStyle(color: CustomColor.kWhiteColor, fontSize: FontSize.text2);

  static const TextStyle whiteColor = TextStyle(color: CustomColor.kWhiteColor);

  static const TextStyle homeScreenTitle =
      TextStyle(fontSize: FontSize.text2_5, color: CustomColor.kBlackColor);

  static const TextStyle homeScreenItemTitle =
      TextStyle(fontSize: FontSize.text1_5, fontWeight: FontWeight.bold);

  static const TextStyle homeScreenItemSubTitle =
      TextStyle(fontSize: FontSize.text1);

  static const TextStyle snackbarTitle =
      TextStyle(fontSize: FontSize.text2_5, color: CustomColor.kWhiteColor);

  static const TextStyle snackbarMessage =
      TextStyle(fontSize: FontSize.text1_5, color: CustomColor.kWhiteColor);

  static const TextStyle homeScreenWelcome = TextStyle(
      fontSize: FontSize.text3,
      fontWeight: FontWeight.bold,
      color: CustomColor.kBlackColor);
}
