import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:souls_master/components/home_widgets.dart';
import 'package:souls_master/components/single_page_widgets.dart';
import 'package:souls_master/constants/scaffold_bg.dart';
import 'package:souls_master/controller/single_article_controller.dart';
import 'package:souls_master/model/article_model.dart';

class ArticleSinglePage extends StatelessWidget {
  const ArticleSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArticleSingleController articleSingleController =
        Get.find<ArticleSingleController>();

    final textTheme = Theme.of(context).textTheme;

    // Retrieve the article id from Get parameters
    final String? articleId = Get.parameters['id'];

    if (articleId == null) {
      return const Scaffold(
        body: Center(
          child: Text('مقاله ای یافت نشد'),
        ),
      );
    } else {
      return _buildArticlePage(
          articleId, articleSingleController, textTheme, context);
    }
  }

  Widget _buildArticlePage(
      String articleId,
      ArticleSingleController articleSingleController,
      TextTheme textTheme,
      BuildContext context) {
    // Fetch the specific article by ID
    final ArticleModel? article = articleSingleController.articles
        .firstWhereOrNull((article) => article.id == articleId);

    if (article == null) {
      return const Scaffold(
        body: Center(
          child: Text('مقاله پیدا نشد'),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: articleSingleAppBar(article, textTheme),
      body: GradientBackground(
        child: Obx(() {
          if (articleSingleController.isLoading.value) {
            return const SpinKitFadingCircle(
              color: Colors.white,
              size: 40,
            ); // Show loading indicator
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Build the image and title section
                  buildImageAndTitleSection(
                      article, textTheme, articleSingleController),

                  // Build tabs and content
                  buildTabsAndContent(
                      articleSingleController, textTheme, article),

                  const Divider(
                    color: Color.fromARGB(183, 255, 255, 255),
                    indent: 40,
                    endIndent: 40,
                    thickness: 2,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 20),
                    child: Text('مقالات مرتبط', style: textTheme.titleMedium),
                  ),

                  // Related articles section
                  buildHorizontalArticleList(
                    textTheme,
                    isFirstList: false,
                    addRightMargin: true,
                    limit: 6,
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
