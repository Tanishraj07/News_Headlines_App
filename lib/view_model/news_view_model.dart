 import 'package:newspaper_app/models/categories_new_model.dart';
import 'package:newspaper_app/models/news_channel_headlines_model.dart';
import 'package:newspaper_app/repository/news_repository.dart';

class NewsViewModel {

  final _rep= NewsRespository();

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(String channelName) async {
    final response = await _rep.fetchNewChannelHeadLinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
 }