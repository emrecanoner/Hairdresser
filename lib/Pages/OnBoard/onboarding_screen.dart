import 'package:flutter/material.dart';
import 'package:hairdresser/Constant/custom_sizedbox.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';
import 'package:hairdresser/Constant/style.dart';

import 'package:hairdresser/Pages/Login/login_screen.dart';

import 'package:flutter_svg/flutter_svg.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome!',
      description: 'Easily schedule your hairdressers reservation.',
      image: 'assets/icons/image1.svg',
      backgroundColor: CustomColor.kWhiteColor,
    ),
    OnboardingItem(
      title: 'Find Hairdresser',
      description: 'Discover the hairdressers near you.',
      image: 'assets/icons/image2.svg',
      backgroundColor: CustomColor.kWhiteColor,
    ),
    OnboardingItem(
      title: 'Make a Reservation',
      description: 'Choose a suitable time and make your reservation.',
      image: 'assets/icons/image3.svg',
      backgroundColor: CustomColor.kWhiteColor,
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingItems.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final item = onboardingItems[index];
              return Container(
                color: item.backgroundColor,
                padding: EdgeInsets.symmetric(
                    vertical:
                        MediaQueryHelper.getPieceOfGridHeight(context, 1, 1, 1),
                    horizontal:
                        MediaQueryHelper.getPieceOfGridWidth(context, 1, 1, 1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      item.image,
                      width: MediaQueryHelper.getPieceOfGridWidth(
                          context, 3, 3, 3),
                      height: MediaQueryHelper.getPieceOfGridHeight(
                          context, 2, 2, 2),
                    ),
                    CustomtSizedBox(
                        phoneSize: 1,
                        tabletSize: 1,
                        webSize: 1,
                        isHeight: true),
                    Text(
                      item.title,
                      style: CustomStyle.onBoardTitle,
                    ),
                    CustomtSizedBox(
                        phoneSize: .7,
                        tabletSize: .7,
                        webSize: .7,
                        isHeight: true),
                    Text(
                      item.description,
                      style: CustomStyle.onBoardItem,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: MediaQueryHelper.getPieceOfGridHeight(context, .6, .6, .6),
            left: MediaQueryHelper.getPieceOfGridWidth(context, 1, 1, 1),
            right: MediaQueryHelper.getPieceOfGridWidth(context, 1, 1, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: _currentPage != onboardingItems.length - 1,
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.kBlackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: CustomStyle.onBoardButton,
                    ),
                  ),
                ),
                Visibility(
                  visible: _currentPage == onboardingItems.length - 1,
                  child: ElevatedButton(
                    onPressed: _goToLoginPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.kBlackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: CustomStyle.onBoardButton,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;

  OnboardingItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
          vertical: MediaQueryHelper.getPieceOfGridHeight(context, 7, 7, 7),
          horizontal: MediaQueryHelper.getPieceOfGridWidth(context, 7, 7, 7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.image),
          CustomtSizedBox(
              phoneSize: 1, tabletSize: 1, webSize: 1, isHeight: true),
          Text(
            item.title,
            style: CustomStyle.onBoardTitle,
          ),
          CustomtSizedBox(
              phoneSize: 1, tabletSize: 1, webSize: 1, isHeight: true),
          Text(
            item.description,
            style: CustomStyle.onBoardItem,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
