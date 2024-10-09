import 'package:flutter/material.dart';
import 'package:food_delivery_user/constants/colors.dart';
import 'package:food_delivery_user/screens/Auth/otpverify.dart';

class OTPSendScreen extends StatefulWidget {
  const OTPSendScreen({super.key});

  @override
  _OTPSendScreenState createState() => _OTPSendScreenState();
}

class _OTPSendScreenState extends State<OTPSendScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendOTP() async {
    String phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      _showSnackbar("Please enter your phone number.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Logic to send OTP (e.g., Firebase phone auth)
    // ...

    setState(() {
      _isLoading = false;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryLight, primaryDark],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Food Delivery Logo or Illustration
                Image.asset(
                  'assets/images/food_login.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Verify Your Number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We will send you a One-Time Password (OTP)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 30),
                _buildPhoneNumberField(),
                const SizedBox(height: 20),
                _buildSendOtpButton(),
                if (_isLoading) const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: "Enter your phone number",
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        prefixIcon: const Icon(Icons.phone, color: Colors.white),
      ),
    );
  }

  Widget _buildSendOtpButton() {
    return Container(
      height: 45,
      width: 180,
      child: ElevatedButton(
        onPressed: () {
          _sendOTP();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OTPVerifyScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          backgroundColor: Colors.white.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: const Text(
          "Send OTP",
          style: TextStyle(color: Colors.deepOrange, fontSize: 18),
        ),
      ),
    );
  }
}
