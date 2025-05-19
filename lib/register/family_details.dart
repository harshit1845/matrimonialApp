import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/routes/routes.dart';

class FamilyDetailsScreen extends StatefulWidget {
  @override
  _FamilyDetailsScreenState createState() => _FamilyDetailsScreenState();
}

class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  String fatherName = '';
  String fatherOccupation = '';
  String motherName = '';
  String motherOccupation = '';
  String familyType = '';
  String familyStatus = '';
  String familyLocation = '';

  List<String> familyTypes = ['Joint', 'Nuclear'];
  List<String> familyStatuses = ['Middle Class', 'Upper Class', 'Rich'];

  void _showBottomSheet(String title, List<String> options, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) => ListView(
            controller: controller,
            padding: EdgeInsets.all(16),
            children: options
                .map((option) => ListTile(
              title: Text(option, style: GoogleFonts.poppins()),
              onTap: () {
                onSelect(option);
                Navigator.pop(context);
              },
            ))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetField(String label, String value, List<String> options, Function(String) onSelect) {
    return GestureDetector(
      onTap: () => _showBottomSheet(label, options, onSelect),
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
                          value: 0.66,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(Colors.blue.shade800),
                        ),
                      ),
                      Text('5 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Family Details', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Next: Lifestyle Details', style: GoogleFonts.poppins(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Divider(height: 30),
              _buildTextField('Father Name', 'Enter father’s name', (val) => fatherName = val),
              _buildTextField('Father Occupation', 'Enter father’s occupation', (val) => fatherOccupation = val),
              _buildTextField('Mother Name', 'Enter mother’s name', (val) => motherName = val),
              _buildTextField('Mother Occupation', 'Enter mother’s occupation', (val) => motherOccupation = val),
              _buildBottomSheetField('Family Type', familyType, familyTypes, (val) => setState(() => familyType = val)),
              _buildBottomSheetField('Family Status', familyStatus, familyStatuses, (val) => setState(() => familyStatus = val)),
              _buildTextField('Family Location', 'Enter family location', (val) => familyLocation = val),
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
                    Navigator.pushNamed(context, AppRoutes.lifestyle_hobbies);
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
