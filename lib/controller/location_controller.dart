import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souls_master/model/location_model.dart';
import 'package:souls_master/services/pb_services.dart';

class LocationController extends GetxController {
  var locations = <LocationModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      isLoading(true);
      var fetchedRecords = await PocketBaseService().fetchLocation();
      if (fetchedRecords.isNotEmpty) {
        locations.assignAll(fetchedRecords);
        debugPrint('Locations fetched');
      } else {
        debugPrint('list location is empty : ${locations.length}');
      }
    } finally {
      isLoading(false);
    }
  }
}
