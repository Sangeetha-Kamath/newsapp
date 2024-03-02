import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:newsapp/constants/app_constants.dart';
import 'package:newsapp/network/user.dart';
import 'package:newsapp/preferences_util/preferences_util.dart';
import 'package:newsapp/res/app_colors.dart';

import 'package:newsapp/screens/login/view_model/login_provider.dart';
import 'package:newsapp/screens/main_screen/view_model/tab_provider.dart';
import 'package:newsapp/splash/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home/view_model/home_screen_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesUtil.getInstance();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create:(_)=>LoginProvider()),
     
      ChangeNotifierProvider(create:(_)=>TabProvider()),
    ChangeNotifierProvider(create:(_)=>HomeScreenProvider())

    ],child: const MyApp(),)
    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void initState() {
    
     
    super.initState();
    loadFromPref(context);
    WidgetsBinding.instance.addObserver(this);
  }

  void loadFromPref(BuildContext context){
    var login =Provider.of<LoginProvider>(context,listen: false);
    login.authDetail = PreferencesUtil.getBool(AppConstants.isAuthorized)??false;
    
    login.userDetail = login.authDetail?
    UserData.fromJson(PreferencesUtil.getObject(AppConstants.user)):UserData();

    
  }

void storeInPref(BuildContext context){
    var login =Provider.of<LoginProvider>(context,listen: false);
    PreferencesUtil.setBool(AppConstants.isAuthorized, login.authDetail);
    PreferencesUtil.setObject(AppConstants.user, login.userDetail);

}



   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      storeInPref(context);
    }
    if (state == AppLifecycleState.resumed) {
      loadFromPref(context);
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
  
      MaterialApp(
      
        title: AppConstants.appName,
        builder: (context, child){
          return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)), 
          child: child!);
        },
        theme: ThemeData(
          useMaterial3:true,
          scaffoldBackgroundColor: Colors.white,
         
          colorScheme: ColorScheme.fromSeed(seedColor:  AppColors.primaryColor,),
         
          textTheme: GoogleFonts.poppinsTextTheme(),
          
         
        ),
        
        themeMode: ThemeMode.dark,
      
         
      
        
        home: const  SplashScreen()
      
    );
  }
}

