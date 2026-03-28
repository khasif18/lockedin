import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LockedIn'),
      ),
      body: Center(
        child: Text(
          'Home',
          style: theme.textTheme.displaySmall,
        ),
      ),
    );
  }
}

