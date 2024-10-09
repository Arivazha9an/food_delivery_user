import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
 //   var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        // actions: [
        //   PopupMenuButton<String>(
        //     icon: const Icon(CupertinoIcons.ellipsis_vertical),
        //     onSelected: (value) {
        //       switch (value) {
        //         case 'Edit Profile':
        //           // Implement edit profile action
        //           break;
        //         case 'Settings':
        //           // Implement settings action
        //           break;
        //         case 'Help':
        //           // Implement help action
        //           break;
        //         case 'Logout':
        //           // Implement logout action
        //           break;
        //       }
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return [
        //         const PopupMenuItem<String>(
        //           value: 'Edit Profile',
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text('Edit'),
        //               Icon(
        //                 Icons.edit,
        //                 color: primaryLight,
        //               ),
        //             ],
        //           ),
        //         ),
        //         const PopupMenuItem<String>(
        //           value: 'Settings',
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text('Settings'),
        //               Icon(
        //                 Icons.settings,
        //                 color: lightBlack,
        //               ),
        //             ],
        //           ),
        //         ),
        //         const PopupMenuItem<String>(
        //           value: 'Help',
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text('Help'),
        //               Icon(
        //                 Icons.help,
        //                 color: lightBlack,
        //               ),
        //             ],
        //           ),
        //         ),
        //         const PopupMenuItem<String>(
        //           value: 'Logout',
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text('Log Out'),
        //               Icon(
        //                 Icons.logout,
        //                 color: errorColor,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ];
        //     },
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Stack(
              children: [
                CircleAvatar(
                  radius: 62.5,
                  backgroundColor: Theme.of(context).primaryColor,
                  child:const CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/profile_picture.jpg'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildProfileField("Username", "Weeknd", Icons.person, context),
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
