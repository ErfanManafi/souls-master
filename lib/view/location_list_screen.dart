import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:souls_master/constants/my_strings.dart';
import 'package:souls_master/constants/scaffold_bg.dart';
import 'package:souls_master/controller/location_controller.dart';
import 'package:souls_master/routes/named_route.dart';

class LocationListScreen extends StatelessWidget {
  final String title;

  const LocationListScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.find();
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: GradientBackground(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      MyStrings.allLocationsTitle,
                      style: textTheme.titleMedium!.copyWith(fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(61, 255, 255, 255),
                        ),
                        child: const Icon(CupertinoIcons.forward),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Obx(() {
            if (locationController.isLoading.value) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 30,
                ),
              );
            } else if (locationController.locations.isEmpty) {
              return const Center(
                child: Text('مقالات در دسترس نیست'),
              );
            } else {
              return ListView.builder(
                itemCount: locationController.locations.length,
                itemBuilder: (context, index) {
                  final location = locationController.locations[index];

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(NamedRoute.locationScreen,
                              parameters: {'id': location.id!});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 20.0),
                          child: SizedBox(
                            height: Get.height / 7, // Adjusted height
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CachedNetworkImage container
                                SizedBox(
                                  height: Get.height / 7,
                                  width: Get.width / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: location.image!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SpinKitFadingCircle(
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                // Expanded column for text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        location.location!,
                                        style:
                                            textTheme.headlineLarge!.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            locationController
                                                .locations[index].type!,
                                            style: textTheme.headlineLarge!
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.place,
                                            size: 16,
                                            color: Color.fromARGB(
                                                255, 192, 192, 192),
                                          ),
                                          const SizedBox(width: 30),
                                          Text(
                                            locationController
                                                .locations[index].title!,
                                            style: textTheme.headlineLarge!
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Custom divider with gradient, but skip it for the last item
                      if (index != locationController.locations.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.grey,
                                  Colors.transparent,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
