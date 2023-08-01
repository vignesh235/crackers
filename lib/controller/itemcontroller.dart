import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import '../utils/colors.dart';

class Itemlist extends GetxController {
  var itemList = [].obs;
  List resultList = [];
  var customerList_ = [].obs;
  @override
  void onInit() {
    customerList();
    super.onInit();
  }

  add(itemlist_) {
    List list1 = jsonDecode(itemlist_);
    print("ooooooooooooooo");
    print(list1);
    if (resultList.isNotEmpty) {
      print("not empty");
      int minLength =
          resultList.length < list1.length ? resultList.length : list1.length;
      for (int i = 0; i < minLength; i++) {
        print(list1[i]["item_name"]);
        print(resultList[i]["item_name"]);
        if (resultList[i]["item_name"] == list1[i]["item_name"]) {
          print(resultList[i]["qty"]);
          resultList[i]["qty"] = resultList[i]["qty"] + 1;
          print(resultList);
        } else {
          print("ddddddddddddddddddddddddddddddddddddddd");
          resultList.add(list1[i]);
          print(resultList);
        }
      }
    } else {
      resultList.addAll(list1);
      print("xxxxxxxxxxx");
      print(resultList);
    }
    itemList.value = resultList;
  }

  qty(itemlist) {
    print(itemlist);
  }

  Future<void> customerList() async {
    print("psdssjfhkdkvvvsvssfhdfdfdfdsfhosdi");
    try {
      var response = await http.get(
        Uri.parse(
            "https://cambridge-pleased-completion-success.trycloudflare.com/api/method/retail_demo.retail_demo.utils.py.api.customer_list"),
      );
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(response.body);
      var temp = jsonDecode(response.body)["Customer"];
      customerList_.value = temp;
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> salesinvoice(customerName, itemList) async {
    print("[][][][][][][][][][][]]");
    try {
      var response = await http.post(
        Uri.parse(
            'https://cambridge-pleased-completion-success.trycloudflare.com/api/method/retail_demo.retail_demo.utils.py.api.sales_invoice'),
        body: {
          'cus_name': customerName,
          'items': (jsonEncode(itemList)),
        },
      );
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          jsonDecode(response.body)['message'].toString(),
          icon: const Icon(
            PhosphorIcons.check_circle_fill,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.textcolour,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
