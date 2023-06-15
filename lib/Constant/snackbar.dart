import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hairdresser/Constant/custom_sizedbox.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';
import 'package:hairdresser/Constant/style.dart';

class SnackBarClass extends StatelessWidget {
  const SnackBarClass({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical:
                MediaQueryHelper.getPieceOfGridHeight(context, .1, .1, .1),
            horizontal:
                MediaQueryHelper.getPieceOfGridWidth(context, .1, .1, .1),
          ),
          height: MediaQueryHelper.getPieceOfGridHeight(context, 2.2, 2.2, 2.2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              CustomSizedBox(
                  phoneSize: 1, tabletSize: 1, webSize: 1, isHeight: false),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UYARI',
                      style: CustomStyle.snackbarTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CustomSizedBox(
                        phoneSize: .5,
                        tabletSize: .5,
                        webSize: .5,
                        isHeight: true),
                    Text(errorMessage, style: CustomStyle.snackbarMessage),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/icons/bubbles.svg",
              // ignore: deprecated_member_use
              color: CustomColor.kWhiteColor,
              height:
                  MediaQueryHelper.getPieceOfGridHeight(context, .6, .6, .6),
              width: MediaQueryHelper.getPieceOfGridWidth(context, .4, .4, .4),
            ),
          ),
        ),
      ],
    );
  }
}
