import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souls_master/model/category_model.dart';
import 'package:souls_master/services/pb_services.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      var fetchedRecords = await PocketBaseService().fetchCategories();
      if (fetchedRecords.isNotEmpty) {
        categories.assignAll(fetchedRecords);
        debugPrint('Categories fetched');
      } else {
        debugPrint('list categories is empty : ${categories.length}');
      }
    } finally {
      isLoading(false);
    }
  }
}
