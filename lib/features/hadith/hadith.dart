import 'package:azkary/core/providers/hadith_provider.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:azkary/core/themes/styles.dart';
import 'package:azkary/features/hadith/hadith_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hadith extends StatelessWidget {
  const Hadith({super.key});

  @override
  Widget build(BuildContext context) {
    final hadithProvider = Provider.of<HadithProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: Text(
          'احاديث الأربعون النووية',
          style: Styles.textStyle24,
        ),
        centerTitle: true,
      ),
      body: hadithProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                final hadith = hadithProvider.hadith![index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          hadith.hadith,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(bottom: 10, top: 5, left: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HadithDetails(
                                  description: hadith.description,
                                ),
                              ),
                            );
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(ColorApp.primaryColor),
                          ),
                          child: Text(
                            'التفسير',
                            style: Styles.textStyle15,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: hadithProvider.hadith!.length),
    );
  }
}
