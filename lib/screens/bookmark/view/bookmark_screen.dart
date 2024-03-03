import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/app_constants.dart';
import 'package:newsapp/network/model/article.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_constants.dart';
import '../../../network/model/service/sqlite_service.dart';
import '../../../res/app_colors.dart';
import '../../home/component/news_component.dart';
import '../../home/view_model/home_screen_provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final sqliteService = SqliteService();

var providerData = Provider.of<HomeScreenProvider>(context, listen: false);

    Future<dynamic> showSheet(int index){
    return showModalBottomSheet(
      backgroundColor: AppColors.primaryColor,
      context: context, builder: (context){
      return InkWell(
        onTap:()async{
       int result=  await  sqliteService.deleteItem(providerData.newsTableData[index].title??"");
       if(result == 1){
        List<Articles> extList = providerData.newsTableData;
        providerData.notifyListeners();

        extList.removeWhere((element)=>element.title == providerData.newsTableData[index].title);
        providerData.newsTableData = extList;
        
        

       }else{
        Fluttertoast.showToast(msg: ErrorConstants.errorDeleteBookmark,
        gravity: ToastGravity.CENTER);

       }

            
            Navigator.of(context).pop();
        },
        child:  SizedBox(
          width:double.infinity,
          height:60,
          child: Center(
            child: Text(AppConstants.removeFromBookmark,style: GoogleFonts.poppins(fontSize:12,
            fontWeight: FontWeight.bold,
            color: AppColors.black
            )),
          ),
        ),
      );

    });
  }



    return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
         
          children: [
           
            Expanded(
             
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Consumer<HomeScreenProvider>(
                  builder: (context, provider, _) {
                  return FutureBuilder(
                      future: provider.fetchArticleFromTable(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                        } else if (snapshot.hasError) {
                          return const Center(child: Text(ErrorConstants.somethingWrong));
                        } else if(snapshot.hasData &&(snapshot.data?.isNotEmpty??false)) {
                          return SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: provider.newsTableData.length,
                              controller: provider.sc,
                              cacheExtent: 50,
                               shrinkWrap: true,
                               primary: false,
                               
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap:(){
                                      showSheet(index );
                                  },
                                  child: NewsWidget(articles: provider.newsTableData[index],
                                  onTapped: (){}, ),
                                );
                              },
                            ),
                          );
                        }
                        else{
                           return Align(
                            alignment:Alignment.center,
                            
                            child:Text(
                              ErrorConstants.noItem,
                            style:GoogleFonts.poppins(color:AppColors.black,
                            fontWeight:FontWeight.bold,
                            fontSize:18),
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

