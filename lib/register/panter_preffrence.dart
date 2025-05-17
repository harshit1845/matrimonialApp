import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/routes/routes.dart';
import 'package:matrimonial_app/utils/comanmethods.dart';

class PartnerPreferenceScreen extends StatefulWidget {
  @override
  _PartnerPreferenceScreenState createState() => _PartnerPreferenceScreenState();
}

class _PartnerPreferenceScreenState extends State<PartnerPreferenceScreen> {
  RangeValues _ageRange = RangeValues(25, 35);
  RangeValues _heightRange = RangeValues(150, 180);

  String caste = '';
  String education = '';
  String occupation = '';
  String preferredLocation = '';
  String manglik = '';
  String maritalStatus = '';

  List<String> educationOptions = ['School', 'High School', 'Bachelors', 'Masters', 'Other'];
  List<String> yesNoOptions = ['Yes', 'No'];
  List<String> maritalOptions = ['Single', 'Divorced', 'Widowed'];

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

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
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
                          value: 7 / 7,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      ),
                      Text('7 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Partner Preferences', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Final Step', style: GoogleFonts.poppins(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Divider(height: 30),
              Text('Preferred Age (${_ageRange.start.round()} - ${_ageRange.end.round()} yrs)',
                  style: GoogleFonts.poppins(fontSize: 16)),
              RangeSlider(
                values: _ageRange,
                min: 18,
                max: 60,
                divisions: 42,
                activeColor: Colors.blue,
                labels: RangeLabels('${_ageRange.start.round()}', '${_ageRange.end.round()}'),
                onChanged: (values) => setState(() => _ageRange = values),
              ),
              SizedBox(height: 10),
              Text('Preferred Height (${_heightRange.start.round()} cm - ${_heightRange.end.round()} cm)',
                  style: GoogleFonts.poppins(fontSize: 16)),
              RangeSlider(
                values: _heightRange,
                min: 140,
                max: 200,
                divisions: 60,
                activeColor: Colors.blue,
                labels: RangeLabels('${_heightRange.start.round()}', '${_heightRange.end.round()}'),
                onChanged: (values) => setState(() => _heightRange = values),
              ),
              _buildTextField('Caste', (val) => caste = val),
              _buildBottomSheetField('Education', education, educationOptions, (val) => setState(() => education = val)),
              _buildTextField('Occupation', (val) => occupation = val),
              _buildTextField('Preferred Location', (val) => preferredLocation = val),
              _buildBottomSheetField('Manglik', manglik, yesNoOptions, (val) => setState(() => manglik = val)),
              _buildBottomSheetField('Marital Status', maritalStatus, maritalOptions, (val) => setState(() => maritalStatus = val)),
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
                    showRegistrationSuccessDialog(context);
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
