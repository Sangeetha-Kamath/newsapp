
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/string_constant.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;
  final String url;


  const NewsDetailsScreen({super.key, 
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:  Text(StringConstants.newsDetail,
         style:GoogleFonts.poppins(color: AppColors.black,
                      fontSize: 18,
                      
                      fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                :const  SizedBox.shrink(),

           const SizedBox(height: 16.0),

          
            Text(
              title,
              style: GoogleFonts.poppins(fontSize:24,
              fontWeight:FontWeight.bold)
            ),

           const SizedBox(height: 16.0),

            
            Text(
              content,
              style: GoogleFonts.poppins(fontSize:16),
            ),
              const SizedBox(height: 16.0),
             InkWell(
              onTap: (){
              
                launchUrl(Uri.parse(url));
              },
               child: Text(
                url,
                style: GoogleFonts.poppins(fontSize:18,
                decoration:TextDecoration.underline,
               decorationColor:AppColors.primaryColor,
                color:AppColors.primaryColor,
                fontWeight:FontWeight.bold)
                           ),
             ),
          ],
        ),
      ),
    );
  }
}