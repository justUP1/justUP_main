import 'package:flutter/material.dart';
import 'package:just_up/models/friend_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:just_up/models/place.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  PageController controller = PageController();

  int currentSelect = 0;

  List<String> categoryList = [
    'Новые',
    'Популярные',
    'Самые просматриваемые',
    'Все',
  ];

  bool isFilled = false;

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  List<FriendModel> friends = [
    FriendModel(
        name: "Собачкина Мария Александровна",
      url: "images/friend1.png"
    ),
    FriendModel(
        name: "Кузнецова Алина Николаевна",
        url: "images/friend2.png"
    ),
    FriendModel(
        name: "Абрамов Михаил Владимирович",
        url: "images/friend3.png"
    ),
    FriendModel(
        name: "Романовский Александр Львович",
        url: "images/friend4.png"
    ),
    FriendModel(
        name: "Рябикова Евгения Викторовна",
        url: "images/friend5.png"
    )
  ];

  List<Place> placeList = [
    Place("Тропический лес", "Коста Рика", "images/bg1.png", 240),
    Place("Озеро Луиз", "Канада", "images/bg2.png", 200),
    Place("Плитвицкие озера", "Канада", "images/bg4.png", 120),
    Place("Дубай", "ОАЭ", "images/bg3.png", 200),
    Place("Тропический лес", "Канада", "images/bg6.png", 240),
    Place("Плитвицкие озера", "Коста Рика", "images/bg5.png", 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() {
                  isFilled = false;
                  controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease
                  );
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isFilled ? Colors.transparent : const Color(0xffDC3C4D),
                  ),
                  child: Text(
                    "Рейтинг среди друзей",
                    style: TextStyle(
                      color: isFilled ? Colors.black : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() {
                  isFilled = true;
                  controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease
                  );
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isFilled ? const Color(0xffDC3C4D) : Colors.transparent,
                  ),
                  child: Text(
                    "Активность друзей",
                    style: TextStyle(
                      color: isFilled ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                )
              )
            ],
          ),
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(friends[index].url),
                              ),
                              // if (chat.isActive)
                              //   Positioned(
                              //     right: 0,
                              //     bottom: 0,
                              //     child: Container(
                              //       height: 16,
                              //       width: 16,
                              //       decoration: BoxDecoration(
                              //         color: Colors.red,
                              //         shape: BoxShape.circle,
                              //         border: Border.all(
                              //             color: Theme.of(context).scaffoldBackgroundColor,
                              //             width: 3),
                              //       ),
                              //     ),
                              //   )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    friends[index].name,
                                    style:
                                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildRatingStars(5),
                                ],
                              ),
                            ),
                          ),
                          // Opacity(
                          //   opacity: 0.64,
                          //   child: Text(chat.time),
                          // ),
                        ],
                      ),
                    )
                ),
                Column(
                  children: [
                    Container(
                      height: 40,
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentSelect = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 36),
                            child: Text(
                              categoryList[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                currentSelect == index ? FontWeight.bold : FontWeight.w500,
                                color: currentSelect == index ? Colors.red : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: StaggeredGridView.countBuilder(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 4,
                          itemCount: placeList.length,
                          staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                          itemBuilder: (context, index) => GestureDetector(
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) {
                            //         return DetailScreen();
                            //       },
                            //     ),
                            //   );
                            // },
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: placeList[index].height,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      placeList[index].imageUrl,
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      placeList[index].title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      placeList[index].subtitle,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ),
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _buildCard(String name, String status, int cardIndex) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 12.0),
            Stack(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.green,
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'
                            )
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40.0),
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: status == 'Away' ? Colors.amber : Colors.green,
                        border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 2.0
                        )
                    ),
                  )
                ]),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              status,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey
              ),
            ),
            const SizedBox(height: 15.0),
            Expanded(
                child: Container(
                    width: 175.0,
                    decoration: BoxDecoration(
                      color: status == 'Away' ? Colors.grey: Colors.green,
                      borderRadius: const BorderRadius.only
                        (
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)
                      ),
                    ),
                    child: const Center(
                      child: Text('Request',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Quicksand'
                        ),
                      ),
                    )
                )
            )
          ],
        ),
        margin: cardIndex.isEven? const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
    );
  }
}