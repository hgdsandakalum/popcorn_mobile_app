// import 'dart:html';
import 'package:flutter/material.dart';
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

//FirebaseFirestore firestore = FirebaseFirestore.instance;

class Detail extends StatefulWidget {
  final docId;
  Detail(this.docId);

  @override
  State<StatefulWidget> createState() => MovieDetails(docId);
}

class MovieDetails extends State<Detail> {
  final docId;
  MovieDetails(this.docId);
  //final movie;

  var image_url =
      'https://cdnb.artstation.com/p/assets/images/images/040/935/333/large/carpaa-2011-spiderman-nwh-6-006.jpg?1630315231';
  //MovieDetails(this.movie);
  Color mainColor = const Color(0xff3C3261);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar2();
          },
        ),
      ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.network(image_url, fit: BoxFit.cover),
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
                              image: new NetworkImage(image_url),
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
                            'Spider Man - No Way Home',
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
                      'Over View of the Movie',
                      style: new TextStyle(
                          color: Colors.white, fontFamily: 'Arvo'),
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Container(
                          width: 150.0,
                          height: 60.0,
                          alignment: Alignment.center,
                          child: new Text(
                            'Rate Movie',
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'Arvo',
                                fontSize: 20.0),
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: Color(0xaa3C3261)),
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
