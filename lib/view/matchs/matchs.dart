import 'package:flutter/material.dart';
import 'package:matrimonial_app/view/matchs/subscriptionpage.dart';

class MatchesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> matches = [
    {
      'name': 'A',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl3.png',
    },

    {
      'name': 'B',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl2.png',
    },
    {
      'name': 'C',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl1.png',
    },
    {
      'name': 'D',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl6.jpg',
    },
    {
      'name': 'E',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl5.jpg',
    },
    {
      'name': 'F',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl1.png',
    },
    {
      'name': 'G',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl2.png',
    },
    {
      'name': 'H',
      'age': 21,
      'height': '150 cm',
      'degree': 'Undergraduate degree',
      'drink': 'No',
      'smoke': 'No',
      'gender': 'Woman',
      'zodiac': 'Leo',
      'religion': 'Hindu',
      'interests': ['Badminton', 'Festivals', 'Cafe-hopping', 'Coffee', 'Foodie'],
      'bondOver': ['Cafe-hopping', 'Coffee', 'Festivals', 'Hindu'],
      'image': 'asset/girl3.png',
    },
    // Add more matches here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 6,
                shadowColor: Colors.black45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          child: Image.asset(
                            match['image'],
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black54],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${match['name']}, ${match['age']}',
                              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sectionHeader(Icons.handshake, 'Things you can bond over'),
                          wrapChips(match['bondOver']),
                          Divider(),
                          sectionHeader(Icons.person, 'About me'),
                          wrapChips([
                            match['height'],
                            match['degree'],
                            match['drink'],
                            match['smoke'],
                            match['gender'],
                            match['zodiac'],
                            match['religion'],
                          ]),
                          Divider(),
                          sectionHeader(Icons.star, 'My interests'),
                          wrapChips(match['interests']),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                onPressed: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SubscriptionPage()),
                                  );

                                },
                                icon: Icon(Icons.cancel),
                                label: Text('Not for me'),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SubscriptionPage()),
                                  );

                                },
                                icon: Icon(Icons.favorite),
                                label: Text('Like'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent, size: 20),
          SizedBox(width: 6),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget wrapChips(List<dynamic> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: items.map<Widget>((item) {
        return Chip(
          label: Text(item),
          backgroundColor: Colors.pink[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }
}
