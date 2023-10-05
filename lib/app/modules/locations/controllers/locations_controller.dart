import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/common/help_function.dart';
import 'package:iwallet/app/models/location_model.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

class LocationsController extends GetxController {
  var current = ExLocation().obs;
  var locations = <ExLocation>[].obs;
  var search = TextEditingController().obs;

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    await determinePosition().then((_) async {
      if (current.value.lat != null && current.value.lng != null) {
        var res = await getLocations(
          keyword: search.value.text,
          lat: current.value.lat,
          lng: current.value.lng,
          type: null,
        );
        if (res.success) {
          locations.assignAll(res.result!);
          return;
        }
        cautionDialog(res.message, title: 'Thông báo');
      }
    });
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var position = await Geolocator.getCurrentPosition();
    current.value = ExLocation(
        lat: position.latitude.toString(), lng: position.longitude.toString());
  }

  Future<Result<List<ExLocation>>> getLocations(
      {String? apiKey,
      String? keyword,
      int? radius,
      String? type,
      String? lat,
      String? lng}) async {
    var url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?keyword=$keyword'
      '&location=$lat%$lng'
      '&radius=1500'
      '&type=$type'
      '&key=${Application.googleApiKey}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Result(result: []);
    }
    return Result(httpMessage: 'Error');
  }
}
