import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_delivery_user/screens/cart_screen.dart';

class HomePage extends StatefulWidget {
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

  final List<Map<String, String>> _foodItems = [
    {
      'name': 'Pepperoni Pizza',
      'price': '\$12.99',
      'image': 'assets/images/pizza.jpg'
    },
    {
      'name': 'Cheeseburger',
      'price': '\$10.99',
      'image': 'assets/images/pizza.jpg'
    },
    {
      'name': 'Chicken Sushi',
      'price': '\$8.99',
      'image': 'assets/images/pizza.jpg'
    },
    {
      'name': 'Chocolate Cake',
      'price': '\$5.99',
      'image': 'assets/images/pizza.jpg'
    },
  ];

  
  List<Map<String, String>> _cartItems = [];

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
                  fontWeight: FontWeight.bold,
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
                  fontWeight: FontWeight.bold,
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
    return Container(
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
                  style: const TextStyle(fontSize: 16),
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
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(foodItem['image']!),
              ),
              title: Text(
                foodItem['name']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                foodItem['price']!,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: isAddedToCart ? Colors.red : Colors.grey,
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
          );
        }).toList(),
      ),
    );
  }
}
