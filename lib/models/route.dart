class RouteModel {
  RouteModel({
    required this.from,
    required this.to,
    required this.fromTime,
    required this.toTime,
    required this.url,
    required this.price,
    required this.mark
  });

  final String from;
  final String to;
  final String fromTime;
  final String toTime;
  final String url;
  final int price;
  final int mark;
}