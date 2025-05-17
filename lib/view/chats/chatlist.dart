import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chats.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chatUsers = [
    {'name': 'Riya', 'message': 'Hey! How are you?', 'time': '10:30 AM', 'image': 'asset/girl2.png'},
    {'name': 'Anjali', 'message': 'Let’s meet tomorrow 😊', 'time': '9:20 AM', 'image': 'asset/girl3.png'},
    {'name': 'Pooja', 'message': 'Good night 🌙', 'time': 'Yesterday', 'image': 'asset/girl4.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text('Chats', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: chatUsers.length,
        separatorBuilder: (_, __) => Divider(height: 20, color: Colors.transparent),
        itemBuilder: (context, index) {
          final user = chatUsers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen(userName: user['name']!, userImage: user['image']!)),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: Offset(0, 4))],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(user['image']!),
                    radius: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['name']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                        SizedBox(height: 4),
                        Text(
                          user['message']!,
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(user['time']!, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Text('1', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
