import 'package:flutter/material.dart';
import 'package:goldie_studio/pages/home.dart';
import 'package:goldie_studio/widgets/side_bar.dart';
import 'package:goldie_studio/widgets/top_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor customColor = const MaterialColor(0xFFFF6262, {
    50: Color(0xFFFFF2F2),
    100: Color(0xFFFFD6D6),
    200: Color(0xFFFFB9B9),
    300: Color(0xFFFF9C9C),
    400: Color(0xFFFF7F7F),
    500: Color(0xFFFF6262),
    600: Color(0xFFFF4C4C),
    700: Color(0xFFFF3636),
    800: Color(0xFFFF1F1F),
    900: Color(0xFFFF0909),
  });

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: customColor,
      ),
    );

    return MaterialApp(
      theme: darkTheme,
      home: const MyNavigationWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyNavigationWidget extends StatefulWidget {
  const MyNavigationWidget({super.key});

  @override
  State<MyNavigationWidget> createState() => _MyNavigationWidgetState();
}

class _MyNavigationWidgetState extends State<MyNavigationWidget> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarWidget(),
      body: Row(
        children: [
          const Drawer(
            child: SideBarWidget(),
          ),
          Expanded(
            child: [
              const MyHomePage(),
            ][currentPageIndex],
          ),
        ],
      ),
    );
  }
}

