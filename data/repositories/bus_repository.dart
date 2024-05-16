import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/bus.dart';

class BusRepository {
  final Dio _dio = Dio();

  Future<List<Bus>> getBuses(String departureCity, String destinationCity, DateTime date) async {
    try {
      String month = date.month.toString().padLeft(2, '0');
      String day = date.day.toString().padLeft(2, '0');
      String apiUrl = 'https://bibiptrip.com/api/avibus/search_trips_cities/?departure_city=$departureCity&destination_city=$destinationCity&date=${date.year}-$month-$day';
      if (kDebugMode) {
        print(apiUrl);
      } // Выводим сформированный URL-адрес для тестирования
      final response = await _dio.get(
        apiUrl,
      );

      if (kDebugMode) {
        print("Departure City: $departureCity");
      }
      if (kDebugMode) {
        print("Destination City: $destinationCity");
      }
      if (kDebugMode) {
        print("Date: ${date.year}-$month-$day");
      }
if (kDebugMode) {
    print("Received JSON: ${response.data}");
  }
      if (response.statusCode == 200) {
        if (response.data is Map) {
          final List<dynamic> data = response.data['trips'];
          if (data.isEmpty) {
            if (kDebugMode) {
              print('No buses found for this trip');
            }
            return []; 
          }

          return data.map<Bus>((json) => Bus.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load buses (Status code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load buses: $e');
    }
  }
}
