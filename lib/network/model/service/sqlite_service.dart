

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newsapp/network/model/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService{
  Future<Database> initializeDB()async{
    String path = await getDatabasesPath();
    return openDatabase(join(path,'newsDataBase.db'),
    version: 2,
    onCreate: (db, version) async{
      await db.execute("CREATE TABLE Article(author TEXT ,title TEXT NOT NULL,description TEXT NOT NULL,url TEXT NOT NULL,urlToImage TEXT NOT NULL, publishedAt TEXT NOT NULL,content TEXT NOT NULL)");
    },);
   
    
  }


  






  Future<int> createItem(Articles article) async{
    
   
    final Database db = await initializeDB();
    final result = await db.insert('Article', article.toJson(),
    conflictAlgorithm:ConflictAlgorithm.replace);
   
    return result;
  }

  Future<List<Articles>> getItems()async{
  final  db = await SqliteService().initializeDB();
  final List<Map<String, dynamic>> items =  await db.query('Article');
  List<Articles> articles =  items.map((e)=>Articles.fromJson(e)).toList();
  log("Article:$articles");
  return articles;


}

Future<int> deleteItem(String title) async{
  final  db = await SqliteService().initializeDB();
  try{
var result = await db.delete('Article', where: "title= ?",whereArgs: [title]);
log("delete Result:$result");
return result;
  }catch(e){
   debugPrint("Something went wrong");
  }
  
return -1;

}


}

