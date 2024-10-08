import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:souls_master/model/article_model.dart';
import 'package:souls_master/model/category_model.dart';
import 'package:souls_master/model/location_model.dart';
import 'package:souls_master/model/poster_model.dart';

class PocketBaseService {
  final String baseUrl = 'https://dark-master.pockethost.io/';
  final String articleCollectionName = 'articles';
  final String categoryCollectionName = 'categories';
  final String posterCollectionName = 'poster';
  final String locationCollectionName = 'locations';

  Future<List<ArticleModel>> fetchArticles() async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/collections/$articleCollectionName/records'));

    if (response.statusCode == 200) {
      debugPrint(response
          .body); // Debug: print the raw response to check its structure
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('items')) {
        List<dynamic> items = responseData['items'];
        List<ArticleModel> articles =
            items.map((dynamic item) => ArticleModel.fromJson(item)).toList();
        return articles;
      } else {
        throw Exception('Items key not found in the response');
      }
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/collections/$categoryCollectionName/records'));

    if (response.statusCode == 200) {
      debugPrint(response
          .body); // Debug: print the raw response to check its structure
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('items')) {
        List<dynamic> items = responseData['items'];
        List<CategoryModel> categories =
            items.map((dynamic item) => CategoryModel.fromJson(item)).toList();
        return categories;
      } else {
        throw Exception('Items key not found in the response');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<PosterModel>> fetchPoster() async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/collections/$posterCollectionName/records'));

    if (response.statusCode == 200) {
      debugPrint(response
          .body); // Debug: print the raw response to check its structure
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('items')) {
        List<dynamic> items = responseData['items'];
        List<PosterModel> poster =
            items.map((dynamic item) => PosterModel.fromJson(item)).toList();
        return poster;
      } else {
        throw Exception('Items key not found in the response');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<LocationModel>> fetchLocation() async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/collections/$locationCollectionName/records'));

    if (response.statusCode == 200) {
      debugPrint(response
          .body); // Debug: print the raw response to check its structure
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('items')) {
        List<dynamic> items = responseData['items'];
        List<LocationModel> location =
            items.map((dynamic item) => LocationModel.fromJson(item)).toList();
        return location;
      } else {
        throw Exception('Items key not found in the response');
      }
    } else {
      throw Exception('Failed to load locations');
    }
  }
}
