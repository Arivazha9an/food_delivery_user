import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_delivery_user/screens/cart_screen.dart';
import 'package:food_delivery_user/screens/food_detailpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _carouselImages = [
    'assets/images/offer1.jpg',
    'assets/images/offer1.jpg',
    'assets/images/offer1.jpg',
  ];

  final List<Map<String, String>> _categories = [
    {'name': 'Pizza', 'image': 'assets/images/pizza.jpg'},
    {'name': 'Burgers', 'image': 'assets/images/pizza.jpg'},
    {'name': 'Sushi', 'image': 'assets/images/pizza.jpg'},
    {'name': 'Desserts', 'image': 'assets/images/pizza.jpg'},
  ];

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildOffersCarousel(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _buildCategories(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Popular Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _buildFoodDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildOffersCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: _carouselImages.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(_categories[index]['image']!),
                ),
                const SizedBox(height: 10),
                Text(
                  _categories[index]['name']!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: _foodItems.map((foodItem) {
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
                      isVeg: isVeg, // Set to false for non-veg
                      rating: rating,
                      reviews: foodItem['reviews']!),
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
                        Icon(
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
