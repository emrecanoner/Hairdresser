import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hairdresser/Constant/Style.dart';
import 'package:hairdresser/Constant/constant.dart';
import 'package:hairdresser/Constant/constant_appbar.dart';
import 'package:hairdresser/Constant/custom_sizedbox.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';
import 'package:hairdresser/Pages/Profile/profile_screen.dart';
import 'package:hairdresser/Provider/Profile/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: constantAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQueryHelper.getPieceOfGridHeight(context, 9, 9, 9),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQueryHelper.getPieceOfGridWidth(
                    context, 1.7, 1.7, 1.7)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Let's Change", style: CustomStyle.headerWords),
                    CustomtSizedBox(
                        phoneSize: .3,
                        tabletSize: .3,
                        webSize: .3,
                        isHeight: false),
                    SvgPicture.asset(
                      'assets/icons/profile_icon.svg', // SVG ikonunun yolunu belirtin
                      height: MediaQueryHelper.getPieceOfGridHeight(
                          context, .4, .4, .4),
                      width: MediaQueryHelper.getPieceOfGridWidth(
                          context, .7, .7, .7),
                    ),
                  ],
                ),
                CustomtSizedBox(
                    phoneSize: .5, tabletSize: .5, webSize: .5, isHeight: true),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQueryHelper.getPieceOfGridHeight(
                            context, .2, .2, .2),
                        horizontal: MediaQueryHelper.getPieceOfGridWidth(
                            context, .5, .5, .5)),
                    labelText: "Name-Surname",
                    labelStyle: CustomStyle.greyColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.kBlackColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.kGreyColor),
                    ),
                  ),
                ),
                CustomtSizedBox(
                    phoneSize: .3, tabletSize: .3, webSize: .3, isHeight: true),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQueryHelper.getPieceOfGridHeight(
                            context, .2, .2, .2),
                        horizontal: MediaQueryHelper.getPieceOfGridWidth(
                            context, .5, .5, .5)),
                    labelText: "E-mail",
                    labelStyle: CustomStyle.greyColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.kBlackColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.kGreyColor),
                    ),
                  ),
                ),
                CustomtSizedBox(
                    phoneSize: .3, tabletSize: .3, webSize: .3, isHeight: true),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQueryHelper.getPieceOfGridHeight(
                            context, .2, .2, .2),
                        horizontal: MediaQueryHelper.getPieceOfGridWidth(
                            context, .5, .5, .5)),
                    labelText: "Password",
                    labelStyle: CustomStyle.greyColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.kBlackColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColor.kGreyColor),
                    ),
                  ),
                  obscureText: true,
                ),
                CustomtSizedBox(
                    phoneSize: .5, tabletSize: .5, webSize: .5, isHeight: true),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      messenger(context, "Please fill the blanks");
                    } else if (_emailController.text.isEmpty) {
                      messenger(context, "Please fill the blanks");
                    } else if (_passwordController.text.isEmpty) {
                      messenger(context, "Please fill the blanks");
                    } else {
                      final nameSurname = _nameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      profileController.firebaseService
                          .updateUserProfile(
                              email: email,
                              nameSurname: nameSurname,
                              password: password,
                              context)
                          .then((value) => {
                                _nameController.clear(),
                                _emailController.clear(),
                                _passwordController.clear(),
                              });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.kBlackColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQueryHelper.getPieceOfGridHeight(
                            context, .65, .65, .65)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Save'),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                  child: Text('Back to Profile', style: CustomStyle.blackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
