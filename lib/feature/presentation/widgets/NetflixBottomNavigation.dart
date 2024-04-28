import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/utils/Utils.dart';

class NextflixBottomNavigation extends StatefulWidget {
  const NextflixBottomNavigation({super.key});

  @override
  State<NextflixBottomNavigation> createState() =>
      _NextflixBottomNavigationState();
}

class _NextflixBottomNavigationState extends State<NextflixBottomNavigation> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: bottomNavigationBarColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.home),
          activeIcon: Icon(LucideIcons.home),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(LucideIcons.youtube),
          activeIcon: Icon(LucideIcons.youtube),
          label: 'New & Hot',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.smile),
          activeIcon: Icon(LucideIcons.smile),
          label: 'Fast Laughs',
        ),
          BottomNavigationBarItem(
          icon: Icon(LucideIcons.search),
          activeIcon: Icon(LucideIcons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.download),
          activeIcon: Icon(LucideIcons.download),
          label: 'Downloads',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      selectedItemColor: Colors.white,
      onTap: (value) {
        switch (value) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/newandhot');
            break;
          case 3:
            context.go('/search');
            break;
          default:

        }
        setState(() {
          _index = value;
        });
      },
    );
  }
}
