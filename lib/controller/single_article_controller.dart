import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:souls_master/model/article_model.dart';
import 'package:souls_master/services/pb_services.dart';

class ArticleSingleController extends GetxController {
  var selectedIndex = 0.obs;
  var articles = <ArticleModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    isLoading(true); // Start loading
    try {
      var fetchedRecords = await PocketBaseService().fetchArticles();
      if (fetchedRecords.isNotEmpty) {
        articles.assignAll(fetchedRecords);
        debugPrint("Articles fetched: ${articles.length}");
      } else {
        debugPrint("No articles found");
      }
    } catch (e) {
      debugPrint("Error fetching articles: $e");
    } finally {
      isLoading(false);
    }
  }
}
