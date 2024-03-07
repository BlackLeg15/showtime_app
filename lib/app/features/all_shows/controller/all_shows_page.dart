import 'package:flutter/foundation.dart';
import 'package:showtime_app/app/core/entities/city_show_entity.dart';
import 'package:showtime_app/app/features/all_shows/repository/all_shows_repository.dart';

class AllShowsController extends ChangeNotifier {
  final AllShowsRepository repository;

  AllShowsController(this.repository);

  String? exception;
  bool isLoading = false;
  var cities = <CityShowEntity>[];

  Future<void> getCities() async {
    isLoading = true;
    exception = null;
    notifyListeners();

    final result = await repository.getCities();

    isLoading = false;
    result.fold(
      (success) {
        cities = success;
      },
      (failure) {
        cities = [];
        exception = 'Couldn\'t get cities. Code: ${failure.toString()}';
      },
    );
    notifyListeners();
  }
}
