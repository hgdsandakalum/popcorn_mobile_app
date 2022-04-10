import 'package:flutter/material.dart';

import 'package:popcorn_mobile_app/models/models.dart';
import 'package:popcorn_mobile_app/services/favourites.dart';

import '../screens/screens.dart';

class ContentList extends StatelessWidget {
  final String title;
  final user_model currentUser;
  final List<Movie> contentList;

  const ContentList({
    Key? key,
    required this.title,
    required this.contentList,
    required this.currentUser,
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

                      final snackBar = SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Added to the favourite.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.done_all_rounded,
                              color: Colors.black,
                            )
                          ],
                        ),
                        backgroundColor: Colors.amberAccent,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    //onTap: () => print(content.name),
                    onTap: () {
                      //var docId = content.name;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              //builder: (context) => Detail(docId)));
                              builder: ((context) => Detail(
                                    movieId: (content.movieId).toString(),
                                    imageUrl: (content.imageUrl).toString(),
                                    videoUrl: (content.videoUrl).toString(),
                                    description:
                                        (content.description).toString(),
                                    name: (content.name).toString(),
                                  ))));
                    },
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
