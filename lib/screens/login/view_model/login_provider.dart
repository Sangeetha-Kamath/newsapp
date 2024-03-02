
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/error_constants.dart';
import '../../../network/user.dart';

class LoginProvider with ChangeNotifier{
  TextEditingController loginController = TextEditingController();
  FocusNode  loginFocusNode = FocusNode();
 final GoogleSignIn googleSignIn = GoogleSignIn();
late GoogleSignInAccount? _currentUser;
 UserData userInfo = UserData();

  bool isAuthorized = false; 






  bool get authDetail{
    return isAuthorized;
  }

  set authDetail(bool val){
    isAuthorized = val;
    
  }

  UserData get userDetail{
    return userInfo;
  }

  set userDetail(UserData val){
    userInfo = val;
    
  }


  Future<bool> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      // Successful sign-in, now authenticate with Google and obtain the user credentials
     if( googleSignInAccount.email.isNotEmpty)

     
{  
  _currentUser = googleSignInAccount;
  authDetail = true;
  
   userDetail =    UserData(email: _currentUser?.email??"",
       name: _currentUser?.displayName??"",
       url: _currentUser?.photoUrl??""
       );
      

}   
     
    } else {
      authDetail = false;
      userDetail = UserData();
      Fluttertoast.showToast(msg: ErrorConstants.loginError,
        gravity: ToastGravity.CENTER);
      // User canceled the sign-in
    }
  } catch (error) {
    // Handle the sign-in failure
    log('Error signing in with Google: $error');
  }
  return isAuthorized;
}

}