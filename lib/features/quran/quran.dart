import 'package:azkary/core/providers/quran_provider.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:azkary/core/themes/styles.dart';
import 'package:azkary/features/quran/quran_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String query = '';

  void _filterQuran(String value) {
    setState(() {
      query = value;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranProvider>(context);
    final quranList = quranProvider.quran ?? [];

    // فلترة السور حسب البحث
    final filteredQuran = quranList.where((surah) {
      return surah.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _filterQuran,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن السورة ...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredQuran.length,
                    itemBuilder: (context, index) {
                      final quran = filteredQuran[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            '(${quran.number})  ${quran.name}',
                            style: const TextStyle(fontSize: 22),
                          ),
                          onTap: () {
                            _searchFocusNode.unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QuranDetails(quran: quran),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
