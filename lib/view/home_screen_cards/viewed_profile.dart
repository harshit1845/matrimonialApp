import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewedByScreen extends StatelessWidget {
  const ViewedByScreen({super.key});

  final List<Map<String, String>> viewers = const [
    {
      'name': 'Krati Sharma',
      'age': '23',
      'location': 'Jaipur, India',
      'image': 'asset/girl1.png',
      'viewedAt': '2 hours ago',
    },
    {
      'name': 'Aisha Khan',
      'age': '25',
      'location': 'Mumbai, India',
      'image': 'asset/girl2.png',
      'viewedAt': 'Yesterday',
    },
    {
      'name': 'Sneha Patel',
      'age': '26',
      'location': 'Ahmedabad, India',
      'image': 'asset/girl3.png',
      'viewedAt': '3 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FB),
      appBar: AppBar(
        title: Text(
          'Viewed By',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: viewers.length,
        itemBuilder: (context, index) {
          final viewer = viewers[index];
          return _buildViewerCard(viewer);
        },
      ),
    );
  }

  Widget _buildViewerCard(Map<String, String> viewer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(viewer['image']!),
        ),
        title: Text(
          '${viewer['name']}, ${viewer['age']}',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewer['location']!,
              style: GoogleFonts.poppins(
                  fontSize: 13, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.remove_red_eye_outlined,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  viewer['viewedAt']!,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.pink),
          onPressed: () {},
        ),
      ),
    );
  }
}
