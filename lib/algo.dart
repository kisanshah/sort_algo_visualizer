import 'dart:async';
import 'dart:math' as math;
import 'package:algo_visualizer/model.dart';
import 'package:flutter/material.dart';

class Algo {
  List<Item> itemList = [];
  final sortController = StreamController<List<Item>>();
  Stream<List<Item>> get sortStream => sortController.stream;
  StreamSink<List<Item>> get sortSink => sortController.sink;

  dispose() {
    sortController.close();
  }
}
