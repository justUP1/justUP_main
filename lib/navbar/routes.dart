import 'package:flutter/material.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  List<String> routeImages = [
    "https://yamoscow.ru/wp-content/uploads/2020/08/neboskryoby-moskva-siti.jpg",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/a4/e0/27/st-petersburg.jpg?w=1200&h=-1&s=1",
    "http://www.whitegiraf.ru/images/destinations/russia/anapa/anapa.jpg"
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF3F5F7),
    body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                height: 170.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 120.0,
                            child: Text(
                              "Москва",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Column(
                            children: const <Widget>[
                              Text(
                                "Сочи",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'per pax',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        "5.0",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      //_buildRatingStars(activity.rating),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff2247e4),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "9:00",
                                style: TextStyle(
                                    color: Colors.white
                                )
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff2247e4),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "11:00",
                              style: TextStyle(
                                color: Colors.white
                              )
                            )
                          )
                        ]
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20.0,
                top: 15.0,
                bottom: 15.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    routeImages[index],
                    width: 110.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    )
  );
}