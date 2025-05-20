import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestedPeopleScreen extends StatelessWidget {
  const InterestedPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> interestedList = [
      {
        'name': 'Anjali Sharma',
        'age': '24',
        'location': 'Delhi, India',
        'image': 'asset/girl2.jpg',
        'status': 'Waiting for reply',
      },
      {
        'name': 'Pooja Patel',
        'age': '25',
        'location': 'Ahmedabad, India',
        'image': 'asset/girl1.jpg',
        'status': 'Accepted',
      },
      {
        'name': 'Nikita Joshi',
        'age': '26',
        'location': 'Pune, India',
        'image': 'asset/girl3.jpg',
        'status': 'Declined',
      },
    ];


    return Scaffold(
      appBar: AppBar(
        title: Text("Interested in You", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: interestedList.length,
        itemBuilder: (context, index) {
          final person = interestedList[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  person['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                '${person['name']}, ${person['age']}',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person['location']!,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    person['status']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: person['status'] == 'Accepted'
                          ? Colors.green
                          : person['status'] == 'Declined'
                          ? Colors.red
                          : Colors.orange,
                    ),
                  ),
                ],
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
              onTap: () {
                // TODO: Navigate to detailed profile view
              },
            ),
          );
        },
      ),
    );
  }
}
