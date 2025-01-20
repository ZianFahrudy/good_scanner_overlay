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

QR Scanner overlay with animation to be used with a stack widget.

# Preview
![image](https://github.com/ZianFahrudy/good_scanner_overlay/blob/master/assets/Screenshot_20250120-165404.png?raw=true)
## Installation

In the `pubspec.yaml` of your flutter project, add the following dependency:

``` yaml
dependencies:
  ...
  good_scanner_overlay: ^0.0.1
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
          GoodScannerOverlay(),
        ],
      ),
    );
  }
}


```

### Thank you for the support!