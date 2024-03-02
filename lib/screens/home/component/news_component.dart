
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/network/model/article.dart';
import 'package:newsapp/res/app_colors.dart';
import 'package:newsapp/screens/home/view_model/home_screen_provider.dart';
import 'package:newsapp/screens/main_screen/view_model/tab_provider.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  
  final Articles articles;
  final Function onTapped;
 
  const NewsWidget({super.key,
 
  required this.articles,
  required this.onTapped, 
 });

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var tabProvider = Provider.of<TabProvider>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.only(top:12),
      child: Container(
        height:100,
        width:double.infinity,
        decoration: BoxDecoration(
          color:AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black.withOpacity(0.5)),
          
          boxShadow: <BoxShadow> [
            BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
          ]
        ),
        child: Consumer<HomeScreenProvider>(
          builder: (context,provider,child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Flexible(
                      child: Text(
                     
                        widget.articles.title??"",
                      maxLines: 2,
                      softWrap: true,
                       style:GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.black,
                        
                         
                        
                       )),
                    ),
            
                    tabProvider.selectedIndex!=1?
                         InkWell(
                          onTap: (){
                          setState(() {
                            widget.articles.isBookMarked=! widget.articles.isBookMarked;
                            
                            widget.onTapped( widget.articles)
                            
                            ;
                          });
                             
                           
                          },
                          child: widget.articles.isBookMarked?
                         const  Icon(
                            
                         Icons.bookmark):const Icon(
                                        
                            Icons.bookmark_border_outlined),
                        ):const SizedBox.shrink()
                     
                  
                  ],
                ),
                Padding(
                  padding:const   EdgeInsets.only(top:12),
                  child: Text( 
                    widget.articles.description??"",
                        maxLines: 2,
                        softWrap: true,
                         style:GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.black,
                          
                           
                          
                         )),
                ),
               
              ]),
            );
          }
        ),

      ),
    );
  }
}