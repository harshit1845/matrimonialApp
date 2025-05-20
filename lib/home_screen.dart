// home_content.dart
import 'dart:ui';
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
    final r = await ApiService().getHomeData(4);
    me = r.$1;
    matches = r.$2;
  }

  /* ───────────────────────────────────────────── */

  final _filterChips = ['Nearby', 'Cast-vise', 'state-vise'];
  int _chipSel = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (_, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
              backgroundColor: Color(0xFFF2F4F7),
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heroBanner(),
                  const SizedBox(height: 16),
                  _buildSearch(),
                  const SizedBox(height: 10),
                  _buildChipRow(),
                  const SizedBox(height: 20),
                  _profileProgressCard(),
                  const SizedBox(height: 18),
                  _miniStatsRow(context),
                  const SizedBox(height: 22),
                  _recommended()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /* ───── Hero Banner ───── */
  Widget _heroBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: (me?.image != null && me!.image!.isNotEmpty)
                ? NetworkImage(me!.image!)
                : const AssetImage('asset/boy1.jpg') as ImageProvider,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome,',
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 14)),
                Text(me?.fullName.split(' ').first ?? '',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Stack(
            children: [
              const Icon(Icons.notifications_none,
                  color: Colors.white, size: 28),
              Positioned(
                right: 0,
                top: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Text('2',
                      style: GoogleFonts.poppins(
                          fontSize: 9, fontWeight: FontWeight.w600)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /* ───── Search ───── */
  Widget _buildSearch() => TextField(
    decoration: InputDecoration(
      hintText: 'Search by criteria',
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none),
    ),
  );

  /* ───── Chips Row ───── */
  Widget _buildChipRow() => SizedBox(
    height: 34,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _filterChips.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (_, i) => GestureDetector(
        onTap: () => setState(() => _chipSel = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: _chipSel == i ? Colors.blue.shade50 : Colors.white,
            border: Border.all(
                color: _chipSel == i
                    ? Colors.blue.shade400
                    : Colors.grey.shade400),
          ),
          child: Text(_filterChips[i],
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight:
                  _chipSel == i ? FontWeight.w600 : FontWeight.w400)),
        ),
      ),
    ),
  );

  /* ───── Profile Progress (blur glass) ───── */
  Widget _profileProgressCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white70, width: 0.8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: (me?.image != null && me!.image!.isNotEmpty)
                    ? NetworkImage(me!.image!)
                    : const AssetImage('asset/boy1.jpg') as ImageProvider,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile 40% complete',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                        value: 0.4,
                        color: Colors.blue.shade600,
                        backgroundColor: Colors.grey.shade300),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('Finish',
                      style: GoogleFonts.poppins(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w600)))
            ],
          ),
        ),
      ),
    );
  }

  /* ───── Mini‑stats pills ───── */
  Widget _miniStatsRow(BuildContext context) {
    final items = [
      {
        'icon': Icons.remove_red_eye,
        'label': 'Viewed',
        'count': '5',
        'onTap': () {
          Navigator.pushNamed(context, '/viewed_by');
        }
      },
      {
        'icon': Icons.favorite,
        'label': 'Liked You',
        'count': '12',
        'onTap': () {
          // Add navigation to liked users screen
          Navigator.pushNamed(context, '/like_by');
        }
      },
      {
        'icon': Icons.person_add_alt_1,
        'label': 'Interests',
        'count': '3',
        'onTap': () {
          // Add navigation to interests screen
          // Navigator.pushNamed(context, '/interests');
        }
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items
          .map(
            (e) => Expanded(
          child: GestureDetector(
            onTap: e['onTap'] as void Function(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    e['icon'] as IconData,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    e['count'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    e['label'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }


  /* ───── Recommended ───── */
  Widget _recommended() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Recommended Matches',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),
      SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: matches.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) => _matchCard(matches[i]),
        ),
      )
    ],
  );

  Widget _matchCard(MatchProfile p) {
    final first = p.fullName.split(' ').first;
    return Container(
      width: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.25),
                blurRadius: 6,
                offset: const Offset(0, 4))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            (p.image != null && p.image!.isNotEmpty)
                ? Image.network(p.image!,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover)
                : Image.asset('asset/girl4.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('$first, ${p.age}',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500))),
                    const Icon(Icons.favorite_border,
                        color: Colors.white, size: 14)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
