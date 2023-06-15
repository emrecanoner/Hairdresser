import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hairdresser/Constant/Style.dart';
import 'package:hairdresser/Constant/constant_appbar.dart';
import 'package:hairdresser/Constant/custom_sizedbox.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';
import 'package:hairdresser/Pages/Home/home_screen.dart';
import 'package:hairdresser/Pages/Login/login_screen.dart';
import 'package:hairdresser/Pages/Profile/edit_profile_screen.dart';
import 'package:hairdresser/Provider/Profile/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    final profileController = ref.watch(profileControllerProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: constantAppBar(context),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
          future: profileController.firebaseService.getCurrentUser(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: CustomColor.kBlackColor,
              ));
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else {
              final currentUserData = snapshot.data?.data();

              final nameSurname = currentUserData?['nameSurname'] ?? '';
              final email = currentUserData?['email'] ?? '';
              final password = currentUserData?['password'] ?? '';

              _nameController.text = nameSurname;
              _emailController.text = email;
              _passwordController.text = password;
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height:
                      MediaQueryHelper.getPieceOfGridHeight(context, 9, 9, 9),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQueryHelper.getPieceOfGridWidth(
                          context, 1.7, 1.7, 1.7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Nice To See You',
                              style: CustomStyle.headerWords),
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
                          phoneSize: .5,
                          tabletSize: .5,
                          webSize: .5,
                          isHeight: true),
                      TextFormField(
                        enabled: false,
                        controller: _nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: MediaQueryHelper.getPieceOfGridHeight(
                                  context, .2, .2, .2),
                              horizontal: MediaQueryHelper.getPieceOfGridWidth(
                                  context, .5, .5, .5)),
                          labelText: "Name-Surname",
                          hintText: nameSurname,
                          hintStyle: CustomStyle.blackColor,
                          labelStyle: CustomStyle.greyColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColor.kGreyColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColor.kGreyColor),
                          ),
                        ),
                      ),
                      CustomtSizedBox(
                          phoneSize: .3,
                          tabletSize: .3,
                          webSize: .3,
                          isHeight: true),
                      TextFormField(
                        enabled: false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: MediaQueryHelper.getPieceOfGridHeight(
                                  context, .2, .2, .2),
                              horizontal: MediaQueryHelper.getPieceOfGridWidth(
                                  context, .5, .5, .5)),
                          labelText: "E-mail",
                          hintText: email,
                          hintStyle: CustomStyle.blackColor,
                          labelStyle: CustomStyle.greyColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColor.kGreyColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColor.kGreyColor),
                          ),
                        ),
                      ),
                      CustomtSizedBox(
                          phoneSize: .3,
                          tabletSize: .3,
                          webSize: .3,
                          isHeight: true),
                      TextFormField(
                        enabled: false,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: MediaQueryHelper.getPieceOfGridHeight(
                                  context, .2, .2, .2),
                              horizontal: MediaQueryHelper.getPieceOfGridWidth(
                                  context, .5, .5, .5)),
                          labelText: "Password",
                          hintText: password,
                          hintStyle: CustomStyle.blackColor,
                          labelStyle: CustomStyle.greyColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColor.kGreyColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColor.kGreyColor),
                          ),
                        ),
                        obscureText: true,
                      ),
                      CustomtSizedBox(
                          phoneSize: .5,
                          tabletSize: .5,
                          webSize: .5,
                          isHeight: true),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          );
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
                        child: Text('Update'),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child:
                            Text('Back to Home', style: CustomStyle.blackColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do you want to go out?",
                              style: CustomStyle.greyColor),
                          TextButton(
                            onPressed: () {
                              profileController.firebaseService
                                  .signOut(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text('Sign Out!',
                                style: CustomStyle.blackColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
