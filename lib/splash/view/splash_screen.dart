import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:newsapp/res/images.dart';
import 'package:newsapp/screens/login/view/login_screen.dart';
import 'package:newsapp/screens/login/view_model/login_provider.dart';
import 'package:newsapp/screens/main_screen/view/main_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginProvider>(context, listen:false);


    Future.delayed(const Duration(seconds: 3), () {
      login.authDetail?
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationWidget(),
        )):


      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    });

    return  Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(Images.newslogo,
            height: 100,
            width:100),
          ),
          Text(AppConstants.newsApp,
          style:GoogleFonts.poppins(
            color: AppColors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold

          ))


        ],
      )
    );
  }
}