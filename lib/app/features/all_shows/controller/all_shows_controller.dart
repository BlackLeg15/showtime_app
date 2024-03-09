import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/entities/city_show_entity.dart';
import '../repository/all_shows_repository.dart';

/// This class controls states involving gettings cities with shows,
/// as well as search for them by name.
/// It relies on [AllShowsRepository] to get the available cities.
class AllShowsController extends ChangeNotifier {
  final AllShowsRepository repository;

  ///Creates an [AllShowsController] instance
  AllShowsController(this.repository);

  /// Exception message
  String? exception;

  /// Whether requests are happening
  bool isLoading = false;

  /// All available cities
  var _allCities = <CityShowEntity>[];

  /// That value is supposed to rely on the search feature
  var shownCities = <CityShowEntity>[];

  /// Search feature debouncer
  Timer? _searchDebouncer;

  /// Get the cities to be placed in [_allCities] and [shownCities] (initially).
  /// While the request is awaiting a response, [isLoading] will be true.
  /// If there are any exceptions, [exception] will get a message.
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

  /// Fires the search for a city name represented by [value].
  /// [_searchDebouncer] allows the search to begin only 300 milliseconds
  /// after the function is not being called anymore.
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
