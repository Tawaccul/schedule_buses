// lib/presentation/viewmodels/main_viewmodel.dart

import 'package:flutter/material.dart';
import '../../data/models/bus.dart';
import '../../data/repositories/bus_repository.dart' as repository;

class MainViewModel extends ChangeNotifier {
  final repository.BusRepository _busRepository = repository.BusRepository();
  List<Bus> _buses = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Bus> get buses => _buses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void fetchBuses(String departureCity, String destinationCity, DateTime date) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _buses = await _busRepository.getBuses(departureCity, destinationCity, date);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshBuses(String departureCity, String destinationCity, DateTime date) {
    fetchBuses(departureCity, destinationCity, date);
  }
}