import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/string_constant.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:newsapp/screens/home/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<HomeScreenProvider>(context,listen: false);
    return  Padding(
      padding: const EdgeInsets.only(top:12),
      child: TextField(
        controller: searchProvider.searchController,
        style: GoogleFonts.poppins(fontSize: 12,
        fontWeight: FontWeight.w600,
        
        color: AppColors.black),
        onSubmitted: (val){
          searchProvider.reset();
          searchProvider.fetchNews();

        },
        cursorColor: AppColors.black,
        
        decoration:  InputDecoration(prefixIcon:const  Icon(Icons.search),
        
        
        hintText: StringConstants.searchNews,
        hintStyle: GoogleFonts.poppins(fontSize: 12,
        fontWeight: FontWeight.w600,
        
        
        ),
        
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: StringConstants.searchNews,
        labelStyle: GoogleFonts.poppins(fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.black),
        
        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(30),
        
        borderSide: const BorderSide(color:AppColors.black )
      
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
      
        borderSide: const BorderSide(color:AppColors.black )
      
        ),
        ),
      
      ),
    );
  }
}