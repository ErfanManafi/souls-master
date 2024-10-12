import 'package:get/get.dart';
import 'package:souls_master/bindings/bindings.dart';
import 'package:souls_master/constants/my_strings.dart';
import 'package:souls_master/view/article_list_screen.dart';
import 'package:souls_master/view/article_single_screen.dart';
import 'package:souls_master/view/category_screen.dart';
import 'package:souls_master/view/location_list_screen.dart';
import 'package:souls_master/view/location_screen.dart';
import 'package:souls_master/view/main_screen.dart';
import 'package:souls_master/view/poster_screen.dart';
import 'package:souls_master/view/sources_screen.dart';
import '../routes/named_route.dart';
import '../view/splash_screen.dart';

class Pages {
  List<GetPage> getPages() {
    return [
      GetPage(
        name: NamedRoute.initialRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: NamedRoute.articleSinglePage,
        page: () => const ArticleSinglePage(),
      ),
      GetPage(
        name: NamedRoute.locationScreen,
        page: () => const LocationScreen(),
      ),
      GetPage(
        name: NamedRoute.mainScreen,
        page: () => const MainScreen(),
        binding: MainScreenBinding(),
      ),
      GetPage(
        name: NamedRoute.articleListScreen,
        page: () => const ArticleListScreen(title: MyStrings.allBossFights),
      ),
      GetPage(
        name: NamedRoute.locationListScreen,
        page: () =>
            const LocationListScreen(title: MyStrings.allLocationsTitle),
      ),
      GetPage(
        name: NamedRoute.posterScreen,
        page: () => const PosterScreen(),
      ),
      GetPage(
        name: NamedRoute.categoryScreen,
        page: () => const CategoryScreen(),
        binding: MainScreenBinding(),
      ),
      GetPage(
        name: NamedRoute.sourceScreen,
        page: () => const SourcesScreen(),
      ),
    ];
  }
}
