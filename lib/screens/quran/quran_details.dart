import 'package:azkary/core/models/quran_model.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class QuranDetails extends StatelessWidget {
  const QuranDetails({super.key, required this.quran});
  final Quran quran;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(quran.name,
              style: const TextStyle(color: ColorApp.secondaryColor)),
          backgroundColor: ColorApp.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final ayah = quran.ayahs[index];
              if (ayah.text.contains("﻿")) {
                return const SizedBox.shrink();
              }
              return Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${ayah.text}  (${ayah.numberInSurah})",
                  style: const TextStyle(fontSize: 22),
                ),
              ));
            },
            itemCount: quran.ayahs.length,
          ),
        ));
  }
}
