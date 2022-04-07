import 'package:flutter/material.dart';

import 'package:popcorn_mobile_app/models/models.dart';
import 'package:popcorn_mobile_app/services/favourites.dart';

import '../screens/screens.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Movie> contentList;

  const ContentList({
    Key? key,
    required this.title,
    required this.contentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contentList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
              child: Text(
                'Sorry. There are no movies available at the moment.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 220.0,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: contentList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Movie content = contentList[index];
                  return GestureDetector(
                    onLongPress: () {
                      FavouriteService.addFavourtie(content);
                    },
                    //onTap: () => print(content.name),
                    onTap: () => MovieDetails(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      height: 200.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
