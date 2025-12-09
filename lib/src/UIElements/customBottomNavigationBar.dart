import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget{
  final PageController pageController;
  final int selectedIndex;

  const CustomBottomNavigationBar({
    required this.pageController,
    required this.selectedIndex,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
        onTap: (index) {
            widget.pageController.animateToPage(
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