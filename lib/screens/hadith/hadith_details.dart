import 'package:azkary/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class HadithDetails extends StatelessWidget {
  const HadithDetails({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'التفسير',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: ColorApp.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(description, style: const TextStyle(fontSize: 21)),
        ),
      ),
    );
  }
}
