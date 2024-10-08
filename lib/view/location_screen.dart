import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:souls_master/components/single_page_widgets.dart';
import 'package:souls_master/constants/dimensions.dart';
import 'package:souls_master/constants/my_color.dart';
import 'package:souls_master/constants/scaffold_bg.dart';
import 'package:souls_master/controller/location_controller.dart';
import 'package:souls_master/model/location_model.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController locationController =
        Get.find<LocationController>();

    final textTheme = Theme.of(context).textTheme;

    // Retrieve the location id from Get parameters
    final String? locationId = Get.parameters['id'];

    if (locationId == null) {
      return const Scaffold(
        body: Center(
          child: Text('No location found'),
        ),
      );
    } else {
      return _buildLocationPage(
          locationId, locationController, textTheme, context);
    }
  }

  Widget _buildLocationPage(
      String locationId,
      LocationController locationController,
      TextTheme textTheme,
      BuildContext context) {
    // Fetch the specific location by ID
    final LocationModel? location = locationController.locations
        .firstWhereOrNull((location) => location.id == locationId);

    if (location == null) {
      return const Scaffold(
        body: Center(
          child: Text('مقاله پیدا نشد'),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: locationSingleAppBar(location, textTheme),
      body: GradientBackground(
        child: Obx(() {
          if (locationController.isLoading.value) {
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
                          gradient: MyColor.articleSingleBannerGradient,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: location.image!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // Boss fight title
                      Positioned(
                        bottom: -20,
                        right: 40,
                        child: Column(
                          children: [
                            Text(
                              location.type!,
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
                              location.location!,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(
                            location.title!,
                            style: textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Display HTML content statically
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 60),
                    child: HtmlWidget(
                      '<div style="text-align: justify;">${location.content}</div>',
                      enableCaching: true,
                      textStyle: textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                        height: 1.8,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
