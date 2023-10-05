import 'package:flutter/material.dart';
import '../controllers/locations_controller.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({Key? key}) : super(key: key);

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  final controller = LocationsController();
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LocationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
