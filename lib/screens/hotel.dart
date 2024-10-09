import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/food_lists.dart';

class HotelRestaurantListScreen extends StatefulWidget {
  const HotelRestaurantListScreen({super.key});

  @override
  _HotelRestaurantListScreenState createState() => _HotelRestaurantListScreenState();
}

class _HotelRestaurantListScreenState extends State<HotelRestaurantListScreen> {
  // List of all restaurants
  final List<Restaurant> allRestaurants = [
    Restaurant(
      name: "The Food Palace",
      rating: 4.5,
      numOfRatings: 120,
      arrivalTime: "30-40 min",
      foodTypes: "Indian, Chinese",
      isVeg: true,
      location: "Main Street, Food City",
      imageUrl: "assets/images/food_palace.jpg",
      isFavorite: false,
    ),
    Restaurant(
      name: "Spice Corner",
      rating: 4.0,
      numOfRatings: 95,
      arrivalTime: "20-30 min",
      foodTypes: "Thai, Continental",
      isVeg: false,
      location: "Highway Road, Spice Town",
      imageUrl: "assets/images/food_palace.jpg",
      isFavorite: false,
    ),
    // Add more restaurants here
  ];

  // Filter and sort options
  bool showFavoritesOnly = false;
  bool showVegOnly = false;
  String selectedSort = 'Rating'; // Default sort option

  // Apply filters to the list of restaurants
  List<Restaurant> get filteredRestaurants {
    List<Restaurant> filtered = allRestaurants;

    if (showFavoritesOnly) {
      filtered = filtered.where((restaurant) => restaurant.isFavorite).toList();
    }
    if (showVegOnly) {
      filtered = filtered.where((restaurant) => restaurant.isVeg).toList();
    }

    // Sort based on selected sort option
    if (selectedSort == 'Rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (selectedSort == 'Arrival Time') {
      filtered.sort((a, b) {
        int aTime = int.parse(a.arrivalTime.split('-')[0].trim());
        int bTime = int.parse(b.arrivalTime.split('-')[0].trim());
        return aTime.compareTo(bTime);
      });
    }

    return filtered;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Hotels & Restaurants"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Restaurant List
          Expanded(
            child: ListView.builder(
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: filteredRestaurants[index],
                  onFavoriteToggle: () {
                    setState(() {}); // Refresh the widget to update the favorite count
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the sort bottom sheet
  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sort By",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text("Rating"),
                trailing: selectedSort == 'Rating'
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    selectedSort = 'Rating';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Arrival Time"),
                trailing: selectedSort == 'Arrival Time'
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    selectedSort = 'Arrival Time';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Veg Only"),
                trailing: showVegOnly
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    showVegOnly = !showVegOnly;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Favorites Only"),
                trailing: showFavoritesOnly
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    showFavoritesOnly = !showFavoritesOnly;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class Restaurant {
  final String name;
  final double rating;
  final int numOfRatings;
  final String arrivalTime;
  final String foodTypes;
  final bool isVeg;
  final String location;
  final String imageUrl;
  bool isFavorite;

  Restaurant({
    required this.name,
    required this.rating,
    required this.numOfRatings,
    required this.arrivalTime,
    required this.foodTypes,
    required this.isVeg,
    required this.location,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onFavoriteToggle; // Callback to notify favorite toggle

  const RestaurantCard({super.key, required this.restaurant, required this.onFavoriteToggle});

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FoodLists()),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                widget.restaurant.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Name and Favorite Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.restaurant.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.restaurant.isFavorite
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.restaurant.isFavorite = !widget.restaurant.isFavorite;
                        });
                        widget.onFavoriteToggle(); // Notify the parent to update the favorites count
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Rating and Number of Reviews
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      widget.restaurant.rating.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "(${widget.restaurant.numOfRatings} ratings)",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Arrival Time and Food Types
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 20, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(widget.restaurant.arrivalTime),
                    const SizedBox(width: 20),
                    const Icon(Icons.restaurant_menu,
                        size: 20, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(widget.restaurant.foodTypes),
                  ],
                ),
                const SizedBox(height: 10),

                // Veg or Non-Veg Indicator
                Row(
                  children: [
                    Icon(
                      widget.restaurant.isVeg ? Icons.circle : Icons.circle,
                      color:
                          widget.restaurant.isVeg ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(widget.restaurant.isVeg ? "Veg" : "Non-Veg"),
                  ],
                ),
                const SizedBox(height: 10),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(widget.restaurant.location),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
