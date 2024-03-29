import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/all_shows_controller.dart';

/// All cities with shows are listed here.
/// By clicking on them, it's possible to see their weather forecast.
/// Plus, it's possible to search cities by name.
class AllShowsPage extends StatefulWidget {
  final AllShowsController controller;

  ///Creates an [AllShowsPage] instance
  const AllShowsPage({super.key, required this.controller});

  @override
  State<AllShowsPage> createState() => _AllShowsPageState();
}

class _AllShowsPageState extends State<AllShowsPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Shows'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 25),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                hintText: 'Type the name of a city',
              ),
              onChanged: widget.controller.search,
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.controller,
                builder: (context, child) {
                  final cities = widget.controller.shownCities;
                  final exception = widget.controller.exception;
                  final hasException = exception != null;
                  final isLoading = widget.controller.isLoading;
                  if (hasException) {
                    return Center(
                      child: Text(exception),
                    );
                  }
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      return ListTile(
                        key: Key(city.name),
                        title: Text(city.name),
                        onTap: () => kIsWeb ? context.go('/forecast', extra: city) : context.push('/forecast', extra: city),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
