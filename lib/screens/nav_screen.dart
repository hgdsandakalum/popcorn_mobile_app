import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_mobile_app/cubits/cubits.dart';
import 'package:popcorn_mobile_app/screens/screens.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(key: PageStorageKey('homeScreen')),
    MyFavourites(key: PageStorageKey('favouritesScreen')),
    ComingSoon(key: PageStorageKey('comingSoonScreen')),
    Scaffold(),
    MovieListScreen(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Favourites': Icons.favorite,
    'Upcoming': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'My Lists': Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
        create: (_) => AppBarCubit(),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: _icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(icon, size: 30.0),
                  label: title,
                )))
            .values
            .toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
