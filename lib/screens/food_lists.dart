import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/food_detailpage.dart';

class FoodItem {
  final String name;
  final double price;
  final double rating;
  final bool isVeg;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.isVeg,
    required this.imageUrl,
  });
}

class FoodLists extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodLists> {
  List<FoodItem> foodItems = [
    FoodItem(
      name: 'Paneer Butter Masala',
      price: 250,
      rating: 4.5,
      isVeg: true,
      imageUrl: 'assets/images/pizza.jpg',
    ),
    FoodItem(
      name: 'Chicken Biryani',
      price: 300,
      rating: 4.8,
      isVeg: false,
      imageUrl: 'assets/images/pizza.jpg',
    ),
    FoodItem(
      name: 'Dal Makhani',
      price: 180,
      rating: 4.0,
      isVeg: true,
      imageUrl: 'assets/images/pizza.jpg',
    ),
    FoodItem(
      name: 'Mutton Curry',
      price: 350,
      rating: 4.9,
      isVeg: false,
      imageUrl: 'assets/images/pizza.jpg',
    ),
  ];

  bool isVegFilter = false;
  bool isNonVegFilter = false;
  double minRating = 0.0;

  List<FoodItem> get filteredFoodItems {
    return foodItems.where((item) {
      if (isVegFilter && !item.isVeg) return false;
      if (isNonVegFilter && item.isVeg) return false;
      if (item.rating < minRating) return false;
      return true;
    }).toList();
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(20),
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text('Veg'),
                          value: isVegFilter,
                          onChanged: (value) {
                            setModalState(() {
                              isVegFilter = value ?? false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: Text('Non-Veg'),
                          value: isNonVegFilter,
                          onChanged: (value) {
                            setModalState(() {
                              isNonVegFilter = value ?? false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Minimum Rating: ${minRating.toStringAsFixed(1)}'),
                  Slider(
                    value: minRating,
                    min: 0.0,
                    max: 5.0,
                    divisions: 10,
                    label: minRating.toStringAsFixed(1),
                    onChanged: (value) {
                      setModalState(() {
                        minRating = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Button

          Expanded(
            child: ListView.builder(
              itemCount: filteredFoodItems.length,
              itemBuilder: (context, index) {
                final foodItem = filteredFoodItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Food Image
                        GestureDetector(
                          onTap: (){
                             Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>   FoodDetailsPage(foodName: '', price: foodItem.price
                  , isVeg: foodItem.isVeg, rating: foodItem.rating, reviews: [],)
                ),
              );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Image.asset(
                              foodItem.imageUrl,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Veg/Non-Veg Indicator
                              Icon(
                                foodItem.isVeg ? Icons.circle : Icons.circle,
                                color:
                                    foodItem.isVeg ? Colors.green : Colors.red,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              // Food Name & Price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foodItem.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '₹${foodItem.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Rating
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 20),
                                      SizedBox(width: 2),
                                      Text(
                                        '${foodItem.rating}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add to cart functionality
                                    },
                                    child: Text('Add to Cart'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
