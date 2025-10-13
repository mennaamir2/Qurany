import 'package:azkary/screens/azkar/azkar_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/azkar_provider.dart';
import '../../core/themes/color_app.dart';
import '../../core/themes/styles.dart';

class Azkarr extends StatelessWidget {
  const Azkarr({super.key});
  @override
  Widget build(BuildContext context) {
    final azkarProvider = Provider.of<AzkarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: Text(
          'الأذكار',
          style: Styles.textStyle24,
        ),
        centerTitle: true,
      ),
      body: azkarProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: azkarProvider.azkar!.allAzkar.length,
              itemBuilder: (context, index) {
                final zekr = azkarProvider.azkar!.allAzkar[index];
                return Card(
                  child: ListTile(
                    title: Center(
                        child: Text(
                      zekr.title,
                      style: const TextStyle(fontSize: 22),
                    )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AzkarDetailsScreen(
                            zekr: zekr,
                          ),
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
