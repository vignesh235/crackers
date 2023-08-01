import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controller/itemcontroller.dart';
import '../utils/colors.dart';

class qr extends StatefulWidget {
  const qr({super.key});

  @override
  State<qr> createState() => _qrState();
}

class _qrState extends State<qr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final Itemlist itemlist = Get.put(Itemlist());
  Barcode? result;
  QRViewController? controller;
  String username = '';
  var itemlist_;

  // Future<void> user() async {
  //   SharedPreferences token = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = token.getString('full_name').toString();
  //   });
  // }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.scaffoldBackgroundColor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: [
          //           CircleAvatar(
          //             backgroundColor: AppColors.backgroundColor,
          //             radius: 45,
          //             child: IconButton(
          //               icon: Icon(
          //                 PhosphorIcons.flashlight,
          //                 color: AppColors.iconcolor,
          //               ),
          //               onPressed: () async {
          //                 await controller!.toggleFlash();
          //               },
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //             'Flash ',
          //             style: TextStyle(
          //               color: AppColors.primaryColor,
          //               fontSize: 15,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result!.code!.isNotEmpty) {
          setState(() {
            itemlist_ = result!.code.toString();
          });
          controller.pauseCamera();

          print(itemlist_);
          Get.toNamed('/Homepage');

          itemlist.add(itemlist_);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
