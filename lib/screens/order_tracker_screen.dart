import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class DeliveryStatusPage extends StatefulWidget {
  const DeliveryStatusPage({super.key});

  @override
  _DeliveryStatusPageState createState() => _DeliveryStatusPageState();
}

class _DeliveryStatusPageState extends State<DeliveryStatusPage> {
  
  final String deliveryStatus = 'Your food is on the way!';
  String estimatedTime = ''; // Change this to a dynamic value
  final LatLng deliveryLocation = const LatLng(10.287382, 79.200531); 
  final LatLng restaurantLocation = const LatLng(10.3942, 78.8262);
  final double averageSpeed = 40.0; // Average speed in km/h

  List<LatLng> polylinePoints = [];

  @override
  void initState() {
    super.initState();
    getRouteFromAPI();
  }

  Future<void> getRouteFromAPI() async {
    const apiKey = '5b3ce3597851110001cf6248f264660e862a4d1094b32e755d61ef6e';  
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${restaurantLocation.longitude},${restaurantLocation.latitude}&end=${deliveryLocation.longitude},${deliveryLocation.latitude}';

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

  // Method to calculate distance and estimate time
  String calculateEstimatedTime() {
    final distance = calculateDistance(restaurantLocation, deliveryLocation);
    final hours = distance / averageSpeed; // Time = Distance / Speed
    final minutes = (hours * 60).round(); // Convert to minutes
    return 'Est. Arrival: $minutes mins';
  }

  // Method to calculate distance in kilometers using the Haversine formula
  double calculateDistance(LatLng start, LatLng end) {
    const R = 6371; // Radius of the Earth in kilometers
    final dLat = _degreesToRadians(end.latitude - start.latitude);
    final dLon = _degreesToRadians(end.longitude - start.longitude);
    final a = 
      (sin(dLat / 2) * sin(dLat / 2)) +
      (cos(_degreesToRadians(start.latitude)) * cos(_degreesToRadians(end.latitude)) * 
      sin(dLon / 2) * sin(dLon / 2));
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
      body: Column(
        children: [
          
          Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryStatus,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

          const SizedBox(height: 16),

          // Map View
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: deliveryLocation,
                initialZoom: 14.0,
              ),
                children: [
                  TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer (
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: deliveryLocation,
                      child:  const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: restaurantLocation,
                      child:   const Icon(
                        Icons.restaurant,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),

                // Polyline Layer (road-following line)
                PolylineLayer (
                  polylines: [
                    Polyline(
                      points: polylinePoints,
                      strokeWidth: 4.0,
                      color: Colors.green,
                    ),
                  ],
                ),],
            ),
          ),
        ],
      ),
    );
  }
}
