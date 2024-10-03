import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:food_delivery_user/screens/Auth/login.dart';
import 'package:food_delivery_user/screens/Auth/registration_screen.dart';
import 'package:food_delivery_user/screens/IntroScreen.dart';

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
            titleMedium: TextStyle(
              color: primaryLight,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            titleSmall: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryLight,
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryLight,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: primaryLight,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: primaryLight,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            titleSmall: TextStyle(
              
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryLight,
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        home:
        RegistrationScreen()
           // LoginScreen(),
           // const CustomBottomNavigationBar()
       //  IntroScreen()
         );
    
    // HomePage());
  }
}