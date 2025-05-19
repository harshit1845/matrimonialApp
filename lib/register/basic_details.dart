import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_app/routes/routes.dart';

class RegistrationFlow extends StatefulWidget {
  @override
  _RegistrationFlowState createState() => _RegistrationFlowState();
}

class _RegistrationFlowState extends State<RegistrationFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String gender = '';
  String dob = '';
  String maritalStatus = '';
  String bloodGroup = '';
  String complexion = '';
  String bodyType = '';
  String physicalStatus = '';

  void _nextPage() {
    Navigator.pushNamed(context, AppRoutes.religiousDetails);
    // if (_currentPage < 4) {
    //   _pageController.nextPage(
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // }
  }

  void _showBottomSheet(List<String> options, String title, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            ...options.map((option) => ListTile(
              title: Text(option, style: GoogleFonts.poppins()),
              onTap: () {
                onSelected(option);
                Navigator.pop(context);
              },
            )),
          ],
        );
      },
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentPage = index),
          children: [
            _buildBasicDetails(),

          ],
        ),
      ),
    );
  }

  Widget _buildBasicDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(width: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: 0.2,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.blue.shade800),
                    ),
                  ),
                  Text('2 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic Details', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Next Step: Religion Details', style: GoogleFonts.poppins(color: Colors.grey)),
                ],
              ),
            ],
          ),
          Divider(height: 30),
          Text('Please provide your basic details:', style: GoogleFonts.poppins(fontSize: 16)),
          SizedBox(height: 20),

          _buildTextField('Age', 'Enter age'),
          _buildDateField('Date Of Birth', dob, _pickDate),
          _buildTextField('Email ID', 'Enter email'),
          _buildBottomSheetField('Gender', gender, ['Male', 'Female', 'Others'], (val) => gender = val),
          _buildTextField('Time of Birth (optional)', 'HH:MM'),
          _buildTextField('Place of Birth', 'Enter place'),
          _buildBottomSheetField('Marital Status', maritalStatus, ['Single', 'Married', 'Divorced', 'Widowed'], (val) => maritalStatus = val),
          _buildBottomSheetField('Blood Group', bloodGroup, ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], (val) => bloodGroup = val),
          _buildBottomSheetField('Complexion', complexion, ['Fair', 'Dark', 'Wheatish'], (val) => complexion = val),
          _buildBottomSheetField('Body Type', bodyType, ['Slim', 'Athletic', 'Average', 'Heavy'], (val) => bodyType = val),
          _buildBottomSheetField('Physical Status', physicalStatus, ['Normal', 'Physically Challenged'], (val) => physicalStatus = val),
          _buildTextField('Height (cm)', 'Enter height'),
          _buildTextField('Weight (kg)', 'Enter weight'),

          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _nextPage,
              child: Text('Continue', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
  // Widget _buildreligiousDetails(){
  //
  // }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String value, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          SizedBox(height: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(value.isEmpty ? 'Select date' : value, style: GoogleFonts.poppins(color: value.isEmpty ? Colors.grey : Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetField(String label, String value, List<String> options, Function(String) onSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          SizedBox(height: 6),
          GestureDetector(
            onTap: () => _showBottomSheet(options, 'Select $label', (val) => setState(() => onSelected(val))),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(value.isEmpty ? 'Select $label' : value, style: GoogleFonts.poppins(color: value.isEmpty ? Colors.grey : Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
