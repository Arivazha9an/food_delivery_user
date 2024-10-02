import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/homescreen.dart';
import 'package:food_delivery_user/screens/hotel.dart';
import 'package:food_delivery_user/screens/user_profile_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    HotelRestaurantListScreen(),
    ProfileScreen(),
    ProfileScreen(),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.food_bank, 1, iconColors),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.shopping_cart, 2, iconColors),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.person, 3, iconColors),
            label: 'Profile',
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
        ),
        const SizedBox(height: 4),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: _selectedIndex == index ? colors[index] : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
