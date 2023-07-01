import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../widget/appbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        tittle: 'Scan',
        actions: [
          IconButton(
            icon: const Icon(
              PhosphorIcons.barcode_light,
            ),
            onPressed: () {
              Get.toNamed('/qrcode');
            },
          )
        ],
        leading: const HeroIcon(HeroIcons.bars3BottomLeft),
      ),
    );
  }
}
