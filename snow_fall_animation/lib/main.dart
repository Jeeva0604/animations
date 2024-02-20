///Snow Animation
library;

// // import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class Snowflake {
  double x;
  double y;
  double size;
  double fallSpeed;

  Snowflake({
    required this.x,
    required this.y,
    required this.size,
    required this.fallSpeed,
  });
}

class SnowfallAnimation extends StatefulWidget {
  const SnowfallAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SnowfallAnimationState createState() => _SnowfallAnimationState();
}

class _SnowfallAnimationState extends State<SnowfallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> _snowflakes;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _snowflakes = List.generate(
      100,
      (index) => Snowflake(
        x: Random().nextDouble() * MediaQuery.of(context).size.width,
        y: Random().nextDouble() * MediaQuery.of(context).size.height,
        size: Random().nextDouble() * 10 + 5,
        fallSpeed: Random().nextDouble() * 2 + 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/winter.jpg"),
          fit: BoxFit.cover,
        )),
        height: size.height,
        width: size.width,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            _updateSnowflakes();
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: SnowfallPainter(_snowflakes),
            );
          },
        ),
      ),
    );
  }

  void _updateSnowflakes() {
    for (var snowflake in _snowflakes) {
      snowflake.y += snowflake.fallSpeed;

      if (snowflake.y > MediaQuery.of(context).size.height) {
        snowflake.y = 0;
        snowflake.x = Random().nextDouble() * MediaQuery.of(context).size.width;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SnowfallPainter extends CustomPainter {
  final List<Snowflake> snowflakes;

  SnowfallPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var snowflake in snowflakes) {
      canvas.drawCircle(
        Offset(snowflake.x, snowflake.y),
        snowflake.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnowfallAnimation(),
    );
  }
}

///Snow Flake Animation

// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class Photo {
//   double x;
//   double y;
//   double size;
//   double fallSpeed;
//   Image image;
//
//   Photo({
//     required this.x,
//     required this.y,
//     required this.size,
//     required this.fallSpeed,
//     required this.image,
//   });
// }
//
// class FallingPhotoAnimation extends StatefulWidget {
//   const FallingPhotoAnimation({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _FallingPhotoAnimationState createState() => _FallingPhotoAnimationState();
// }
//
// class _FallingPhotoAnimationState extends State<FallingPhotoAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late List<Photo> _photos;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 10),
//     )..repeat();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _photos = List.generate(
//       50, // Reduce the number of falling photos
//       (index) => Photo(
//         x: Random().nextDouble() * MediaQuery.of(context).size.width,
//         y: Random().nextDouble() * MediaQuery.of(context).size.height,
//         size: Random().nextDouble() * 10 + 20,
//         fallSpeed: Random().nextDouble() * 3 + 1,
//         image: Image.asset(
//           'assets/snowflake.png',
//           width: 30,
//           height: 30,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage("assets/winter.jpg"),
//           fit: BoxFit.cover,
//         )),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: RepaintBoundary(
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               _updatePhotos();
//               return Stack(
//                 children: _photos
//                     .map((photo) => Positioned(
//                           left: photo.x,
//                           top: photo.y,
//                           child: photo.image,
//                         ))
//                     .toList(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _updatePhotos() {
//     for (var photo in _photos) {
//       photo.y += photo.fallSpeed;
//
//       if (photo.y > MediaQuery.of(context).size.height) {
//         photo.y = 0;
//         photo.x = Random().nextDouble() * MediaQuery.of(context).size.width;
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FallingPhotoAnimation(),
//     );
//   }
// }
