import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'algo.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> listItem = [];
  var controller = Algo();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double max = MediaQuery.of(context).size.width;
    for (var i = 0; i < max / 10; i++) {
      listItem.add(Item(
          math.Random()
              .nextInt(MediaQuery.of(context).size.height.ceil() - 110)
              .ceilToDouble(),
          Colors.black));
    }

    return Scaffold(
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          bubbleSort(listItem);
        },
        child: Text('Sort'),
      ),
      body: StreamBuilder<Object>(
          stream: controller.sortStream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: ShapePainter(listItem),
              child: Container(),
            );
          }),
    );
  }

  bubbleSort(List<Item> array) async {
    int lengthOfArray = array.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (array[j].number < array[j + 1].number) {
          // Swapping using temporary variable
          double temp = array[j].number;
          array[j].number = array[j + 1].number;
          array[j + 1].number = temp;

          controller.sortSink.add(array);
        }
      }

      await Future.delayed(Duration(milliseconds: 100));
    }

    return (array);
  }
}

class ShapePainter extends CustomPainter {
  final List<Item> number;
  ShapePainter(this.number);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = number[1].color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double max = size.width;

    for (var i = 1; i < max / 10; i++) {
      paint.color = number[i].color;
      Offset startingPoint = Offset(i * 10.0, number[i].number);
      Offset endingPoint = Offset(i * 10.0, size.height);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
