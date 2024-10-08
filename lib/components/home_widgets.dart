import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:souls_master/constants/dimensions.dart';
import 'package:souls_master/constants/my_color.dart';
import 'package:souls_master/constants/my_strings.dart';
import 'package:souls_master/controller/category_controller.dart';
import 'package:souls_master/controller/location_controller.dart';
import 'package:souls_master/controller/poster_controller.dart';
import 'package:souls_master/controller/single_article_controller.dart';
import 'package:souls_master/routes/named_route.dart';
import 'package:souls_master/view/main_screen.dart';

Drawer buildDrawer(BuildContext context) {
  final CategoryController categoryController = Get.find<CategoryController>();

  return Drawer(
    backgroundColor: const Color.fromARGB(255, 29, 29, 29),
    child: Obx(() {
      if (categoryController.isLoading.value) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.black,
            size: 30,
          ),
        );
      }

      if (categoryController.categories.isEmpty) {
        return const Center(child: Text("دسته‌بندی‌ها در دسترس نیست."));
      }

      return ListView(
        padding: EdgeInsets.zero, // Remove any padding from the top
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black,
                Color.fromARGB(255, 150, 141, 87),
              ], begin: Alignment.centerRight, end: Alignment.centerLeft),
            ),
            child: Text(
              'Souls Master',
              style: TextStyle(
                fontFamily: 'Dana',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Static menu items
          ListTile(
            leading: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.align_horizontal_left_rounded),
            ),
            title: const Text(
              'همه باس فایت ها',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.offAndToNamed(NamedRoute.articleListScreen);
            },
          ),
          const Divider(
            endIndent: 30,
            indent: 30,
            color: Color.fromARGB(255, 107, 107, 107),
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.location_on_outlined),
            ),
            title: const Text('همه مکان ها',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Get.offAndToNamed(NamedRoute.locationListScreen);
            },
          ),
          const Divider(
              endIndent: 30,
              indent: 30,
              color: Color.fromARGB(255, 107, 107, 107)),

          // Dynamically generated category items with Divider
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              final category = categoryController.categories[index];
              final imagePath = category.imagePath;
              final isSvg = imagePath.endsWith('.svg'); // Check if it's an SVG

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: isSvg
                      ? SvgPicture.network(
                          imagePath,
                          width: 22,
                          height: 22,
                          placeholderBuilder: (context) =>
                              const SpinKitFadingCircle(
                            color: Colors.black,
                            size: 20,
                          ),
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: imagePath,
                          placeholder: (context, url) =>
                              const SpinKitFadingCircle(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                ),
                title: Text(category.category,
                    style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Get.offAndToNamed(NamedRoute.categoryScreen, parameters: {
                    'id': category.id,
                  });
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(
              endIndent: 30,
              indent: 30,
              color: Color.fromARGB(255, 107, 107, 107),
            ),
          ),
        ],
      );
    }),
  );
}

class PosterText extends StatelessWidget {
  final int index; // Add index to the constructor
  const PosterText({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final PosterController posterController = Get.find<PosterController>();
    final posterText =
        posterController.poster[index]; // Access the article based on the index

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            maxLines: 2,
            posterText.title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  posterText.readingTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Dana',
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.lock_clock, color: Colors.white, size: 15),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

AppBar buildAppBar(TextTheme textTheme) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildIconButton(
              icon: Icons.menu,
              onPressed: () {
                globalKey.currentState?.openDrawer();
              },
              backgroundColor: const Color.fromARGB(61, 255, 255, 255),
            ),
            Text(
              'Souls Master',
              style: TextStyle(
                fontSize: 18.0,
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
            ),
            Container(
              height: 38,
              width: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(61, 255, 255, 255),
              ),
              child: GestureDetector(
                onTap: () async {
                  await Share.share(
                    'سولز مستر رو با دوستانتون به اشتراک بزارید!',
                  );
                },
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class BuildCarouselSlider extends StatefulWidget {
  const BuildCarouselSlider({super.key});

  @override
  BuildCarouselSliderState createState() => BuildCarouselSliderState();
}

class BuildCarouselSliderState extends State<BuildCarouselSlider> {
  final PosterController posterController = Get.find<PosterController>();

  @override
  Widget build(BuildContext context) {
    return buildCarouselSlider();
  }

  Widget buildCarouselSlider() {
    return Obx(() {
      if (posterController.poster.isEmpty) {
        return const Center(
          child: SpinKitFadingCircle(
            size: 30,
            color: Colors.white,
          ),
        );
      }

      return CarouselSlider.builder(
        options: CarouselOptions(
          height: Dimensions.carouselSliderHeight,
          aspectRatio: 16 / 9,
          autoPlay: true,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.85,
          enlargeFactor: 0.3,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: posterController.poster.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var poster = posterController.poster[index]; // پوستر جاری

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(NamedRoute.posterScreen, arguments: {
                  'id': poster.id,
                });
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: poster.imagePath,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          gradient: MyColor.mainScreenPosterGradient,
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                        child: SpinKitFadingCircle(
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    left: 15,
                    bottom: 15,
                    child:
                        PosterText(index: index), // انتقال ایندکس به PosterText
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

Widget buildTitleRow(String title, TextTheme textTheme) {
  return Material(
    color: Colors.transparent,
    child: GestureDetector(
      onTap: () {
        if (title == MyStrings.allBossFights) {
          Get.toNamed(NamedRoute.articleListScreen);
        } else {
          Get.toNamed(NamedRoute.locationListScreen);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textTheme.bodyMedium),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildHorizontalArticleList(
  TextTheme textTheme, {
  bool isFirstList = false,
  bool addRightMargin = false,
  int? limit, // Added limit parameter
}) {
  final ArticleSingleController articleSingleController =
      Get.find<ArticleSingleController>();

  return Obx(() {
    if (articleSingleController.isLoading.value) {
      return const Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 30,
        ),
      );
    }

    if (articleSingleController.articles.isEmpty) {
      return const Center(child: Text("مقالات در دسترس نیست"));
    }
    int itemCount =
        limit != null && limit < articleSingleController.articles.length
            ? limit
            : articleSingleController.articles.length;

    return SizedBox(
      height: Dimensions.bossFightsHomePageHorizontalList,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          double marginRight = addRightMargin ? 25.0 : 0.0;
          double lastItemMarginLeft = index == itemCount - 1 ? 25.0 : 0.0;

          return Padding(
            padding:
                EdgeInsets.only(left: lastItemMarginLeft, right: marginRight),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  NamedRoute.articleSinglePage,
                  parameters: {
                    'id': articleSingleController.articles[index].id
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: SizedBox(
                  width: Get.width / 1.9,
                  height: Get.height * 0.25,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: articleSingleController.articles[index].image,
                        placeholder: (context, url) => const Center(
                          child: SpinKitFadingCircle(color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          size: 16,
                        ),
                        fit: BoxFit.cover,
                        width: Get.width / 1.9,
                        height: Get.height * 0.25,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: Get.height * 0.08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 39, 39, 39)
                                .withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 14, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        articleSingleController
                                            .articles[index].type,
                                        style: textTheme.headlineLarge,
                                      ),
                                      Text(
                                        articleSingleController
                                            .articles[index].bossName,
                                        style: textTheme.bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: Get.height * 0.035,
                                    width: Get.width * 0.18,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        articleSingleController
                                            .articles[index].title,
                                        style: textTheme.bodySmall
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  });
}

Widget buildIconButton(
    {required IconData icon,
    required VoidCallback onPressed,
    Color? backgroundColor}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: backgroundColor,
    ),
    child: SizedBox(
      width: 38,
      height: 38,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: Colors.white),
      ),
    ),
  );
}

Widget categoryTransparentList() {
  final CategoryController categoryController = Get.find<CategoryController>();

  return Obx(
    () {
      if (categoryController.isLoading.value) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 30,
          ),
        );
      }

      if (categoryController.categories.isEmpty) {
        return const Center(child: Text("دسته‌بندی‌ها در دسترس نیست."));
      }

      return SizedBox(
        height: Get.height / 20,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            final imagePath = category.imagePath; // PocketBase image path
            final isSvg = imagePath.endsWith('.svg'); // Check if it's an SVG

            return GestureDetector(
              onTap: () {
                Get.toNamed(NamedRoute.categoryScreen, parameters: {
                  'id': category.id,
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == 0 ? 25 : 10,
                  left: index == categoryController.categories.length - 1
                      ? 25
                      : 0,
                ),
                child: IntrinsicWidth(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(61, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: isSvg
                              ? SvgPicture.network(
                                  imagePath,
                                  width: 22,
                                  height: 22,
                                  placeholderBuilder: (context) =>
                                      const SpinKitFadingCircle(
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: imagePath,
                                  placeholder: (context, url) =>
                                      const SpinKitFadingCircle(
                                    color: Colors.black,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            category.category, // Display category name
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget buildHorizontalLocationList(TextTheme textTheme,
    {bool isFirstList = false, bool addRightMargin = false}) {
  final LocationController locationController = Get.find<LocationController>();

  return Obx(() {
    if (locationController.isLoading.value) {
      return const Center(
          child: SpinKitFadingCircle(
        color: Colors.white,
        size: 30,
      ));
    }

    if (locationController.locations.isEmpty) {
      return const Center(child: Text("مقالات در دسترس نیست"));
    }

    return SizedBox(
      height: Dimensions.bossFightsHomePageHorizontalList,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: locationController.locations.length,
        itemBuilder: (context, index) {
          double marginRight = addRightMargin ? 25.0 : 0.0;
          double lastItemMarginLeft =
              index == locationController.locations.length - 1 ? 25.0 : 0.0;

          return Padding(
            padding:
                EdgeInsets.only(left: lastItemMarginLeft, right: marginRight),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  NamedRoute.locationScreen,
                  parameters: {'id': locationController.locations[index].id!},
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: SizedBox(
                  width: Get.width / 1.9,
                  height: Get.height * 0.25,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: locationController.locations[index].image!,
                        placeholder: (context, url) => const Center(
                          child: SpinKitFadingCircle(color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          size: 16,
                        ),
                        fit: BoxFit.cover,
                        width: Get.width / 1.9,
                        height: Get.height * 0.25,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: Get.height * 0.08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 39, 39, 39)
                                .withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 14, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        locationController
                                            .locations[index].type!,
                                        style: textTheme.headlineLarge,
                                      ),
                                      Text(
                                        locationController
                                            .locations[index].location!,
                                        style: textTheme.bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: Get.height * 0.035,
                                    width: Get.width * 0.18,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        locationController
                                            .locations[index].title!,
                                        style: textTheme.bodySmall
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  });
}
