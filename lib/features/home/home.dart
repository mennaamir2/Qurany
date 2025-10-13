import 'package:azkary/features/azkar/azkar.dart';
import 'package:azkary/features/favourite/favourite.dart';
import 'package:azkary/features/hadith/hadith.dart';
import 'package:azkary/features/quran/quran.dart';
import 'package:azkary/features/sebha/sebha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        children: const [Quran(), Hadith(), Azkarr(), Sebha(), Favourite()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
            controller.animateToPage(value,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          // backgroundColor: ColorApp.primaryColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.quran2), label: 'قرآن'),
            BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.quran), label: 'احاديث'),
            BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.prayer), label: 'الأذكار'),
            BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.tasbih), label: 'السبحة'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'المفضلة'),
          ]),
    );
  }
}
