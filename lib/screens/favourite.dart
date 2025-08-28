import 'package:azkary/core/models/azkar_model.dart';
import 'package:azkary/core/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/themes/color_app.dart';
import '../core/themes/styles.dart';

class Favourite extends StatefulWidget {
  const Favourite({
    super.key,
  });

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  late List<dynamic> counters;
  @override
  void initState() {
    super.initState();
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    counters = favoriteProvider.favorites.map((item) {
      if (item.haveList == true) {
        return item.list!.map((listItem) => int.parse(listItem.count)).toList();
      } else {
        return int.parse(item.count!);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: Text(
          "المفضلة",
          style: Styles.textStyle24,
        ),
        centerTitle: true,
      ),
      body: favoriteProvider.favorites.isEmpty
          ? const Center(child: Text("لا توجد أذكار مفضلة حتى الآن."))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoriteProvider.favorites.length,
                  itemBuilder: (context, index) {
                    final item = favoriteProvider.favorites[index];
                    final isFavorite = favoriteProvider.isFavorite(item);
                    if (item.haveList == true) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(item.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            subtitle: ListView.builder(
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
                          ),
                          customContainer(
                              index: index,
                              itemCount: item.list![0].count,
                              haveList: true,
                              item: item,
                              favorite: isFavorite,
                              favoriteProvider: favoriteProvider)
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
                          customContainer(
                              itemCount: item.count!,
                              index: index,
                              haveList: false,
                              item: item,
                              favorite: isFavorite,
                              favoriteProvider: favoriteProvider)
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
    );
  }

  Widget customContainer(
      {required int index,
      required String itemCount,
      required bool haveList,
      required AzkarList item,
      required bool favorite,
      required FavoriteProvider favoriteProvider}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (haveList) {
            if (counters[index][0] > 0) {
              counters[index][0]--;
            }
          } else {
            if (counters[index] > 0) {
              counters[index]--;
            }
          }
        });
      },
      child: Container(
        height: 100,
        width: 350,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (haveList ? counters[index][0] : counters[index]) > 0
              ? ColorApp.primaryColor
              : Colors.brown.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          favoriteProvider.removeFromFavorites(item);
                          counters.removeAt(index);
                          print('$counters');
                        });
                      },
                      child: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        size: 22,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Text(
              '${haveList ? counters[index][0] : counters[index]}',
              style: const TextStyle(fontSize: 26, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemCount,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (haveList) {
                          counters[index][0] = int.parse(itemCount);
                        } else {
                          counters[index] = int.parse(itemCount);
                        }
                      });
                    },
                    child: const Icon(Icons.refresh,
                        size: 22, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
