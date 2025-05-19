import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/routes/routes.dart';

class LifestyleDetailsScreen extends StatefulWidget {
  @override
  _LifestyleDetailsScreenState createState() => _LifestyleDetailsScreenState();
}

class _LifestyleDetailsScreenState extends State<LifestyleDetailsScreen> {
  String diet = '';
  String smoking = '';
  String drinking = '';
  String hobbies = '';
  String languages = '';

  List<String> dietOptions = ['Vegetarian', 'Non-Vegetarian', 'Eggetarian', 'Jain'];
  List<String> yesNoOptions = ['Yes', 'No'];

  void _showModernBottomSheet(String title, List<String> options, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) => Column(
            children: [
              Container(
                width: 50,
                height: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.all(16),
                  children: [
                    Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ...options.map((option) => ListTile(
                      title: Text(option, style: GoogleFonts.poppins()),
                      trailing: Icon(Icons.radio_button_off),
                      onTap: () {
                        onSelect(option);
                        Navigator.pop(context);
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetField(String label, String value, List<String> options, Function(String) onSelect) {
    return GestureDetector(
      onTap: () => _showModernBottomSheet(label, options, onSelect),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.isEmpty ? label : value,
                style: GoogleFonts.poppins(fontSize: 16, color: value.isEmpty ? Colors.grey : Colors.black)),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, Function(String) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          value: 6 / 7,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(Colors.blue.shade800),
                        ),
                      ),
                      Text('6 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lifestyle Details', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Next: Partner Preferences', style: GoogleFonts.poppins(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Divider(height: 30),
              _buildBottomSheetField('Diet', diet, dietOptions, (val) => setState(() => diet = val)),
              _buildBottomSheetField('Smoking', smoking, yesNoOptions, (val) => setState(() => smoking = val)),
              _buildBottomSheetField('Drinking', drinking, yesNoOptions, (val) => setState(() => drinking = val)),
              _buildTextField('Hobbies', 'Enter hobbies', (val) => hobbies = val),
              _buildTextField('Languages', 'Enter languages', (val) => languages = val),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.panter_preffrence);
                  },
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
