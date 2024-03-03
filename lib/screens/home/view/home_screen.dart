import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:newsapp/screens/detail/view/detail_screen.dart';

import 'package:provider/provider.dart';

import 'package:newsapp/constants/error_constants.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:newsapp/screens/home/component/news_component.dart';
import '../component/search_component.dart';
import '../view_model/home_screen_provider.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
   

   
    
   
    
   
    return
    
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
         
          children: [
           const  SearchWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Consumer<HomeScreenProvider>(
                  builder: (context, provider, _) {
                  return FutureBuilder(
                      future: provider.fetchNews(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                        } else if (snapshot.hasError) {
                          return const Center(child: Text(ErrorConstants.somethingWrong));
                        } else if(snapshot.hasData &&(snapshot.data?.isNotEmpty??false)){
                          return SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: provider.allNews.length,
                              controller: provider.sc,
                               shrinkWrap: true,
                               primary: false,
                               
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailsScreen(
                                      title: provider.allNews[index].title??"",
                                      url: provider.allNews[index].url??"",
                                      imageUrl: provider.allNews[index].urlToImage??"",
                                      content: provider.allNews[index].description??"",
                                    )));
                                  },
                                  child: NewsWidget(
                                  articles: provider.allNews[index],
                                 
                                  onTapped:(article){provider.onBookMarkTapped(article);}),
                                );
                              },
                            ),
                          );
                        }else{
                          return  Align(
                            alignment:Alignment.center,
                            
                            child:Text(ErrorConstants.noData,
                            style:GoogleFonts.poppins(color:AppColors.black,
                            fontWeight:FontWeight.w400,
                            fontSize:20),
                            textAlign:TextAlign.center));
                        }
                      });
                  },
                ),
              ),
            ),
          ],
        ),
      );
   
  }
}