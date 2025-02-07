<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Good Scanner Overlay

QR Scanner overlay with animation to be used with a stack widget. The animations inspired by Bank Jago QRIS and BRI QRIS. But you can combine the atribut 

# Preview
| Simple | Like Jago QRIS | Like BRI QRIS |
|-------|-------|-------|
| ![](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMzVrb2UwYmFoOHY4MmtuN3dmdTg5bW02MGlvYXQ5bWE1bTY0azVwaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Xfu6jfJsrG8457NhR8/giphy.gif) | ![](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZGFyODlrZGxpN2tybnlnaTl2N3c3ZWU4NWQ5dzgwankyNXFzNWxmaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ri5NmFinTTcot706lV/giphy.gif) | ![](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcWF6ZmJuYzVhYXZheXFueGpmdXF1czZ5dWdmNThkY3VseWNlbzlwYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/aQLVHv6shNHSoFJQ0N/giphy.gif) |

## Installation

In the `pubspec.yaml` of your flutter project, add the following dependency:

``` yaml
dependencies:
  ...
  good_scanner_overlay: ^0.1.0
```

## example

``` dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
            borderColor: Colors.blue,
            goodScannerAnimation: GoodScannerAnimation.center,
            goodScannerOverlayBackground: GoodScannerOverlayBackground.center,
            goodScannerBorder: GoodScannerBorder.none,
          ),
        ],
      ),
    );
  }
}


```

### Thank you for the support!