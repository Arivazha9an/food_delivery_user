import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart' as lottie;

class DeliveryStatusPage extends StatefulWidget {
  const DeliveryStatusPage({super.key});

  @override
  _DeliveryStatusPageState createState() => _DeliveryStatusPageState();
}

class _DeliveryStatusPageState extends State<DeliveryStatusPage> {
  final String deliveryStatus = 'Your food is on the way!';
  String estimatedTime = '';
  LatLng? deliveryLocation;
  final LatLng restaurantLocation = const LatLng(10.3942, 78.8262);
  final double averageSpeed = 40.0;

  List<LatLng> polylinePoints = [];

  StreamSubscription<Position>? locationStreamSubscription;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    locationStreamSubscription = Geolocator.getPositionStream().listen((position) {
      // Update deliveryLocation on new position updates
      setState(() {
        deliveryLocation = LatLng(position.latitude, position.longitude);
        getRouteFromAPI(); // Recalculate route and estimated time
      });
    });
  }

  @override
  void dispose() {
    locationStreamSubscription?.cancel(); // Cancel stream subscription on dispose
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle this
      print('Location services are disabled.');
      return;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        // Permissions are denied, handle this
        print('Location permissions are denied.');
        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Set the current location to the deliveryLocation
    setState(() {
      deliveryLocation = LatLng(position.latitude, position.longitude);
      getRouteFromAPI(); // Fetch the route after getting the current location
    });
  }

  Future<void> getRouteFromAPI() async {
    const apiKey = '5b3ce3597851110001cf6248f264660e862a4d1094b32e755d61ef6e';
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${restaurantLocation.longitude},${restaurantLocation.latitude}&end=${deliveryLocation!.longitude},${deliveryLocation!.latitude}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List coordinates = data['features'][0]['geometry']['coordinates'];

      List<LatLng> points = coordinates.map((coord) {
        return LatLng(coord[1], coord[0]);
      }).toList();

      setState(() {
        polylinePoints = points;
        estimatedTime = calculateEstimatedTime(); // Calculate estimated time
      });
    } else {
      print('Failed to load route');
    }
  }

  //  calculation 4 distance and estimate time
  String calculateEstimatedTime() {
    final distance = calculateDistance(restaurantLocation, deliveryLocation!);
    final hours = distance / averageSpeed; // Time = Distance / Speed
    final minutes = (hours * 60).round(); // Convert to minutes
    return 'Est. Arrival: $minutes mins';
  }

  //  Haversine formula
  double calculateDistance(LatLng start, LatLng end) {
    const R = 6371; // Radius of the Earth in kilometers
    final dLat = _degreesToRadians(end.latitude - start.latitude);
    final dLon = _degreesToRadians(end.longitude - start.longitude);
    final a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2));
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in kilometers
  }

  // Helper method to convert degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793238 / 180.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Status'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: deliveryLocation!,
              initialZoom: 13,
              keepAlive: true),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: deliveryLocation!,
                    child: SizedBox(
        width: 40.0, // Adjust the width and height as needed
        height: 40.0,
        child:lottie.Lottie.asset(
          'assets/animations/map.json', // Your Lottie animation path
          repeat: true,
          reverse: false,
          animate: true,
        ),
      ),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: restaurantLocation,
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              // Polyline Layer (road-following line)
              PolylineLayer(
                polylines: [
                  Polyline(
                      points: polylinePoints,
                      strokeWidth: 4.0,
                      color: primaryLight,
                      pattern: const StrokePattern.solid(),
                      strokeCap: StrokeCap.round)
                ],
              ),
            ],
          ),
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deliveryStatus,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      estimatedTime,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}