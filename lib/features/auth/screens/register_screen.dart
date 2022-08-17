import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/features/auth/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;

  void _handleImageFromGallery() async {
    XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  Widget _displayChatImage() {
    return GestureDetector(
      onTap: _handleImageFromGallery,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey[300],
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null ? const Icon(Icons.add_a_photo, size: 50) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _displayChatImage(),
                    const SizedBox(height: 10),
                    NameFormField(textEditingController: _nameController),
                    const SizedBox(height: 10),
                    EmailFormField(textEditingController: _emailController),
                    const SizedBox(height: 10),
                    PasswordFormField(textEditingController: _passwordController),
                    const SizedBox(height: 10),
                    RegisterButton(formKey: _formKey, nameController: _nameController, emailController: _emailController, passwordController: _passwordController, image: _image),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
