import 'package:flutter/material.dart';

import 'package:popcorn_mobile_app/assets.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';

import '../screens/screens.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      color: Colors.black,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VerticalIconButton(
              icon: Icons.home_filled,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavScreen()),
                );
              },
            ),
            Image.asset(Assets.logo_popcorn2),
          ],
        ),
      ),
    );
  }
}
