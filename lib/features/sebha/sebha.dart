import 'package:flutter/material.dart';
import '../../core/themes/color_app.dart';
import '../../core/themes/styles.dart';

class Sebha extends StatefulWidget {
  const Sebha({super.key});

  @override
  State<Sebha> createState() => _SebhaState();
}

class _SebhaState extends State<Sebha> {
  late int count;
  late String tasbeehName;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tasbeehName = '';
    count = 0;
  }

  void openInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("أدخل التسبيح وعدده"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم التسبيح',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: countController,
                decoration: const InputDecoration(
                  labelText: 'عدد مرات التسبيح',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasbeehName = nameController.text;
                  count = int.tryParse(countController.text) ?? 0;
                });
                Navigator.of(context).pop();
              },
              child: const Text("إضافة"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: Text(
          "السبحة",
          style: Styles.textStyle24,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              tasbeehName.isEmpty ? 'التسبيح' : tasbeehName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (count > 0) {
                  setState(() {
                    count--;
                  });
                }
              },
              child: CircleAvatar(
                radius: 80,
                backgroundColor:
                    count == 0 ? Colors.brown.shade300 : ColorApp.primaryColor,
                child: Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: openInputDialog,
                child: const Text(
                  "أدخل التسبيح",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
