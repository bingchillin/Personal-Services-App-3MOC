import 'package:flutter/material.dart';
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
      title: 'Flutter Interface',
      theme: darkTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBarWidget(),
      body: Center(
        child: Text(
          '',
        ),
      ),
    );
  }
}
