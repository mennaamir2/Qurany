import 'package:azkary/core/providers/favorite_provider.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:azkary/core/themes/styles.dart';
import 'package:azkary/screens/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<dynamic> counters = []; // ⬅️ لتخزين عداد كل عنصر

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    final favorites = favoriteProvider.favorites;

    // نهيئ العدادات حسب نوع العنصر
    counters = favorites.map((item) {
      if (item.haveList == true) {
        // لو العنصر يحتوي على قائمة
        return item.list!.map((listItem) => int.parse(listItem.count)).toList(); // ممكن تعمليها List لو فيه أكثر من ذكر
      } else {
        // لو عنصر عادي
        return int.parse(item.count!);
      }
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoriteProvider.favorites;
    return  Scaffold(
        appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: Text(
          "المفضلة",
          style: Styles.textStyle24,
        ),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          'لا توجد أذكار في المفضلة بعد',
          style: TextStyle(fontSize: 18),
        ),
      )
          : SingleChildScrollView(
            child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
              final item = favorites[index];
              final isFavorite = favoriteProvider.isFavorite(item);
              if (index >= counters.length) return const SizedBox();
              if (item.haveList == true) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(item.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        children: [
                          ListView.builder(
                            itemBuilder: (context, innerIndex) {
                              final listItem = item.list![innerIndex];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(listItem.zekr,
                                        style: const TextStyle(fontSize: 20)),
                                  ),
                                ],
                              );
                            },
                            itemCount: item.list!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      index: index,
                      itemCount: item.list![0].count,
                      haveList: true,
                      item: item,
                      favorite: isFavorite,
                      favoriteProvider: favoriteProvider,
                      counterValue: counters[index],
                      onTap: () {
                        setState(() {
                          if (counters[index][0] > 0) {
                            counters[index][0]--;
                          }
                        });
                      },
                      onReset: () {
                        setState(() {
                          counters[index][0] = int.parse(item.list![0].count);
              
                        });
                      },
                    )
                  ],
                );
              } else {
                return Column(
                  children: [
                    ListTile(
                      title: Text(item.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        children: [
                          Text(item.zekr!,
                              style: const TextStyle(fontSize: 20)),
                          if (item.description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                item.description!,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      itemCount: item.count!,
                      index: index,
                      haveList: false,
                      item: item,
                      favorite: isFavorite,
                      favoriteProvider: favoriteProvider,
                      counterValue: counters[index],
                      onTap: () {
                        setState(() {
              
                          if (counters[index] > 0) {
                            counters[index]--;
                          }
              
                        });
                      },
                      onReset: () {
                        setState(() {
              
                          counters[index] = int.parse(item.count!);
              
                        });
                      },)
                  ],
                );
              }
                      },
                    ),
            ),
          ),
    );
  }
}