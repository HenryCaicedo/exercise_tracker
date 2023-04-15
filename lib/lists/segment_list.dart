import 'package:flutter/material.dart';

class Segmento {
  final String id;
  final String userId;
  final String name;
  final String type;
  final double distance;

  Segmento({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.distance,
  });
}

List<Segmento> segments = [
  Segmento(
      id: '1',
      userId: 'user1',
      name: 'Segmento 1',
      type: 'Ciclismo',
      distance: 10.5),
  Segmento(
      id: '2',
      userId: 'user2',
      name: 'Segmento 2',
      type: 'Trote',
      distance: 5.0),
  Segmento(
      id: '3',
      userId: 'user1',
      name: 'Segmento 3',
      type: 'Ciclismo',
      distance: 8.2),
  Segmento(
      id: '4',
      userId: 'user2',
      name: 'Segmento 4',
      type: 'Trote',
      distance: 2.7),
  Segmento(
      id: '5',
      userId: 'user1',
      name: 'Segmento 5',
      type: 'Ciclismo',
      distance: 12.3),
  Segmento(
      id: '6',
      userId: 'user1',
      name: 'Segmento 6',
      type: 'Ciclismo',
      distance: 12.2),
  Segmento(
      id: '7',
      userId: 'user1',
      name: 'Segmento 7',
      type: 'Ciclismo',
      distance: 12.2),
];

void addSegment(Segmento segmento) {
  segments.insert(0, segmento);
}
