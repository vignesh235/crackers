import 'dart:async';

import 'package:cracker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:searchfield/searchfield.dart';

import '../controller/itemcontroller.dart';
import '../widget/appbar.dart';
import '../widget/button.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Itemlist itemlists = Get.put(Itemlist());
  final _itemKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    print(
        "initState Calldsasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssed");
    itemlists.customerList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          tittle: 'Scan',
          actions: [
            IconButton(
              icon: Icon(
                PhosphorIcons.barcode_light,
                color: AppColors.scaffoldBackgroundColor,
              ),
              onPressed: () {
                Get.toNamed('/qrcode');
                // itemlist.add();
              },
            )
          ],
          leading: HeroIcon(
            HeroIcons.bars3BottomLeft,
            color: AppColors.scaffoldBackgroundColor,
          ),
        ),
        body: SingleChildScrollView(
            child: Obx(
          () => Column(
            children: [
              Form(
                  key: _itemKey,
                  child: SearchField(
                    controller: customercontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select customer';
                      }
                      if (!itemlists.customerList_.contains(value)) {
                        return 'customer not found';
                      }
                      return null;
                    },
                    suggestions: itemlists.customerList_
                        .map((String) => SearchFieldListItem(String))
                        .toList(),
                    suggestionState: Suggestion.expand,
                    textInputAction: TextInputAction.next,
                    marginColor: Colors.white,
                    searchStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    onSuggestionTap: (x) {
                      FocusScope.of(context).unfocus();
                    },
                    searchInputDecoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: AppColors.textcolour),
                      ),
                      labelText: "Customer *",
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                child: ListView.builder(
                  itemCount: itemlists.itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final itemlist = itemlists.itemList[index];
                    return Dismissible(
                      key: Key(itemlist['item_name']),
                      onDismissed: (direction) {
                        setState(() {
                          itemlists.itemList.removeAt(index);
                        });
                      },
                      child: Card(
                        child: ListTile(
                          leading: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              double width = constraints.maxWidth / 4.5;
                              return Image.network(
                                "https://media.istockphoto.com/id/1173422008/photo/indian-traditional-fire-crackers-with-sweet-during-diwali-festival.jpg?s=612x612&w=0&k=20&c=K9KG9nlLf19MzcaQ4iSaxvOZpccDqNR5kyA6ublQVrs=",
                                fit: BoxFit.cover,
                                width: width,
                              );
                            },
                          ),
                          subtitle: Text(
                            "${itemlist['rate']}  ₹",
                            style: TextStyle(color: AppColors.textcolour),
                          ),
                          title: Text(itemlist['item_name'].toString()),
                          trailing: SizedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (itemlist['qty'] >= 1) {
                                        itemlist['qty'] = itemlist['qty'] - 1;
                                        totalqty_ = totalqty_ - 1;
                                      }
                                      print(itemlist);
                                    });
                                  },
                                  icon: const HeroIcon(
                                    HeroIcons.minus,
                                  ),
                                ),
                                Text(totalqty_.toString()),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      itemlist['qty'] = itemlist['qty'] + 1;
                                      totalqty_ = itemlist['qty'];
                                    });
                                    print(itemlists);
                                    itemlists.qty(itemlist);
                                  },
                                  icon: const HeroIcon(
                                    HeroIcons.plus,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevateButton(
                name: 'Submit',
                onPressed: () {
                  print(itemlists.itemList.value);
                  late Timer timer;

                  timer = Timer(const Duration(seconds: 2), () {
                    customercontroller.clear();
                    itemlists.itemList.clear();
                  });
                  itemlists.salesinvoice(
                      customercontroller.text, itemlists.itemList.value);
                },
                formKey: _itemKey,
              )
            ],
          ),
        )));
  }
}
