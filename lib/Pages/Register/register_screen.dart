import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hairdresser/Constant/Style.dart';
import 'package:hairdresser/Constant/constant_appbar.dart';
import 'package:hairdresser/Constant/custom_sizedbox.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';
import 'package:hairdresser/Pages/Login/login_screen.dart';
import 'package:hairdresser/Provider/Register/register_provider.dart';

class RegisterScreen extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Meet",
                      style: CustomStyle.headerWords,
                    ),
                    CustomtSizedBox(
                        phoneSize: .3,
                        tabletSize: .3,
                        webSize: .3,
                        isHeight: false),
                    SvgPicture.asset(
                      'assets/icons/register_icon.svg',
                      height: MediaQueryHelper.getPieceOfGridHeight(
                          context, .5, .5, .5),
                      width: MediaQueryHelper.getPieceOfGridWidth(
                          context, .7, .7, .7),
                    ),
                  ],
                ),
                CustomtSizedBox(
                    phoneSize: .5, tabletSize: .5, webSize: .5, isHeight: true),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQueryHelper.getPieceOfGridHeight(
                            context, .2, .2, .2),
                        horizontal: MediaQueryHelper.getPieceOfGridWidth(
                            context, .5, .5, .5)),
                    labelText: 'Name-Surname',
                    labelStyle: CustomStyle.textFormField,
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
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQueryHelper.getPieceOfGridHeight(
                            context, .2, .2, .2),
                        horizontal: MediaQueryHelper.getPieceOfGridWidth(
                            context, .5, .5, .5)),
                    labelText: 'E-mail',
                    labelStyle: CustomStyle.textFormField,
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
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQueryHelper.getPieceOfGridHeight(
                            context, .2, .2, .2),
                        horizontal: MediaQueryHelper.getPieceOfGridWidth(
                            context, .5, .5, .5)),
                    labelText: 'Password',
                    labelStyle: CustomStyle.textFormField,
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
                    final registerController =
                        ref.read(registerControllerProvider);
                    final email = emailController.text;
                    final password = passwordController.text;
                    final name = nameController.text;
                    registerController.registerWithEmailAndPassword(
                        email, password, name, context);
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
                  child: Text('Register'),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Do you have an account?',
                      style: CustomStyle.textFormField,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Sign In!', style: CustomStyle.blackColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
