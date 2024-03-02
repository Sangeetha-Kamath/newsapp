import 'package:dio/dio.dart';

import 'package:newsapp/constants/api_constants.dart';
import 'package:newsapp/network/model/news_list_data_response.dart';

class ApiService{
  Future<NewsListDataResponse> newsList(String pageSize, String pageNumber, String searchKey)async{
    Dio dio = Dio();
    
    var response = await dio.get(ApiCostants.baseUrl+ApiCostants.getNewsList,
    queryParameters: {
      "apiKey":ApiCostants.apiKey,
      "sources":ApiCostants.bbcNews,
      "pageSize":pageSize,
      "page":pageNumber,
      "q":searchKey
          }
    );
    return getNewsList(response.toString());
  }


}