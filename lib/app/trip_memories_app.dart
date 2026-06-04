import 'package:flutter/material.dart';

import '../features/memories/pages/home_page.dart';
import 'theme/app_theme.dart';

class TripMemoriesApp extends StatelessWidget {
  const TripMemoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Memories',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
