import 'package:flutter/material.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';

AppBar constantAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight:
        MediaQueryHelper.getPieceOfGridHeight(context, 2.6, 2.6, 2.6),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Image.asset('assets/images/barber.png'),
  );
}
