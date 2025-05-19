import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:matrimonial_app/utils/comanmethods.dart';

import '../routes/routes.dart';

class FinalStepProfilePicScreen extends StatefulWidget {
  @override
  _FinalStepProfilePicScreenState createState() => _FinalStepProfilePicScreenState();
}

class _FinalStepProfilePicScreenState extends State<FinalStepProfilePicScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File?> selectedImages = List.filled(5, null);

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImages[index] = File(image.path);
      });
    }
  }

  void _onContinue() {
    int filledCount = selectedImages.where((file) => file != null).length;
    if (filledCount < 3) {
      // showRegistrationSuccessDialog(context);
      Navigator.pushNamed(context, AppRoutes.basicdetails);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least 3 images')),
      );
    } else {
      // Proceed to registration complete
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Registration Complete!')),
      // );
      // Add your navigation here
    }
  }

  Widget _buildImageCard(int index) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: selectedImages[index] != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(selectedImages[index]!, fit: BoxFit.cover),
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 30, color: Colors.grey),
              SizedBox(height: 8),
              Text('Select Image', style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: 1/ 7,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(Colors.blue.shade800),
                        ),
                      ),
                      Text('1 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Text('Profile Pictures', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(height: 30),
              Text('Upload at least 3 pictures', style: GoogleFonts.poppins(fontSize: 16)),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemBuilder: (context, index) => _buildImageCard(index),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _onContinue,
                  child: Text('Continue', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
