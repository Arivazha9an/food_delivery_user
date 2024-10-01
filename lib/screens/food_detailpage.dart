import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // For the rating bar

class FoodDetailsPage extends StatefulWidget {
  final String foodName;
  final double price;
  final bool isVeg;
  final double rating;
  final List<String> reviews;

  const FoodDetailsPage({
    super.key,
    required this.foodName,
    required this.price,
    required this.isVeg,
    required this.rating,
    required this.reviews,
  });

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int quantity = 1;
  bool isFavorite = false;

  // Function to handle quantity increase
  void increaseQuantity() {
    
    setState(() {
      quantity++;
    });
  }

  // Function to handle quantity decrease
  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Details"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image (Placeholder)
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width/1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/pizza.jpg'), // Placeholder image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Food Name and Veg/Non-Veg Indicator
            Row(
              children: [
                Text(
                  widget.foodName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                // Veg/Non-Veg Indicator
                Icon(
                  Icons.circle,
                  color: widget.isVeg ? Colors.green : Colors.red,
                  size: 16,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Price Display
            Text(
              "₹ ${(widget.price * quantity).toStringAsFixed(2)}", // Display price based on quantity
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Rating Bar
            Row(
              children: [
                RatingBarIndicator(
                  rating: widget.rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 25.0,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.rating.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Quantity Adjuster
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Quantity:", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                // Decrease Quantity Button
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: decreaseQuantity,
                  color: Theme.of(context).primaryColor,
                ),
                // Display Current Quantity
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                // Increase Quantity Button
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: increaseQuantity,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Reviews Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Reviews:",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.reviews.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.person, size: 30, color: Colors.grey),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.reviews[index],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Purchase Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement purchase functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Purchase",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
