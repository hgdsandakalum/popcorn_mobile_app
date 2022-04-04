import 'package:flutter/material.dart';

import 'package:popcorn_mobile_app/models/models.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';

class MovieHeader extends StatelessWidget {
  final Map<String, dynamic> featuredContent;

  const MovieHeader({
    Key? key,
    required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 410.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(featuredContent['imageUrl']),
              // image: AssetImage(featuredContent['imageUrl']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 410.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 80.0,
          child: SizedBox(
            width: 300.0,
            child: Image.network(featuredContent['titleUrl']),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 25.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.favorite_outline,
                onTap: () => print('My Favourites'),
              ),
              _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                onTap: () => print('Info'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => print('Play'),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.fromLTRB(20.0, 5.0, 25.0, 5.0)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      icon: const Icon(Icons.play_arrow, size: 30.0),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
