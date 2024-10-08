import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:souls_master/constants/dimensions.dart';
import 'package:souls_master/constants/my_color.dart';
import 'package:souls_master/controller/single_article_controller.dart';
import 'package:souls_master/model/article_model.dart';
import 'package:souls_master/model/location_model.dart';
import 'package:html/parser.dart' as html_parser;

AppBar locationSingleAppBar(LocationModel location, TextTheme textTheme) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(61, 255, 255, 255),
          ),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          location.location!,
          style: textTheme.titleMedium,
        ),
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(61, 255, 255, 255),
          ),
          child: GestureDetector(
            onTap: () async {
              // Parse the HTML content to plain text
              final document = html_parser.parse(location.content);
              final String parsedContent = document.body!.text;

              await Share.share(
                'این مقاله رو از دست نده!\n\n$parsedContent',
                subject: 'Dark Souls 1 - ${location.location}',
              );
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

AppBar articleSingleAppBar(ArticleModel article, TextTheme textTheme) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(61, 255, 255, 255),
          ),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Article title (boss name)
        Text(
          article.bossName,
          style: textTheme.titleMedium,
        ),
        // Share button
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(61, 255, 255, 255),
          ),
          child: GestureDetector(
            onTap: () async {
              final document = html_parser.parse(article.info);
              final String parsedContent = document.body!.text;

              await Share.share(
                '\u200Fاین مقاله رو از دست نده!\n\n$parsedContent',
                subject: 'Dark Souls 1 - ${article.bossName}',
              );
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildImageAndTitleSection(ArticleModel article, TextTheme textTheme,
    ArticleSingleController articleSingleController) {
  return Stack(
    alignment: Alignment.bottomCenter,
    clipBehavior: Clip.none,
    children: [
      // Image container
      Container(
        height: Dimensions.articleSinglePosterHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        foregroundDecoration: const BoxDecoration(
          gradient: MyColor.articleSingleBannerGradient,
        ),
        child: CachedNetworkImage(
          imageUrl: article.image,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      // Boss fight title
      Positioned(
        bottom: -20,
        right: 40,
        child: Column(
          children: [
            Text(
              article.type,
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 5.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              textScaler: const TextScaler.linear(1.2),
            ),
            Text(
              article.bossName,
              style: textTheme.labelSmall,
            ),
          ],
        ),
      ),
      // White container with title
      Positioned(
        left: 40,
        bottom: -20,
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.singlePageatitleContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            article.title,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

Widget buildTabsAndContent(ArticleSingleController articleSingleController,
    TextTheme textTheme, ArticleModel article) {
  List<String> titles = ['اطلاعات', 'استراتژی', 'حملات'];
  Color activeColor = Colors.blue.withOpacity(0.2);
  Color inactiveColor = Colors.white.withOpacity(0.2);

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(titles.length, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: InkWell(
                  onTap: () {
                    articleSingleController.selectedIndex.value = index;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          articleSingleController.selectedIndex.value == index
                              ? activeColor
                              : inactiveColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        titles[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Obx(() {
          final selectedIndex = articleSingleController.selectedIndex.value;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: HtmlWidget(
              '<div style="text-align: justify;">${selectedIndex == 0 ? article.info : selectedIndex == 1 ? article.strategy : article.attack}</div>',
              key: ValueKey(selectedIndex),
              enableCaching: true,
              textStyle: textTheme.displaySmall!.copyWith(
                fontSize: 14,
                height: 1.8,
              ),
            ),
          );
        }),
      ),
    ],
  );
}
