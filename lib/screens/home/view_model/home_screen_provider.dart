

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newsapp/constants/api_constants.dart';
import 'package:newsapp/network/model/article.dart';
import 'package:newsapp/network/model/service/api_service.dart';
import 'package:newsapp/network/model/service/sqlite_service.dart';

class HomeScreenProvider extends ChangeNotifier {
  ScrollController sc = ScrollController();
  List<Articles> allNews = [];
  final _sqliteService = SqliteService();
  List<Articles> newsTableData = [];
  int totalResults = 0;
  int page = 1;
  
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  HomeScreenProvider() {
    
    fetchArticleFromTable();
    
    

    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        
          fetchNews();
        
      }
    });
    notifyListeners();
  }


   void reset() {
    
    page=1;
    allNews = [];
    
   
    notifyListeners();
  }

  Future<List<Articles>> fetchArticleFromTable() async {
    
    newsTableData = await _sqliteService.getItems();
   
  

    return newsTableData;
  }

  Future<List<Articles>> fetchNews() async {
    List<Articles> newNews = [];
    

    try {
      final response =
          await ApiService().newsList(ApiCostants.pgeSize, page.toString(), searchController.text);
      totalResults = response.totalResults ?? 0;
     
      newNews = response.articles ?? [];

      allNews.addAll(newNews);
      List<Articles> newsList = allNews;
      for (int i = 0; i < newsList.length; i++) {
        for (int j = 0; j < newsTableData.length; j++) {
          if (newsList[i].title == newsTableData[j].title) {
            newsList[i].isBookMarked = true;
            break;
          }
        }
      }
      
      allNews = newsList;
      notifyListeners();
      page++;
      
    } catch (error) {
      log("Exception: $error");
    }

    return allNews;
  }


    Future<void> onBookMarkTapped(Articles article)async{
      final sqliteService = SqliteService();
      
      article.isBookMarked ?
      await sqliteService.createItem(Articles(author: article.author??"",
        title: article.title??"",description: article.description??"",url: article.url??"",
        urlToImage: article.urlToImage??"",
         publishedAt: article.publishedAt??"",content: article.content??""))
         
         :{
            await sqliteService.deleteItem(article.title??""),
            fetchArticleFromTable()

           
         };
              
         
       
 

    }


}
