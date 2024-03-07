import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:showtime_app/app/features/all_shows/controller/all_shows_page.dart';

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
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, child) {
          final cities = widget.controller.cities;
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
                onTap: () {
                  context.push('/forecast', extra: city);
                },
              );
            },
          );
        },
      ),
    );
  }
}
