import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:food_delivery_user/screens/Auth/registration_screen.dart';
import 'package:food_delivery_user/screens/bottom_nav.dart';
import 'package:food_delivery_user/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Foodie App',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryLight,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: primaryLight,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryLight,
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: primaryDark,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: primaryDark,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryDark,
            ),
          ),
        ),
        themeMode:
            ThemeMode.system, // Automatically switch between light and dark
        home:
            //LoginScreen(),
            CustomBottomNavigationBar());
            // RegistrationScreen()
           // HomePage());
  }
}
