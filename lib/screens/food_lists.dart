import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/cart_screen.dart';
import 'package:food_delivery_user/screens/food_detailpage.dart';

class FoodLists extends StatefulWidget {
  const FoodLists({super.key});

  @override
  State<FoodLists> createState() => _FoodListsState();
}

class _FoodListsState extends State<FoodLists> {
  final List<Map<String, dynamic>> _foodItems = [
    {
      'name': 'Pepperoni Pizza',
      'price': '400',
      'image': 'assets/images/pizza.jpg',
      'isVeg': 'true',
      'rating': '4.5',
      'reviews': [
        "Great taste and quality!",
        "Loved the spices, will order again!",
        "Portion size could be better."
      ]
    },
    {
      'name': 'Cheeseburger',
      'price': '399',
      'image': 'assets/images/pizza.jpg',
      'isVeg': 'true',
      'rating': '4.4',
      'reviews': [
        "Great taste and quality!",
        "Loved the spices, will order again!",
        "Portion size could be better."
      ]
    },
    {
      'name': 'Chicken Sushi',
      'price': '299',
      'image': 'assets/images/pizza.jpg',
      'isVeg': 'false',
      'rating': '4.0',
      'reviews': [
        "Great taste and quality!",
        "Loved the spices, will order again!",
        "Portion size could be better."
      ]
    },
    {
      'name': 'Chocolate Cake',
      'price': '159',
      'image': 'assets/images/pizza.jpg',
      'isVeg': 'true',
      'rating': '3.8',
      'reviews': [
        "Great taste and quality!",
        "Loved the spices, will order again!",
        "Portion size could be better."
      ]
    },
  ];

  final List<Map<String, dynamic>> _cartItems = [];
  String? _selectedFilter;
  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _foodItems; // Initially display all items
  }

  void _applyFilter(String? filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'Veg') {
        _filteredItems =
            _foodItems.where((item) => item['isVeg'] == 'true').toList();
      } else if (filter == 'Non-Veg') {
        _filteredItems =
            _foodItems.where((item) => item['isVeg'] == 'false').toList();
      } else if (filter == 'Low Price') {
        _filteredItems = _foodItems
          ..sort((a, b) => int.parse(a['price']).compareTo(int.parse(b['price'])));
      } else if (filter == 'High Rating') {
        _filteredItems = _foodItems
          ..sort((a, b) => double.parse(b['rating']).compareTo(double.parse(a['rating'])));
      } else {
        _filteredItems = _foodItems; // Show all items if no filter is selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: _cartItems.isNotEmpty ? Colors.red : Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartItems: _cartItems,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(child: _buildFoodDetails()),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: _selectedFilter == null,
            onSelected: (_) => _applyFilter(null),
          ),
          ChoiceChip(
            label: const Text('Veg'),
            selected: _selectedFilter == 'Veg',
            onSelected: (_) => _applyFilter('Veg'),
          ),
          ChoiceChip(
            label: const Text('Non-Veg'),
            selected: _selectedFilter == 'Non-Veg',
            onSelected: (_) => _applyFilter('Non-Veg'),
          ),
          ChoiceChip(
            label: const Text('Low Price'),
            selected: _selectedFilter == 'Low Price',
            onSelected: (_) => _applyFilter('Low Price'),
          ),
          ChoiceChip(
            label: const Text('High Rating'),
            selected: _selectedFilter == 'High Rating',
            onSelected: (_) => _applyFilter('High Rating'),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _filteredItems.map((foodItem) {
          bool isAddedToCart = _cartItems.contains(foodItem);
          double price = double.parse(foodItem['price']!);
          double rating = double.parse(foodItem['rating']!);
          bool isVeg = foodItem['isVeg']!.toLowerCase() == 'true';
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FoodDetailsPage(
                    foodName: foodItem['name']!,
                    price: price,
                    isVeg: isVeg,
                    rating: rating,
                    reviews: foodItem['reviews']!,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 12),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(foodItem['image']!),
                ),
                title: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: foodItem['isVeg'] == 'true'
                          ? Colors.green
                          : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      foodItem['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${foodItem['price']!}",
                      style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          letterSpacing: 0.2),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text(
                          foodItem['rating']!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 59, 59, 59),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                trailing: IconButton(
                  icon: isAddedToCart
                      ? const Icon(
                          CupertinoIcons.cart_fill,
                          color: Colors.red,
                        )
                      : const Icon(
                          CupertinoIcons.cart_badge_plus,
                          color: Colors.grey,
                        ),
                  onPressed: () {
                    setState(() {
                      if (isAddedToCart) {
                        _cartItems.remove(foodItem);
                      } else {
                        _cartItems.add(foodItem);
                      }
                    });
                  },
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
