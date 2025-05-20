import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'subscriptionpage.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final List<Map<String, dynamic>> matches = [
    {
      'name': 'G. Srivalli',
      'lastSeen': '2 m ago',
      'age': 22,
      'height': '5 \'0”',
      'degree': 'B‑tech',
      'city': 'Hyderabad',
      'job': 'Software Engg.',
      'image': 'asset/girl2.png',
      'interests': ['Badminton', 'Festivals', 'Cafe‑hopping'],
      'isLiked': false,
    },
    {
      'name': 'A. Riya',
      'lastSeen': '5 m ago',
      'age': 24,
      'height': '5 \'4”',
      'degree': 'MBA',
      'city': 'Mumbai',
      'job': 'Marketing Mgr',
      'image': 'asset/girl3.png',
      'interests': ['Yoga', 'Travel', 'Music'],
      'isLiked': false,
    },
    {
      'name': 'S. Kavya',
      'lastSeen': 'online',
      'age': 25,
      'height': '5 \'3”',
      'degree': 'M‑tech',
      'city': 'Bangalore',
      'job': 'AI Engineer',
      'image': 'asset/girl5.jpg',
      'interests': ['Gaming', 'Coffee'],
      'isLiked': false,
    },
    {
      'name': 'R. Nisha',
      'lastSeen': 'offline',
      'age': 22,
      'height': '5 \'1”',
      'degree': 'B‑Arch',
      'city': 'Delhi',
      'job': 'Architect',
      'image': 'asset/girl1.png',
      'interests': ['Photography', 'Dance'],
      'isLiked': false,
    },
  ];

  final List<String> _filters = ['Filters', 'Match Preference', 'Basic Details'];
  int _selectedFilter = 0;
  late final PageController _pageCtrl = PageController(viewportFraction: 0.78);

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FB),
      body: Column(
        children: [
          const SizedBox(height: 48),
          _buildSearchBar(),
          const SizedBox(height: 10),
          _buildFilterRow(),
          const SizedBox(height: 12),
          Expanded(
            child: PageView.builder(
              controller: _pageCtrl,
              itemCount: matches.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, i) => _animatedCard(i),
            ),
          ),
          const SizedBox(height: 8),
          SmoothPageIndicator(
            controller: _pageCtrl,
            count: matches.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.blue.shade800,
              dotColor: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }

  Widget _buildSearchBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search by criteria...',
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );

  Widget _buildFilterRow() => SizedBox(
    height: 38,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: _filters.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (_, i) => GestureDetector(
        onTap: () => setState(() => _selectedFilter = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
          decoration: BoxDecoration(
            color: _selectedFilter == i
                ? Colors.blue.shade50
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: _selectedFilter == i
                    ? Colors.blue.shade300
                    : Colors.grey.shade300),
          ),
          child: Text(
            _filters[i],
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: _selectedFilter == i
                  ? Colors.blue.shade800
                  : Colors.black87,
              fontWeight:
              _selectedFilter == i ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );

  Widget _animatedCard(int index) {
    return AnimatedBuilder(
      animation: _pageCtrl,
      builder: (ctx, child) {
        double value = 1.0;
        if (_pageCtrl.position.haveDimensions) {
          value = _pageCtrl.page! - index;
          value = (1 - (value.abs() * .3)).clamp(0.7, 1.0);
        }
        return Transform.scale(scale: value, child: child);
      },
      child: _matchCard(matches[index]),
    );
  }

  Widget _matchCard(Map<String, dynamic> m) {
    final firstName = m['name'].toString().split(' ').first;
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 28),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 8,
        shadowColor: Colors.black26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.asset(
                    m['image'],
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 18,
                  child: InkWell(
                    onTap: () =>
                        setState(() => m['isLiked'] = !(m['isLiked'] as bool)),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 150),
                      scale: m['isLiked'] ? 1.2 : 1.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          m['isLiked']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        color: Colors.black.withOpacity(0.25),
                        child: Text('Last seen ${m['lastSeen']}',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
              child: Text(firstName,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Wrap(
                spacing: 14,
                runSpacing: 6,
                children: [
                  _iconText(Icons.cake_outlined, '${m['age']} yrs'),
                  _iconText(Icons.height, m['height']),
                  _iconText(Icons.school_outlined, m['degree']),
                  _iconText(Icons.location_pin, m['city']),
                  _iconText(Icons.work_outline, m['job']),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: (m['interests'] as List).map<Widget>((e) {
                  return Chip(
                    label: Text(e,
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: Colors.black87)),
                    backgroundColor: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _goPremium,
                      child: const Text('Yes, Interested'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade800,
                        side: BorderSide(color: Colors.grey.shade500),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {},
                      child: const Text('No'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 16, color: Colors.grey.shade700),
      const SizedBox(width: 4),
      Text(text, style: GoogleFonts.poppins(fontSize: 12)),
    ],
  );

  void _goPremium() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SubscriptionPage()));
  }
}
