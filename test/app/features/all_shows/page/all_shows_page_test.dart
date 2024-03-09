import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:showtime_app/app/core/constants/cities.dart';
import 'package:showtime_app/app/core/entities/city_show_entity.dart';
import 'package:showtime_app/app/features/all_shows/controller/all_shows_controller.dart';
import 'package:showtime_app/app/features/all_shows/page/all_shows_page.dart';
import 'package:showtime_app/app/features/all_shows/repository/all_shows_repository.dart';

class MockAllShowsRepository extends Mock implements AllShowsRepository {}

void main() {
  late AllShowsRepository repository;
  late AllShowsController controller;

  setUpAll(() {
    repository = MockAllShowsRepository();
    controller = AllShowsController(repository);
  });

  group('AllShowsPage |', () {
    testWidgets('Successful initialization', (tester) async {
      final cities = defaultCities.map((e) => CityShowEntity.fromMap(e)).toList();
      when(
        () => repository.getCities(),
      ).thenAnswer(
        (invocation) async => cities.toSuccess(),
      );

      await tester.pumpWidget(MaterialApp(
        home: AllShowsPage(controller: controller),
      ));

      expect(find.byType(CircularProgressIndicator), findsOne);

      await tester.pump();

      for (var i = 0; i < cities.length; i++) {
        expect(find.textContaining(cities[i].name), findsAtLeast(1));
      }
    });
    testWidgets('Search city', (tester) async {
      final cities = defaultCities.map((e) => CityShowEntity.fromMap(e)).toList();
      const searchText = 'São Paulo';
      when(
        () => repository.getCities(),
      ).thenAnswer(
        (invocation) async => cities.toSuccess(),
      );

      await tester.pumpWidget(MaterialApp(
        home: AllShowsPage(controller: controller),
      ));

      expect(find.byType(CircularProgressIndicator), findsOne);

      await tester.pump();

      expect(find.text('Type the name of a city'), findsOne);
      await tester.enterText(find.byType(TextField), searchText);

      await tester.pump(const Duration(milliseconds: 300));

      for (var i = 0; i < cities.length; i++) {
        final cityName = cities[i].name;
        expect(find.textContaining(cityName), findsExactly(cityName == searchText ? 2 : 0));
      }
    });
  });
}
