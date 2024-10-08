import 'package:get/get.dart';
import 'package:souls_master/controller/category_controller.dart';
import 'package:souls_master/controller/location_controller.dart';
import 'package:souls_master/controller/poster_controller.dart';
import 'package:souls_master/controller/single_article_controller.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleSingleController>(() => ArticleSingleController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<PosterController>(() => PosterController());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
