import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
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
  double calculateBearing(LatLng start, LatLng end) {
    double startLat = _degreesToRadians(start.latitude);
    double startLng = _degreesToRadians(start.longitude);
    double endLat = _degreesToRadians(end.latitude);
    double endLng = _degreesToRadians(end.longitude);
     

    double dLng = endLng - startLng;

    double y = sin(dLng) * cos(endLat);
    double x =
        cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLng);

    double bearing = atan2(y, x);
    return (bearing * 180 / pi + 360) %
        360; // Convert radians to degrees and normalize
  }

  final String deliveryStatus = 'Your food is on the way!';
  String estimatedTime = '';
  LatLng? deliveryLocation;
  final LatLng restaurantLocation = const LatLng(10.3942, 78.8262);
  final double averageSpeed = 40.0;
  String speed = "Speed: 0.0 m/s";
  late StreamSubscription<Position> positionStream;

  List<LatLng> polylinePoints = [];

  StreamSubscription<Position>? locationStreamSubscription;
 bool routeFetched = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    locationStreamSubscription =
        Geolocator.getPositionStream().listen((position) {
      // Update deliveryLocation on new position updates
      setState(() {
        deliveryLocation = LatLng(position.latitude, position.longitude);

        // Only fetch route if it hasn't been fetched yet
        if (!routeFetched) {
          getRouteFromAPI();
        }
      });
    });
  }

  @override
  void dispose() {
    locationStreamSubscription
        ?.cancel(); // Cancel stream subscription on dispose
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Location services are disabled.');
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('Location permissions are denied.');
        }
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
      // Minimum distance (in meters) that the device must move before the listener is notified
    ).listen((Position position) {
      // Update speed in m/s
      setState(() {
        speed =
            "Speed: ${position.speed} m/s"; // speed is provided in meters/second
      });
    });

    setState(() {
      deliveryLocation = LatLng(position.latitude, position.longitude);
      getRouteFromAPI();
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
        return LatLng(coord[1], coord[0]); // Swap latitude and longitude
      }).toList();

      setState(() {
        polylinePoints = points;
        estimatedTime = calculateEstimatedTime();
        routeFetched = true; // Mark route as fetched
      });
    } else {
      if (kDebugMode) {
        print('Failed to load route');
      }
    }
  }

  String calculateEstimatedTime() {
    final distance = calculateDistance(restaurantLocation, deliveryLocation!);
    final hours = distance / averageSpeed;
    final minutes = (hours * 60).round();
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
                keepAlive: true,
                backgroundColor: primaryLight),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: deliveryLocation!,
                    child: polylinePoints.length > 1
                        ? Transform.rotate(
                            angle: calculateBearing(
                                    deliveryLocation!, polylinePoints[1]) *
                                pi /
                                131, // Convert degrees to radians
                            child: SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: lottie.Lottie.asset(
                                'assets/animations/map.json', // Your Lottie animation path
                                repeat: true,
                                reverse: true,
                                animate: true,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: lottie.Lottie.asset(
                              'assets/animations/map.json', // Default animation if no route is available
                              repeat: true,
                              reverse: true,
                              animate: true,
                            ),
                          ),
                  ),
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: restaurantLocation,
                    child: const Icon(
                      Icons.person_pin_circle_rounded,
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
