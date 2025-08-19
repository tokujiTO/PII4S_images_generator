import 'package:flutter/material.dart';

class DevPageView extends StatelessWidget {
  const DevPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      {'name': 'Loading', 'route': '/loading'},
      {'name': 'Home', 'route': '/home'},
      {'name': 'Chat', 'route': '/chat'},
      {'name': 'History', 'route': '/history'},
      {'name': 'Settings', 'route': '/settings'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var r in routes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(r['route']!),
                  child: Text('Go to ${r['name']} Page'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
