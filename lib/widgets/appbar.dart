import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/user_profile_screen.dart';

class FoodAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green[600], // Set your preferred color
      title: const Text(
        'Food Delivery',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(
                
                  ),
                ),
              );

          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
                radius: 15,
                backgroundImage:
                    AssetImage('assets/images/profile_picture.jpg')),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10.0), // Space below the app bar
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 320,
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for food...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Adjust height as needed
}
