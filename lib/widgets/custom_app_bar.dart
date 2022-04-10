import 'package:flutter/material.dart';

import 'package:popcorn_mobile_app/assets.dart';

import '../screens/screens.dart';
import '../screens/userProfile.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({
    Key? key,
    this.scrollOffset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      color:
          Colors.black.withOpacity((scrollOffset / 300).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(Assets.logo_popcorn),
            const SizedBox(width: 16.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _MainAppBarButton(
                    title: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  _MainAppBarButton(
                    title: 'My Favourites',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyFavourites()),
                      );
                    },
                  ),
                  _MainAppBarButton(
                    title: 'My Lists',
                    onTap: () => print('My Lists'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainAppBarButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MainAppBarButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
