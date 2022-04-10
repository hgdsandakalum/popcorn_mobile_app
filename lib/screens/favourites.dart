import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_mobile_app/services/services.dart';

import '../cubits/app_bar/app_bar_cubit.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({Key? key}) : super(key: key);

  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  late Future<List<Movie>> favouriteMovies;

  @override
  void initState() {
    favouriteMovies = FavouriteService.fetchFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar2();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "My Favourites",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 25.0),
                child: FutureBuilder<List<Movie>>(
                    future: favouriteMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Movie> contentList = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.58,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: contentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Movie content = contentList[index];
                            return GestureDetector(
                              onTap: () => print(content.movieId),
                              onLongPress: () {
                                var baseDialog = BaseAlertDialog(
                                    title: "Remove from Favourites",
                                    content:
                                        "Do you really want to remove this movie from your favourites?",
                                    yesOnPressed: () {
                                      FavouriteService.deleteFavourtie(
                                          content.movieId!);
                                      final snackBar = SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Removed from your favourites.',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.done_all_rounded,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                        backgroundColor: Colors.redAccent,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      );

                                      // Find the ScaffoldMessenger in the widget tree
                                      // and use it to show a SnackBar.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.pop(context);
                                    },
                                    noOnPressed: () {
                                      Navigator.pop(context);
                                    },
                                    yes: "Yes",
                                    no: "Cancel");
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        baseDialog);
                              },
                              child: Container(
                                height: 200.0,
                                width: 130.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(content.imageUrl!),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }

                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10.0),
                          child: SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
