import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget{
  final PageController pageController;
  final int selectedIndex;

  const CustomBottomNavigationBar({super.key, 
    required this.pageController,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 16,
      unselectedFontSize: 12,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      selectedItemColor: Colors.blueAccent,
      currentIndex: selectedIndex,
        onTap: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
        },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_arrow),
          label: "play",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: "info"
        ),
      ]
    );
  }
}