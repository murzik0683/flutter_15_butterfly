import 'package:flutter/material.dart';
import 'package:flutter_5_butterfly/buterfly_mobile.dart';
import 'package:flutter_5_butterfly/butterfly_desktop.dart';
import 'package:flutter_5_butterfly/butterfly_planshet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Butterfly Adaptiv',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return currentWidth < 600
        ? const ButerflyMobileList()
        : const ButerflyPlanshet();
  }

  //  Widget build(BuildContext context) {
  //   return LayoutBuilder(builder: (builder, constraints) {
  //     final screenWidth = constraints.maxWidth;
  //     if (screenWidth > 1024) {
  //       return const ButerflyDesktop();
  //     }

  //     if (screenWidth > 600) {
  //       return const ButerflyPlanshet();
  //     }

  //     return const ButerflyMobileList();
  //   });
  // }
}
