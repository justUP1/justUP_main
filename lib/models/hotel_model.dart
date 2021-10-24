class Hotel {
  String imageUrl;
  String name;
  int price;

  Hotel({
    required this.imageUrl,
    required this.name,
    required this.price,
  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'images/hotel0.jpg',
    name: 'Отель 1',
    price: 1000,
  ),
  Hotel(
    imageUrl: 'images/hotel1.jpg',
    name: 'Отель 2',
    price: 2000,
  ),
  Hotel(
    imageUrl: 'images/hotel2.jpg',
    name: 'Отель 3',
    price: 1500,
  ),
];