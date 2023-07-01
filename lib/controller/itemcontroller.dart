import 'dart:convert';

import 'package:get/state_manager.dart';

class Itemlist extends GetxController {
  var itemList = [].obs;
  add(itemlist) {
    print("dddddddddddddddddd");
    print(itemlist);

    final jsonList = itemlist.map((item) => jsonEncode(item)).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    String nValue = '';
    String cValue = '';
    String rValue = '';
    List<String> parts = itemlist.split(',');

    for (String part in parts) {
      if (part.startsWith('n:')) {
        nValue = part.substring(2); // Remove the prefix 'n:'
      } else if (part.startsWith('c:')) {
        cValue = part.substring(2); // Remove the prefix 'c:'
      } else if (part.startsWith('r:')) {
        rValue = part.substring(2); // Remove the prefix 'r:'
      }
    }
    var des = {};
    des["name"] = nValue;
    des["code"] = cValue;
    des["rate"] = rValue;
    des["qty"] = 1;
    itemList.add(des);
    print("clclclclclclclc");
    print(itemList);
  }
}
