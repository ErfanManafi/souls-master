import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:souls_master/constants/scaffold_bg.dart';
import 'package:souls_master/controller/poster_controller.dart';
import 'package:souls_master/model/poster_model.dart';
import '../constants/dimensions.dart';
import '../constants/my_color.dart';
import 'package:html/parser.dart' as html_parser;

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PosterController posterController = Get.find<PosterController>();

    var textTheme = Theme.of(context).textTheme;
    final TextEditingController commentControllerInput =
        TextEditingController();

    final posterId = Get.arguments['id']; // Poster ID from arguments

    // Handle the null check for posterId
    return posterId == null
        ? const Scaffold(
            body: Center(
              child: Text('مقاله ای یافت نشد'),
            ),
          )
        : _buildArticlePage(posterId, posterController, textTheme,
            commentControllerInput, context);
  }

  Widget _buildArticlePage(
    String posterId,
    PosterController posterController,
    TextTheme textTheme,
    TextEditingController commentControllerInput,
    BuildContext context,
  ) {
    // Fetch the specific poster by ID
    PosterModel? poster = posterController.poster
        .firstWhereOrNull((poster) => poster.id == posterId);

    return poster == null
        ? const Scaffold(
            body: Center(
              child: Text('مقاله پیدا نشد'),
            ),
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
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
                        final document = html_parser.parse(poster.content);
                        final String parsedContent = document.body!.text;

                        await Share.share(
                          'این مقاله رو از دست نده!\n\n$parsedContent',
                          subject: 'Dark Souls 1 - ${poster.title}',
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
            ),
            body: GradientBackground(
              child: Obx(() {
                return posterController.isLoading.value
                    ? const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 40,
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
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
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    ),
                                    gradient: MyColor.posterScreenGradient,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: poster.imagePath,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: SpinKitFadingCircle(
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                // Poster title centered at the bottom
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                  child: Text(
                                    poster.title,
                                    style: textTheme.titleSmall!.copyWith(
                                      fontSize: 17,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, bottom: 20, top: 30),
                              child: HtmlWidget(
                                '<div style="text-align: justify;">${poster.content}</div>',
                                textStyle: textTheme.displaySmall!.copyWith(
                                  fontSize: 14,
                                  height: 1.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
            ),
          );
  }
}
