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
  List<dynamic> filteredQuran = [];
  @override
  void initState() {
    super.initState();
    final quranProvider = Provider.of<QuranProvider>(context, listen: false);

    // لما البيانات تتحمل، خزنها في filteredQuran
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        filteredQuran = quranProvider.quran ?? [];
      });
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose(); // 👈 نغلقه عند التخلص
    super.dispose();
  }
  void _filterQuran(String query) {
    final quranProvider = Provider.of<QuranProvider>(context, listen: false);
    final results = quranProvider.quran!.where((surah) {
      return surah.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredQuran = results;
    });
  }
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
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: quranProvider.quran!.length,
              //       itemBuilder: (context, index) {
              //         final quran = quranProvider.quran![index];
              //         return Card(
              //           child: ListTile(
              //             title: Text(
              //               '(${quran.number})  ${quran.name}',
              //               style: const TextStyle(fontSize: 22),
              //             ),
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => QuranDetails(quran: quran),
              //                 ),
              //               );
              //             },
              //           ),
              //         );
              //       },
              //     ),
              // ),
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
                              builder: (context) => QuranDetails(quran: quran),
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
