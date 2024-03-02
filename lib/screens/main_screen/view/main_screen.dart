import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/app_constants.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:newsapp/res/images.dart';
import 'package:newsapp/screens/bookmark/view/bookmark_screen.dart';
import 'package:newsapp/screens/home/view/home_screen.dart';
import 'package:newsapp/screens/home/view_model/home_screen_provider.dart';
import 'package:newsapp/screens/login/view_model/login_provider.dart';
import 'package:provider/provider.dart';
import '../view_model/tab_provider.dart';


class NavigationWidget extends StatelessWidget {
    NavigationWidget({super.key});

    final  List<Widget> _screens = <Widget>[
      const HomeScreen(),
      const BookmarkScreen()
      
    ];

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context,listen: false);
    var loginProvider = Provider.of<LoginProvider>(context,listen: false);

    

    
    return  
      Scaffold(
        
        appBar: AppBar(
          
          centerTitle: false,
        
          backgroundColor: AppColors.primaryColor,
          
          automaticallyImplyLeading: false,
          title:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
           
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                
                  child:
                  Image.asset(Images.profile)
                        
                ),
              ),
             const  SizedBox(width:30),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loginProvider.userDetail.name??"",
                    textAlign: TextAlign.start,
                    style:GoogleFonts.poppins(color: AppColors.black,
                    fontSize: 18,
                    
                    fontWeight: FontWeight.bold)
                    
                    ),
                    Text(AppConstants.enjoyFeed,
                                       
                    style: GoogleFonts.poppins(color: AppColors.balckShadow,
                    fontSize:12,
                    
                    fontWeight: FontWeight.w600),
                     maxLines: 2,
                    softWrap: true,)
                  ],
                ),
              )
            ],
          ),
          
        ),
        body: Consumer<TabProvider>(
          builder: (context,provider,child ) {
            return _screens.elementAt(provider.selectedIndex);
          }
        ),
        bottomNavigationBar: Consumer<TabProvider>(
          builder: (context, provider,child) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: AppConstants.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: AppConstants.bookmark,
                ),
              ],
              currentIndex: provider.selectedIndex,
              selectedItemColor:  AppColors.primaryColor,
              onTap: (index){
                provider.selectedIndex = index;
                homeProvider.reset();
                
              },
            );
          }
        ),
      );
    
  }
}