import 'package:flutter/material.dart';
import 'package:uber_deep_link/features/uber/presentation/pages/deep_link_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Uber DeepLink'),
        ),
        body: const DeepLinkPage(),
      ),
    );
  }
}
