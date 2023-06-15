import 'dart:math';
import 'package:flutter/widgets.dart';

class MediaQueryHelper {
  static double getPieceOfGridWidth(
    BuildContext context,
    double mobilePieceCount,
    double tabletPieceCount,
    double pcPieceCount,
  ) {
    var singlePiece = (MediaQuery.of(context).size.width / 12);
    var inch = Screen.diagonalInches(context);

    // 7 inch e kadar telefon
    // 7- 14 inch e kadar tablet
    //gerisi pc
    if (inch <= 7) {
      return singlePiece * mobilePieceCount;
    } else if (inch < 14) {
      return singlePiece * tabletPieceCount;
    } else {
      return singlePiece * pcPieceCount;
    }
  }

  static double getPieceOfGridHeight(
    BuildContext context,
    double mobilePieceCount,
    double tabletPieceCount,
    double pcPieceCount,
  ) {
    var singlePiece = (MediaQuery.of(context).size.height / 12);
    var inch = Screen.diagonalInches(context);

    // 7 inch e kadar telefon
    // 7- 14 inch e kadar tablet
    //gerisi pc
    if (inch <= 7) {
      return singlePiece * mobilePieceCount;
    } else if (inch < 14) {
      return singlePiece * tabletPieceCount;
    } else {
      return singlePiece * pcPieceCount;
    }
  }
}

class Screen {
  static double get _ppi => 150;
  static bool isLandscape(BuildContext c) =>
      MediaQuery.of(c).orientation == Orientation.landscape;
  //PIXELS
  static Size size(BuildContext c) => MediaQuery.of(c).size;
  static double width(BuildContext c) => size(c).width;
  static double height(BuildContext c) => size(c).height;
  static double diagonal(BuildContext c) {
    Size s = size(c);
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(BuildContext c) {
    Size pxSize = size(c);
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(BuildContext c) => inches(c).width;
  static double heightInches(BuildContext c) => inches(c).height;
  static double diagonalInches(BuildContext c) => diagonal(c) / _ppi;
}
