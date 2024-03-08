import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'controller/all_shows_page.dart';

class AllShowsPage extends StatefulWidget {
  final AllShowsController controller;
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
                hintText: 'e.g. São Paulo',
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
                        title: Text(city.name),
                        onTap: () => context.push('/forecast', extra: city),
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
