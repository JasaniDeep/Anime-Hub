import 'package:flutter/material.dart';
import 'package:movie_app/view/bottom_bar/home_screen.dart';
import 'package:movie_app/view/bottom_bar/search_screen.dart';
import 'package:movie_app/view/bottom_bar/new_releases_screen.dart';
import 'package:movie_app/constants/common_colors.dart';
import 'package:movie_app/constants/text_style.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const NewReleasesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: CommonColors.redColor,
          unselectedItemColor: CommonColors.greyTextColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'New Releases',
            ),
          ],
          selectedLabelStyle: mediumTextStyle(fontsize: 12),
          unselectedLabelStyle: regularTextStyle(fontsize: 12),
        ),
      ),
    );
  }
}

