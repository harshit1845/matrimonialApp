import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final String userImage;

  ChatScreen({required this.userName, required this.userImage});

  final List<Map<String, dynamic>> messages = [
    {'text': 'Hi, how are you?', 'isMe': false, 'time': '10:30 AM'},
    {'text': 'I’m good! How about you?', 'isMe': true, 'time': '10:31 AM'},
    {'text': 'All good here!', 'isMe': false, 'time': '10:32 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(userImage)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                Text('Online', style: GoogleFonts.poppins(color: Colors.green, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: message['isMe'] ? Colors.blue.shade800 : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: message['isMe'] ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message['time'],
                            style: GoogleFonts.poppins(fontSize: 10, color: message['isMe'] ? Colors.white70 : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, offset: Offset(0, -2))],
            ),
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.emoji_emotions_outlined, color: Colors.blue.shade800), onPressed: () {}),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.send, color: Colors.blue.shade800), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
