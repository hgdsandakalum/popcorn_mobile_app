// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_mobile_app/cubits/app_bar/app_bar_cubit.dart';
import 'dart:ui' as ui;
import 'package:popcorn_mobile_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:popcorn_mobile_app/screens/screens.dart';
import 'package:popcorn_mobile_app/widgets/custom_app_bar.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/services.dart';

//FirebaseFirestore firestore = FirebaseFirestore.instance;

class Detail extends StatefulWidget {
  Detail(
      {this.movieId = "",
      this.imageUrl = "",
      this.videoUrl = "",
      this.description = "",
      this.name = ""});
  final String movieId;
  final String imageUrl;
  final String videoUrl;
  final String description;
  final String name;

  @override
  State<StatefulWidget> createState() {
    return new DetailState();
  }
}

class DetailState extends State<Detail> {
  late Future<List<MovieComment>> commentList;
  String commentMessage = "";

  @override
  void initState() {
    commentList = CommentService.fetchCommentsByMovie(widget.movieId);
    super.initState();
  }
  //final docId;
  //MovieDetails(this.movieId);
  //final movie;

  // var image_url =
  //     'https://cdnb.artstation.com/p/assets/images/images/040/935/333/large/carpaa-2011-spiderman-nwh-6-006.jpg?1630315231';
  //MovieDetails(this.movie);
  Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 50.0),
      //   child: BlocBuilder<AppBarCubit, double>(
      //     builder: (context, scrollOffset) {
      //       return CustomAppBar2();
      //     },
      //   ),
      // ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.network(widget.imageUrl, fit: BoxFit.cover),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          new SingleChildScrollView(
            child: new Container(
                margin: const EdgeInsets.all(20.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      child: new Container(
                        width: 400.0,
                        height: 400.0,
                      ),
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          image: new DecorationImage(
                              image: new NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover),
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.black,
                                blurRadius: 20.0,
                                offset: new Offset(0.0, 10.0))
                          ]),
                    ),
                    new Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child: new Text(
                            widget.name,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontFamily: 'Arvo'),
                          )),
                          new Text(
                            '8.5/10',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'Arvo'),
                          )
                        ],
                      ),
                    ),
                    new Text(
                      widget.description,
                      style: new TextStyle(
                          color: Colors.white, fontFamily: 'Arvo'),
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: screenSize.width * 0.90,
                                    height: screenSize.height * 0.90,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(235, 0, 0, 0),
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0),
                                            child: TextField(
                                              onChanged: (String value) {
                                                this.setState(() {
                                                  commentMessage = value;
                                                });
                                              },
                                              style: TextStyle(
                                                  color: Colors.white70),
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.white54,
                                                      width: 0.5),
                                                ),
                                                focusedBorder:
                                                    new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                border: OutlineInputBorder(),
                                                labelText: 'Enter a Comment',
                                                labelStyle: new TextStyle(
                                                    color: Colors.white54),
                                                hintText: 'Enter a Comment',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 6.0),
                                            child: TextButton(
                                              onPressed: () {
                                                DateTime now =
                                                    new DateTime.now();
                                                final formattedDate =
                                                    DateFormat.yMd()
                                                        .format(now);
                                                final formattedTime =
                                                    DateFormat.Hm().format(now);
                                                this.setState(() {
                                                  CommentService
                                                      .addCommentsByMovie(
                                                          widget.movieId,
                                                          "u02",
                                                          "Sanda",
                                                          formattedDate,
                                                          formattedTime,
                                                          commentMessage);
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text(
                                                "Post",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.amber),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size.fromHeight(40.0)),
                                              ),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: new Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 8.0),
                                                child:
                                                    FutureBuilder<
                                                            List<MovieComment>>(
                                                        future: commentList,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            if (snapshot.data!
                                                                .isEmpty) {
                                                              return Center(
                                                                  child:
                                                                      Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        20.0),
                                                                child: Text(
                                                                  'No comments available',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white60,
                                                                      fontSize:
                                                                          14.0),
                                                                ),
                                                              ));
                                                            }

                                                            return ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  snapshot.data!
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                final MovieComment
                                                                    comment =
                                                                    snapshot.data![
                                                                        index];

                                                                return GestureDetector(
                                                                  onTap: () => {
                                                                    print(comment
                                                                        .userName)
                                                                  },
                                                                  onLongPress:
                                                                      () {
                                                                    var baseDialog =
                                                                        BaseAlertDialog2(removeOnPressed:
                                                                            () {
                                                                      CommentService.deleteComment(
                                                                          comment
                                                                              .movieId,
                                                                          comment
                                                                              .message);
                                                                      final snackBar =
                                                                          SnackBar(
                                                                        content:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            const Text(
                                                                              'Comment has been removed.',
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Icon(
                                                                              Icons.done_all_rounded,
                                                                              color: Colors.black,
                                                                            )
                                                                          ],
                                                                        ),
                                                                        backgroundColor:
                                                                            Colors.redAccent,
                                                                        behavior:
                                                                            SnackBarBehavior.floating,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                      );

                                                                      // Find the ScaffoldMessenger in the widget tree
                                                                      // and use it to show a SnackBar.
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);
                                                                      Navigator.pop(
                                                                          context);
                                                                    }, editOnPressed:
                                                                            () {
                                                                      print(
                                                                          "Edit");
                                                                    });
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                baseDialog);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    width: double
                                                                        .infinity,
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.white24),
                                                                            borderRadius: BorderRadius.all(
                                                                              Radius.circular(7.0),
                                                                            )),
                                                                    child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: <
                                                                            Widget>[
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.comment,
                                                                                color: Colors.white38,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                child: Text(
                                                                                  comment.message,
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 8.0),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text.rich(TextSpan(children: [
                                                                                TextSpan(
                                                                                  text: 'Posted By ',
                                                                                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: comment.userName,
                                                                                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                                                                                )
                                                                              ])),
                                                                              Text.rich(TextSpan(children: [
                                                                                TextSpan(
                                                                                  text: comment.commentTime,
                                                                                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                                                                                ),
                                                                                WidgetSpan(
                                                                                    child: SizedBox(
                                                                                  width: 8.0,
                                                                                )),
                                                                                TextSpan(
                                                                                  text: comment.commentDate,
                                                                                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                                                                                )
                                                                              ])),
                                                                            ],
                                                                          )
                                                                        ]),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                              '${snapshot.error}',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 14.0,
                                                              ),
                                                            );
                                                          }

                                                          return Center(
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          20.0),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    child:
                                                                        const CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation(
                                                                              Colors.white70),
                                                                    ),
                                                                  )));
                                                        })),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: new Container(
                            width: 150.0,
                            height: 60.0,
                            alignment: Alignment.center,
                            child: new Text(
                              'Feedbacks',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Arvo',
                                  fontSize: 20.0),
                            ),
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: Color(0xaa3C3261)),
                          ),
                        )),
                        new Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: new Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: new Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              ),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  color: const Color(0xaa3C3261)),
                            ))
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
