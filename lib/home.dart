import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/apis/ApiService.dart';
import 'package:matrimonial_app/view/chats/chatlist.dart';
import 'package:matrimonial_app/view/chats/chats.dart';
import 'package:matrimonial_app/view/matchs/matchs.dart';
import 'package:matrimonial_app/view/profile.dart';

import 'home_screen.dart';
import 'model/UserProfile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('Home')),
    Center(child: Text('Matches')),
    Center(child: Text('Profile')),
  ];

  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    // fetchUserProfile();
  }


  // Future<void> fetchUserProfile() async {
  //   try {
  //     // Replace with your API call
  //     final response = await ApiService.get(Uri.parse('YOUR_API_ENDPOINT'));
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       setState(() {
  //         userProfile = UserProfile.fromJson(jsonData);
  //         isLoading = false;
  //       });
  //     } else {
  //       // Handle error
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     // Handle exception
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  final List<Widget> _pages = [
    HomeContent(),
    MatchesScreen(),
    // ChatListScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allow content to show under nav bar
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Matches'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

}
//
// class HomeContent extends StatelessWidget {
//   final List<Map<String, String>> recommendedProfiles = [
//     {'name': 'Riya', 'age': '25', 'city': 'Mumbai', 'image': 'asset/girl2.png'},
//     {'name': 'Ananya', 'age': '24', 'city': 'Delhi', 'image': 'asset/girl3.png'},
//     {'name': 'Pooja', 'age': '26', 'city': 'Bangalore', 'image': 'asset/girl4.jpg'},
//     {'name': 'Sneha', 'age': '27', 'city': 'Hyderabad', 'image': 'asset/girl5.jpg'},
//     {'name': 'Kavya', 'age': '23', 'city': 'Pune', 'image': 'asset/girl6.jpg'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F4F7),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 28,
//                     backgroundImage: AssetImage('asset/boy3.jpg'),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Welcome,', style: GoogleFonts.poppins(fontSize: 16)),
//                         Text('Vishal', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                   Badge(
//                     label: Text('2'),
//                     child: Icon(Icons.notifications_none, size: 30),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Search Bar
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search by criteria',
//                   prefixIcon: const Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Profile Completion Card
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     const CircleAvatar(
//                       radius: 25,
//                       backgroundImage: AssetImage('asset/boy3.jpg'),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Complete your profile for better matches!',
//                               style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//                           const SizedBox(height: 8),
//                           LinearProgressIndicator(value: 0.4, backgroundColor: Colors.grey[300], color: Colors.blue),
//                           const SizedBox(height: 6),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text('Complete Now'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Statistics Cards
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 1.6,
//                 children: [
//                   _buildStatCard(Icons.remove_red_eye, 'Viewed You', '5', Colors.pink),
//                   _buildStatCard(Icons.send, 'Sent Request', '5', Colors.teal),
//                   _buildStatCard(Icons.inbox, 'Received Request', '5', Colors.deepPurple),
//                   _buildStatCard(Icons.check_circle, 'Request Accepted', '5', Colors.green),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Recommended Matches
//               Text('Recommended Matches',
//                   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 250,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return _buildRecommendedCard(recommendedProfiles[index]);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatCard(IconData icon, String label, String count, Color color) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4)),
//         ],
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 30, color: Colors.white),
//             const SizedBox(height: 8),
//             Text(count, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
//             const SizedBox(height: 4),
//             Text(label, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecommendedCard(Map<String, String> profile) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.asset(
//               profile['image']!,
//               height: double.infinity,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 8,
//             left: 8,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (profile['interest'] != null)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.star, size: 12, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           profile['interest']!,
//                           style: GoogleFonts.poppins(fontSize: 10, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Text(
//                       '${profile['name']}, ${profile['age']}',
//                       style: GoogleFonts.poppins(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     Icon(Icons.verified, color: Colors.blue, size: 14),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//          const Positioned(
//             top: 8,
//             right: 8,
//             child: Icon(Icons.favorite_border, color: Colors.pink, size: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
