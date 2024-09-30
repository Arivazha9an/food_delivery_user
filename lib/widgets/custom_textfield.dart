import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  
  
  const CustomTextfield({super.key, required this.label, required this.icon, required this.controller,required this.keyboardType,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
    );
  }
}