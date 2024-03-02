import 'dart:convert';

import 'package:newsapp/network/model/article.dart';

class NewsListDataResponse {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsListDataResponse({this.status, this.totalResults, this.articles});

  NewsListDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
NewsListDataResponse getNewsList(String response){
  final json = jsonDecode(response);
  return NewsListDataResponse.fromJson(json);
}



