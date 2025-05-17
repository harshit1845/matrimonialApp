import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _navigateToEditScreen(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      {'title': 'Basic Details', 'icon': Icons.person, 'route': '/register'},
      {'title': 'Basic Details', 'icon': Icons.person, 'route': '/register'},
      {'title': 'Religious & Caste', 'icon': Icons.temple_hindu, 'route': '/religiousDetails'},
      {'title': 'Education & Career', 'icon': Icons.school, 'route': '/education_details'},
      {'title': 'Family Details', 'icon': Icons.family_restroom, 'route': '/family_details'},
      {'title': 'Lifestyle', 'icon': Icons.fitness_center, 'route': '/lifestyle_hobbies'},
      {'title': 'Partner Preferences', 'icon': Icons.favorite, 'route': '/panter_preffrence'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('asset/boy3.jpg'),
            ),
            SizedBox(height: 12),
            Text('Vishal Fatnani, 25', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Vadodara, India', style: GoogleFonts.poppins(color: Colors.grey[600])),
            SizedBox(height: 20),
            ...sections.map((section) => _buildSectionCard(
              context,
              icon: section['icon'] as IconData,
              title: section['title'] as String,
              routeName: section['route'] as String,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required IconData icon, required String title, required String routeName}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Colors.black87),
        ),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.black54),
          onPressed: () => _navigateToEditScreen(context, routeName),
        ),
      ),
    );
  }
}
