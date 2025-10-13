import 'package:azkary/core/providers/quran_provider.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:azkary/core/themes/styles.dart';
import 'package:azkary/features/quran/quran_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quran extends StatelessWidget {
  const Quran({super.key});

  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: Text(
          'القرآن',
          style: Styles.textStyle24,
        ),
        centerTitle: true,
      ),
      body: quranProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: quranProvider.quran!.length,
              itemBuilder: (context, index) {
                final quran = quranProvider.quran![index];
                return Card(
                  child: ListTile(
                    title: Text(
                      '(${quran.number})  ${quran.name}',
                      style: const TextStyle(fontSize: 22),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuranDetails(quran: quran),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
