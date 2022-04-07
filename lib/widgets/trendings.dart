import 'package:flutter/material.dart';

import 'package:popcorn_mobile_app/models/models.dart';

class Trendings extends StatelessWidget {
  final String title;
  final List<Movie> contentList;

  const Trendings({
    Key? key,
    required this.title,
    required this.contentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 145.0,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: contentList.length,
            itemBuilder: (BuildContext context, int index) {
              final Movie content = contentList[index];
              // String valueString = content.color!.split('(0x')[1].split(')')[0];
              int value = int.parse(content.color!);
              Color contentColor = new Color(value);

              return GestureDetector(
                onTap: () => print(content.name),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14.0),
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: contentColor, width: 3.0),
                      ),
                    ),
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.black54,
                            Colors.transparent,
                          ],
                          stops: [0, 0.25, 1],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: contentColor, width: 3.0),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: 140.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                            height: 30.0,
                            child: Text(
                              content.name!.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 1.9),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(0, 1.8),
                                    blurRadius: 10.0,
                                    color: contentColor,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
