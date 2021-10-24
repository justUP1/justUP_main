import 'activity_model.dart';

class Destination {
  String imageUrl;
  String name;
  double rating;
  String type;
  int min;
  String place;
  String description;

  Destination({
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.type,
    required this.min,
    required this.place,
    required this.description,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'images/stmarksbasilica.jpg',
    name: 'St. Mark\'s Basilica',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'images/gondola.jpg',
    name: 'Walking Tour and Gonadola Ride',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'images/murano.jpg',
    name: 'Murano and Burano Tour',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'images/destination0.png',
    name: "Угличская башня Спасо-Преображенского монастыря",
    rating: 5.0,
    type: "Достопримечательность",
    min: 5,
    place: "Ярославль, Ярославская область",
      description: 'Угличская(северо-восточная) проездная башня Спасо-Преображенского монастыря возведена в 1635 году. Название свое она получила от дороги на Углич, которая начиналась от башни. Восточная стена монастыря и Угличская башня были возведены на месте городских укреплений в 1635-1645 гг. Эту башню, за почти неотличимое внешнее сходство, часто путают с Богородицкой (северо-западной) башней, расположенной у начала Московского проспекта.'
  ),
  Destination(
    imageUrl: 'images/destination1.png',
    name: "Медвежий Угол «кутюр-шоу»",
    rating: 5.0,
    type: "Культура в Ярославле",
    min: 5,
    place: "Революционный пр-д, 14, Ярославль, Ярославская обл., 150000",
    description: '«Кутюр-шоу» – это единственный в своем роде музей в Ярославле, посвященный символу города. Здесь собрана уникальная коллекция дизайнерских нарядов, отражающих историко-культурное и спортивное наследие «столицы Золотого кольца» и России в целом.',
  ),
  Destination(
    imageUrl: 'images/destination2.png',
    name: "Парк на Даманском острове",
    rating: 4.5,
    type: "Культура в Ярославле",
    min: 15,
    place: "ул. Подзеленье, 1-а, Ярославль, Ярославская обл., 150000",
    description: 'Парк на острове Даманском в Ярославле — одно из тех мест, которые можно смело рекомендовать к посещению не только местным жителям, но и туристам. Несколько сот гектаров, которые до середины прошлого столетия занимали грядки, сегодня заполнены аттракционами, расчерчены цветущими аллеями и полностью отданы под зону отдыха горожан и гостей Ярославля.'
  ),
];