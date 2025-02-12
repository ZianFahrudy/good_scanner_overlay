import 'package:flutter/material.dart';
import 'package:good_scanner_overlay/good_scanner_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          MobileScanner(),
          GoodScannerOverlay(
            animationColor: Colors.yellow,
            borderColor: Colors.red,
            // curve: Curves.easeInOut,
            borderRadius: 0,
            // backgroudWidget: Image.network(
            //   'https://m.media-amazon.com/images/M/MV5BYjJmMjBkZjMtZThiZS00Nzk3LWJlN2UtYmE5ZjkyNjJiZjgxXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
            //   fit: BoxFit.cover,
            // ),
            goodScannerAnimation: GoodScannerAnimation.center,
            goodScannerOverlayBackground: GoodScannerOverlayBackground.center,
            goodScannerBorder: GoodScannerBorder.center,
          ),
        ],
      ),
    );
  }
}
