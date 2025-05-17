import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/routes/routes.dart';

class EducationCareerScreen extends StatefulWidget {
  @override
  _EducationCareerScreenState createState() => _EducationCareerScreenState();
}

class _EducationCareerScreenState extends State<EducationCareerScreen> {
  String qualification = '';
  String specialization = '';
  String occupation = '';
  String jobTitle = '';
  String companyName = '';
  String jobLocation = '';
  String income = '';

  List<String> qualifications = ['School', 'High School', 'Bachelors', 'Masters', 'Other'];
  List<String> incomes = ['1 Lac - 5 Lac', '5 Lac - 10 Lac', '10 Lac - 15 Lac', 'Above 15 Lac'];

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
                          value: 0.6,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      ),
                      Text('4 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Education & Career', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Next: Family Details', style: GoogleFonts.poppins(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Divider(height: 30),
              _buildBottomSheetField('Highest Qualification', qualification, qualifications, (val) => setState(() => qualification = val)),
              _buildTextField('Specialization', 'Enter specialization', (val) => specialization = val),
              _buildTextField('Occupation', 'Enter occupation', (val) => occupation = val),
              _buildTextField('Job Title', 'Enter job title', (val) => jobTitle = val),
              _buildTextField('Company Name', 'Enter company name', (val) => companyName = val),
              _buildTextField('Job Location', 'Enter job location', (val) => jobLocation = val),
              _buildBottomSheetField('Income', income, incomes, (val) => setState(() => income = val)),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.family_details);
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
