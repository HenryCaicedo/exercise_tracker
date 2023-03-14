import 'package:flutter/material.dart';
import '../widgets/segment_list_widget.dart';

class SegmentsTab extends StatelessWidget {
  const SegmentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SegmentListWidget(),
    );
  }
}
