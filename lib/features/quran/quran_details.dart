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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                quran.ayahs.first.numberInSurah == 0
                    ? quran.ayahs.first.text
                    : "${quran.ayahs.first.text} ﴿${quran.ayahs.first.numberInSurah}﴾",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, height: 2),
              ),
              Text(
                quran.ayahs.skip(1).map((ayah) {
                  return "${ayah.text} ﴿${ayah.numberInSurah}﴾";
                }).join(" "),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 24, height: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
