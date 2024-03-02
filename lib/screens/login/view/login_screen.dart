import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:newsapp/screens/login/view_model/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/string_constant.dart';
import '../../../res/images.dart';

import '../../main_screen/view/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   

    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(AppConstants.loginScreen,
        style:GoogleFonts.poppins(color: AppColors.black,
                      fontSize: 20,
                      
                      fontWeight: FontWeight.bold)
      ),
      ),
      body:Consumer<LoginProvider>(
        builder: (context,provider, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                
                  Image.asset(Images.newslogo, height:100,width:100),
                const SizedBox(height:50),
                  
              
                   Padding(
                     padding: const EdgeInsets.only(top:30),
                     child: 

                     ElevatedButton.icon(
  onPressed: () async {
    var isAuthorized = await provider.signInWithGoogle();
    if (isAuthorized) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationWidget(),
        ),
      );
    }
  },
  icon: Image.asset(Images.googleIcon, height:30,width:30,
  alignment: Alignment.centerLeft,),
  label: Text(
    StringConstants.loginWithGoogle,
    style: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
  ),
  style: ElevatedButton.styleFrom(
    fixedSize: const Size(300, 50),
    backgroundColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.circular(30),
    ),
  ),
)
        //              ElevatedButton(
        //                          onPressed: ()async{
        //                          var isAuthorized =  await provider.signInWithGoogle();
        //                          isAuthorized? Navigator.of(context).pushReplacement(
        // MaterialPageRoute(
        //   builder: (BuildContext context) => NavigationWidget(),
        // )):null;
        //                          },
                                 
        //                          style: ElevatedButton.styleFrom(
        //                           fixedSize: const Size(100,200),
        //                            backgroundColor: AppColors.primaryColor,
        //                            shape:  RoundedRectangleBorder(side:  const BorderSide(color: AppColors.black),
        //                            borderRadius: BorderRadius.circular(12))
        //                          ),
        //                          child:  Text(StringConstants.loginWithGoogle,
        //                          style:GoogleFonts.poppins(fontSize: 18,
        //                                  fontWeight: FontWeight.bold,
        //                                  color: AppColors.black),),),
                   ),
              ],
                        ),
            ),);
        }
      )
      );
             
  }
}