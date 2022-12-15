import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:reading_tracker/features/home/screens/home_screen.dart';
import 'package:reading_tracker/theme/pallete.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void swithPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  final homeScreenItems = <Widget>[
    const HomeScreen(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.home,
                color: _page == 0 ? Pallete.primaryBlue : Pallete.textGrey,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.barChart2,
                color: _page == 1 ? Pallete.primaryBlue : Pallete.textGrey,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.clock,
                color: _page == 2 ? Pallete.primaryBlue : Pallete.textGrey,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.bookOpen,
                color: _page == 3 ? Pallete.primaryBlue : Pallete.textGrey,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.user,
                color: _page == 4 ? Pallete.primaryBlue : Pallete.textGrey,
              ),
              label: '')
        ],
        onTap: swithPage,
      ),
    );
  }
}
