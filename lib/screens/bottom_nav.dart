import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/cart_screen.dart';
import 'package:food_delivery_user/screens/homescreen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    HomePage(),
    SearchScreen(),
   
    ProfileScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    final List<Color> _iconColors = [
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
            icon: _buildBottomNavIcon(Icons.home, 0, _iconColors),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.food_bank, 1, _iconColors),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.person, 2, _iconColors),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomNavIcon(Icons.more, 3, _iconColors),
            label: 'More',
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





class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
