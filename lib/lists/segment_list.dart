import 'package:flutter/material.dart';

class Segmento {
  final String name;
  final String type;
  final double distance;

  Segmento({
    required this.name,
    required this.type,
    required this.distance,
  });
}

List<Segmento> segments = [
  Segmento(name: 'Segmento 1', type: 'Ciclismo', distance: 10.5),
  Segmento(name: 'Segmento 2', type: 'Trote', distance: 5.0),
  Segmento(name: 'Segmento 3', type: 'Ciclismo', distance: 8.2),
  Segmento(name: 'Segmento 4', type: 'Trote', distance: 2.7),
  Segmento(name: 'Segmento 5', type: 'Ciclismo', distance: 12.3),
  Segmento(name: 'Segmento 6', type: 'Ciclismo', distance: 12.2),
  Segmento(name: 'Segmento 7', type: 'Ciclismo', distance: 12.2),
];

void addSegment(Segmento segmento) {
  segments.insert(0, segmento);
}
