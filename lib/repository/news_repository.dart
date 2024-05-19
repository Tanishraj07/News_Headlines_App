import 'dart:convert';

import 'package:newspaper_app/models/categories_new_model.dart';
import 'package:newspaper_app/models/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;


class NewsRespository{

  Future<NewsChannelsHeadlinesModel>fetchNewChannelHeadLinesApi(String channelName)async{
    String url ='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=ebf785d827ca4565ac8ed4dc854561a9';
    final response=await http.get(Uri.parse(url));

    if(response.statusCode ==200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModel>fetchCategoriesNewsApi(category)async{
    String url ='https://newsapi.org/v2/top-headlines?q=${category}&apiKey=ebf785d827ca4565ac8ed4dc854561a9';
    final response=await http.get(Uri.parse(url));

    if(response.statusCode ==200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
} Future<CategoriesNewsModel> fetchNewsCategoires(String category) async {
  String newsUrl =
      'https://newsapi.org/v2/everything?q=$category&apiKey=8a5ec37e26f845dcb4c2b78463734448';
  final response = await http.get(Uri.parse(newsUrl));
  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);

    return CategoriesNewsModel.fromJson(body);
  } else {
    throw Exception('Error');
  }
}

Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String newsChannel) async {
  String newsUrl = 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=8a5ec37e26f845dcb4c2b78463734448';
  print(newsUrl);
  final response = await http.get(Uri.parse(newsUrl));
  print(response.statusCode.toString());
  print(response);
  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    return NewsChannelsHeadlinesModel.fromJson(body);
  } else {
    throw Exception('Error');
  }
}
