import 'package:newsapp/network/model/source.dart';

class Articles {
  Source? source;
   bool isBookMarked=false;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
 

  Articles(
      {this.source,
      this.isBookMarked = false,
      this.author,
      this.title,
      this.description,
      
      this.url,
      
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
   isBookMarked = json['isBookMarked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    if( data['isBookMarked']!=null) {
      data['isBookMarked'] =isBookMarked;
    }
   
    return data;
  }
}
