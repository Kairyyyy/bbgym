import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCoachPage extends StatefulWidget {
  const AddCoachPage({super.key});

  @override
  _AddCoachPageState createState() => _AddCoachPageState();
}

class _AddCoachPageState extends State<AddCoachPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Coach',
          style: GoogleFonts.lateef(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color(0xff000157),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/hoops.png', // Replace with your image asset path
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff000b1e), // Set the background color of the scaffold
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _image != null
                    ? CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(_image!),
                )
                    : const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffc4dbff),
                  child: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: GoogleFonts.robotoCondensed(
                    color: Colors.black54, // Set hint text color
                    fontSize: 16, // Set hint text size
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Set content padding
                  isCollapsed: true, // Ensure that height is controlled by contentPadding
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _yearsController,
                decoration: InputDecoration(
                  hintText: 'Years of Coaching', // Placeholder text
                  hintStyle: GoogleFonts.robotoCondensed(
                    color: Colors.black54, // Set hint text color
                    fontSize: 16, // Set hint text size
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Set content padding
                  isCollapsed: true, // Ensure that height is controlled by contentPadding
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addCoach(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 0), // Set button width to full
                  backgroundColor: Colors.blue[900], // Set button background color
                ),
                child: Text(
                  'Add Coach',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addCoach(BuildContext context) {
    final String name = _nameController.text;
    final String years = _yearsController.text;

    // Check if required fields are not empty
    if (name.isNotEmpty && years.isNotEmpty && _image != null) {
      // Pass the new coach's details back to the previous page
      Navigator.of(context).pop({
        'name': name,
        'years': years,
        'image': _image,
      });
    } else {
      // Show a snackbar or alert for validation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all fields and select an image'),
        ),
      );
    }
  }
}
