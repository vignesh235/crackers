import 'package:get/get.dart';

import '../view/homepage.dart';
import '../view/qrscanner.dart';

class Routes {
  static String qr = '/qrcode';
  static String homepage = '/Homepage';
}

final getpages = [
  GetPage(
    name: Routes.qr,
    page: () => const qr(),
  ),
  GetPage(
    name: Routes.homepage,
    page: () => const Homepage(),
  ),
];
