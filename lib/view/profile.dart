import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  /* ── section meta (route names change to yours) ───────── */
  static final _sections = <Map<String, dynamic>>[
    {
      'title': 'Basic Details',
      'icon': Icons.info_outline,
      'route': '/basicdetails',
    },
    {
      'title': 'Religious & Caste',
      'icon': Icons.temple_hindu_outlined,
      'route': '/religiousDetails',
    },
    {
      'title': 'Education & Career',
      'icon': Icons.school_outlined,
      'route': '/education_details',
    },
    {
      'title': 'Family Details',
      'icon': Icons.family_restroom_outlined,
      'route': '/family_details',
    },
    {
      'title': 'Lifestyle',
      'icon': Icons.fitness_center_outlined,
      'route': '/lifestyle_hobbies',
    },
    {
      'title': 'Partner Preferences',
      'icon': Icons.favorite_outline,
      'route': '/partner_preference',
    },
  ];

  /* ─────────────────────────────────────────────────────── */

  void _open(BuildContext ctx, String route) => Navigator.pushNamed(ctx, route);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FB),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _sliverHeader(context),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (c, i) => _glassTile(
                context,
                icon: _sections[i]['icon'],
                title: _sections[i]['title'],
                route: _sections[i]['route'],
              ),
              childCount: _sections.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
        ],
      ),
    );
  }

  /* ───── Sliver header with hero gradient ───── */
  SliverAppBar _sliverHeader(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 260,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(
        builder: (ctx, c) {
          final top = c.biggest.height;
          return FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        const AssetImage('asset/boy3.jpg'), // ← dynamic later
                      ),
                      const SizedBox(height: 14),
                      Text('Vishal Fatnani, 25',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      Text('Vadodara • India',
                          style: GoogleFonts.poppins(
                              color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 18),
                      _miniStatsRow(),
                      const SizedBox(height: 26),
                    ],
                  ),
                ],
              ),
            ),
            titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
            title: top < 120
                ? Text('My Profile',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, color: Colors.white))
                : null,
          );
        },
      ),
    );
  }

  /* ───── three little pills — remove if not needed ──── */
  Widget _miniStatsRow() {
    final items = [
      (Icons.remove_red_eye_outlined, 'Viewed', '5'),
      (Icons.favorite, 'Liked You', '12'),
      (Icons.percent, 'Profile', '80%'),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items
          .map(
            (e) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(e.$1, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(e.$3,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  /* ───── glass‑morphism list tile ───── */
  Widget _glassTile(BuildContext ctx,
      {required IconData icon,
        required String title,
        required String route}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Material(
            color: Colors.white.withOpacity(0.7),
            elevation: 4,
            shadowColor: Colors.black26,
            borderRadius: BorderRadius.circular(22),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(icon, color: Colors.blue.shade800),
              ),
              title: Text(title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 15)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.black54, size: 18),
              onTap: () => _open(ctx, route),
            ),
          ),
        ),
      ),
    );
  }
}
