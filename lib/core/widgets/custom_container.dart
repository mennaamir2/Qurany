import 'package:azkary/core/models/azkar_model.dart';
import 'package:azkary/core/providers/favorite_provider.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final int index;
  final String itemCount;
  final bool haveList;
  final AzkarList item;
  final bool favorite;
  final FavoriteProvider favoriteProvider;
  final dynamic counterValue; // ممكن يكون int أو List<int>
  final VoidCallback onTap; // للعد التنازلي
  final VoidCallback onReset; // لإعادة التعيين

  const CustomContainer({
    super.key,
    required this.index,
    required this.itemCount,
    required this.haveList,
    required this.item,
    required this.favorite,
    required this.favoriteProvider,
    required this.counterValue,
    required this.onTap,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final currentValue = haveList ? counterValue[0] : counterValue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:
              currentValue > 0 ? ColorApp.primaryColor : Colors.brown.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // رقم الذكر + زر المفضلة
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
                      if (favorite) {
                        favoriteProvider.removeFromFavorites(item);
                      } else {
                        favoriteProvider.addToFavorites(item);
                      }
                    },
                    child: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // القيمة الحالية
            Text(
              '$currentValue',
              style: const TextStyle(fontSize: 26, color: Colors.white),
            ),

            // القيمة الأصلية + زر التحديث
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
                    onTap: onReset,
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
