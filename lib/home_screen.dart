import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'apis/ApiService.dart';
import 'model/UserProfile.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late Future<void> _future;
  UserProfile? me;
  List<MatchProfile> matches = [];

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  Future<void> _fetch() async {
    final result = await ApiService().getHomeData(4); // ← pass your userId
    me       = result.$1;
    matches  = result.$2;
    debugPrint('Profile image URL: ${me?.image}');
  }

  // ────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (_, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            backgroundColor: Color(0xFFF2F4F7),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildProfileProgressCard(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 24),
                  _buildRecommendedSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // ── HEADER ─────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: (me?.image != null && me!.image!.trim().isNotEmpty)
              ? NetworkImage(me!.image!.trim())
              : const AssetImage('asset/boy1.jpg') as ImageProvider,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome,', style: GoogleFonts.poppins(fontSize: 16)),
              Text('${me?.fullName.split(' ').first ?? ''},',
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(Icons.notifications_none, size: 30),
            Positioned(
              right: 0,
              top: 2,
              child: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Text('2',
                    style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── SEARCH BAR ─────────────────────────────────────────────
  Widget _buildSearchBar() => TextField(
    decoration: InputDecoration(
      hintText: 'Search by criteria',
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // ── PROFILE COMPLETION CARD ────────────────────────────────
  Widget _buildProfileProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: (me?.image != null && me!.image!.trim().isNotEmpty)
                ? NetworkImage(me!.image!.trim())
                : const AssetImage('asset/boy1.jpg') as ImageProvider,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Oops! Your profile is in progress.',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0.4,
                  color: Colors.orange,
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {},
                  child: Text('Complete Now',
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 13,
                          decoration: TextDecoration.underline)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // ── STATISTICS GRID ────────────────────────────────────────
  Widget _buildStatsGrid() {
    final stats = [
      (Icons.remove_red_eye, 'Viewed You', Colors.indigo, '5'),
      (Icons.send, 'Sent Request', Colors.orange, '5'),
      (Icons.inbox, 'Received Request', Colors.pink, '5'),
      (Icons.check_circle, 'Request Accepted', Colors.green, '5'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: stats
          .map((e) => _statCard(e.$1, e.$2, e.$4, e.$3))
          .toList(growable: false),
    );
  }

  Widget _statCard(
      IconData icon, String label, String count, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 6),
            Text(count,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                style:
                GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // ── RECOMMENDED SECTION ───────────────────────────────────
  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended Matches',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: matches.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => _matchCard(matches[i]),
          ),
        ),
      ],
    );
  }

  Widget _matchCard(MatchProfile p) {
    final String firstName = p.fullName.split(' ').first;
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 4))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            (p.image != null && p.image!.trim().isNotEmpty)
                ? Image.network(
              p.image!,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'asset/girl4.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            )
                : Image.asset(
              'asset/girl4.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('$firstName, ${p.age}',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                    const Icon(Icons.favorite_border,
                        color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
