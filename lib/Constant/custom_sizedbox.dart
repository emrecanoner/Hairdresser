import 'package:flutter/material.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';

class CustomtSizedBox extends StatelessWidget {
  final bool isHeight;
  final double phoneSize;
  final double tabletSize;
  final double webSize;
  const CustomtSizedBox({
    required this.phoneSize,
    required this.tabletSize,
    required this.webSize,
    required this.isHeight,
  });

  @override
  Widget build(BuildContext context) {
    return isHeight == true
        ? SizedBox(
            height: MediaQueryHelper.getPieceOfGridHeight(
                context, phoneSize, tabletSize, webSize),
          )
        : SizedBox(
            width: MediaQueryHelper.getPieceOfGridWidth(
                context, phoneSize, tabletSize, webSize),
          );
  }
}
