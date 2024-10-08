import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:souls_master/model/poster_model.dart';
import 'package:souls_master/services/pb_services.dart';

class PosterController extends GetxController {
  var poster = <PosterModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPoster(); // Fetch posters when controller is initialized
  }

  Future<void> fetchPoster() async {
    try {
      isLoading();
      var fetchRecords = await PocketBaseService().fetchPoster();
      if (fetchRecords.isNotEmpty) {
        poster.assignAll(fetchRecords);
        debugPrint('poster fetched: ${poster.length}');
      } else {
        debugPrint('هیچ مقاله ای دریافت نشد: ${poster.length}');
      }
    } finally {
      isLoading(false);
    }
  }
}
