import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/entities/city_show_entity.dart';
import '../repository/all_shows_repository.dart';

class AllShowsController extends ChangeNotifier {
  final AllShowsRepository repository;

  AllShowsController(this.repository);

  String? exception;
  bool isLoading = false;
  var _allCities = <CityShowEntity>[];
  var shownCities = <CityShowEntity>[];
  Timer? _searchDebouncer;

  Future<void> getCities() async {
    isLoading = true;
    exception = null;
    notifyListeners();

    final result = await repository.getCities();

    isLoading = false;
    result.fold(
      (success) {
        _allCities = success;
      },
      (failure) {
        _allCities = [];
        exception = 'Couldn\'t get cities. Code: ${failure.toString()}';
      },
    );
    shownCities = _allCities;
    notifyListeners();
  }

  void search(String value) {
    if (exception != null || _allCities.isEmpty) {
      return;
    }
    if (_searchDebouncer?.isActive == true) {
      _searchDebouncer?.cancel();
    }
    _searchDebouncer = Timer(const Duration(milliseconds: 300), () {
      shownCities = _allCities.where((element) => element.name.trim().toLowerCase().contains(value.trim().toLowerCase())).toList();
      notifyListeners();
    });
  }
}
