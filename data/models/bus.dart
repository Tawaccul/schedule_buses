class Bus {
  String departureCity;
  String destinationCity;
  DateTime date;
  int busNumber;
  String departureTime;
  String arrivalTime;
  double price;

  Bus({
    required this.departureCity,
    required this.destinationCity,
    required this.date,
    required this.busNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
  });

 factory Bus.fromJson(Map<String, dynamic> json) {
  var busInfo = json['Bus'] ?? {};
  return Bus(
    departureCity: json['Departure']['Name'] ?? 'Неизвестный город отправления',
    destinationCity: json['Destination']['Name'] ?? 'Неизвестный город назначения',
    date: DateTime.parse(json['DepartureTime'] ?? DateTime.now().toString()),
    busNumber: int.tryParse(busInfo['RouteNum']?.toString() ?? '') ?? 0,
    departureTime: json['DepartureTime'] ?? '',
    arrivalTime: json['ArrivalTime'] ?? '',
    price: double.tryParse(json['PassengerFareCost']?.toString() ?? '') ?? 0.0,
    );
}



}
