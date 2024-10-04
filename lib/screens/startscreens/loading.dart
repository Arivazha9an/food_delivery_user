import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:food_delivery_user/screens/startscreens/bottom_nav.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() async {
    while (_progress < 1.0) {
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _progress += 0.02; // Adjust the increment value as needed
      });
    }

    // Navigate to the next screen when loading is complete
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 360, // Adjust the size as needed
              width: 360,
              child: Lottie.asset('assets/animations/loading.json'),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 6, // Adjust the width as needed
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(4),
                    value: _progress,
                    backgroundColor: white,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
