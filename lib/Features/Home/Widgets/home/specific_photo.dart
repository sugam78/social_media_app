import 'package:flutter/material.dart';

class SpecificPhoto extends StatelessWidget {
  final String imageUrl;
  const SpecificPhoto({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      child: Image.network(imageUrl),
    );
  }
}
