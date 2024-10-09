import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:food_delivery_user/screens/user_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                    'assets/images/profile_picture.jpg'), // Replace with actual image URL
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const UserProfileScreen(),),);
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'The Weeknd',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    decoration: BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: white,
                        ),
                        Text(
                          ' Madurai , Florida ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          buildMenuItem(Icons.notifications, 'Notifications',(){}),
          buildMenuItem(Icons.payment, 'Payment method',(){}),
          //  buildMenuItem(Icons.card_giftcard, 'Reward credits'),
          //  buildMenuItem(Icons.local_offer, 'My Promo code'),
          // const SizedBox(
          //   height: 40,
          // ),
          buildMenuItem(Icons.settings, 'Settings',(){}),
          buildMenuItem(Icons.group_add, 'Invite Friends',(){}),
          buildMenuItem(Icons.help_outline, 'Help center',(){}),
          buildMenuItem(Icons.info_outline, 'About us',(){}),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title,VoidCallback ontap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap:ontap,
    );
  }
}
