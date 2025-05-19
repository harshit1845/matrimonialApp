import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/routes/routes.dart';

class ReligiousCasteDetails extends StatefulWidget {
  @override
  _ReligiousCasteDetailsState createState() => _ReligiousCasteDetailsState();
}

class _ReligiousCasteDetailsState extends State<ReligiousCasteDetails> {
  String religion = '';
  String caste = '';
  String subCaste = '';
  String gotra = '';
  String manglik = '';
  String horoscopeMatch = '';
  String zodiacSign = '';
  Map<String, List<String>> casteMap = {
    'Hindu': ['Brahmin', 'Rajput', 'Vaishya', 'Kshatriya', 'Shudra'],
    'Buddhist': ['Mahayana', 'Theravada', 'Vajrayana'],
    'Other': ['Other Caste 1', 'Other Caste 2']
  };

  List<String> zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
    'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  void _showBottomSheet(List<String> options, String title, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              Divider(),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    children: options.map((option) => ListTile(
                      title: Text(option, style: GoogleFonts.poppins()),
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(context);
                      },
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> getCasteOptions() {
    return casteMap[religion] ?? [];
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
                  Icon(Icons.arrow_back),
                  SizedBox(width: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: 0.4,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation(Colors.blue.shade800),
                        ),
                      ),
                      Text('3 of 7', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Religious & Caste Details', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Next Step: Education Details', style: GoogleFonts.poppins(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              Divider(height: 30),
              _buildBottomSheetField('Religion', religion, ['Hindu', 'Buddhist', 'Other'], (val) {
                setState(() {
                  religion = val;
                  caste = ''; // reset caste when religion changes
                });
              }),
              _buildBottomSheetField('Caste', caste, getCasteOptions(), (val) => caste = val),
              _buildTextField('Sub Caste', 'Enter sub caste', (val) => subCaste = val),
              _buildTextField('Gotra', 'Enter gotra', (val) => gotra = val),
              _buildBottomSheetField('Manglik', manglik, ['Yes', 'No'], (val) => manglik = val),
              _buildBottomSheetField('Horoscope Match Required', horoscopeMatch, ['Yes', 'No'], (val) => horoscopeMatch = val),
              _buildBottomSheetField('Zodiac Sign', zodiacSign, zodiacSigns, (val) => zodiacSign = val),
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
                    Navigator.pushNamed(context, AppRoutes.education_details);
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

  Widget _buildBottomSheetField(String label, String value, List<String> options, Function(String) onSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => _showBottomSheet(options, 'Select $label', (val) => setState(() => onSelected(val))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.poppins(fontSize: 14)),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(value.isEmpty ? 'Select $label' : value,
                  style: GoogleFonts.poppins(color: value.isEmpty ? Colors.grey : Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          SizedBox(height: 6),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
