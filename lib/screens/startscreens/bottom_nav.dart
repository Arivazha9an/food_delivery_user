import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/Orders.dart';
import 'package:food_delivery_user/screens/homescreen.dart';
import 'package:food_delivery_user/screens/hotel.dart';
import 'package:food_delivery_user/screens/user_profile.dart';
import 'package:food_delivery_user/widgets/appbar.dart'; 
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const HotelRestaurantListScreen(),
    const OrdersPage(),
       const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    final List<Color> iconColors = [
      primaryColor,
      primaryColor,
      primaryColor,
      primaryColor
    ];

    return Scaffold(
      appBar: _selectedIndex == 0 
          ? const FoodAppBar() 
          : null, 
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.home, 0, iconColors),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.food_bank, 1, iconColors),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.shopping_cart, 2, iconColors),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.person, 3, iconColors),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavIcon(IconData icon, int index, List<Color> colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: _selectedIndex == index ? colors[index] : Colors.grey,
          size: 25,
        ),
        const SizedBox(height: 4),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: _selectedIndex == index ? colors[index] : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
