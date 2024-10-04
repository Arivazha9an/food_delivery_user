import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';

class ProfileScreen extends StatelessWidget {

  
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                color: errorColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 62.5,
                  backgroundColor: primaryLight,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/profile_picture.jpg'),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: IconButton(
                //     icon: Icon(Icons.camera_alt,
                //         color: Theme.of(context).primaryColor),
                //     onPressed: () {},
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            buildProfileField("Username", "John Doe", Icons.person, context),
            buildProfileField(
                "Email", "john.doe@example.com", Icons.email, context),
            buildProfileField(
                "Phone Number", "+123 456 7890", Icons.phone, context),
            buildProfileField("Delivery Address", "123 Main St, Food City",
                Icons.location_on, context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(
      String title, String value, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
