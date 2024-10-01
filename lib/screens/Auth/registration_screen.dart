import 'package:flutter/material.dart';
import 'package:food_delivery_user/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isPasswordVisible = false;
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildProfilePicture(context),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: _usernameController,
                label: "Username",
                icon: Icons.person, keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
               CustomTextfield(
                controller: _emailController,
                label: "Email",
                icon: Icons.person, keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: _phoneController,
                label: "Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
               CustomTextfield(
                controller: _addressController,
                label: "Delivery Address",
                icon: Icons.location_on,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _registerUser();
                  },
                  child: const Text("Register"),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(fontSize: 16), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildProfilePicture(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            backgroundImage:
                _profileImage != null ? FileImage(_profileImage!) : null,
            child: _profileImage == null
                ? Icon(Icons.add_a_photo, size: 50, color: Theme.of(context).primaryColor)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Tap to add profile picture",
          style: TextStyle(color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  
 

  
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
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


  void _registerUser() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;

    if (username.isEmpty || password.isEmpty || phone.isEmpty || address.isEmpty) {
   
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
    } else if (_profileImage == null) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add a profile picture")),
      );
    } else {
      
      print("User registered: $username, $phone, $address");
    }
  }
}

