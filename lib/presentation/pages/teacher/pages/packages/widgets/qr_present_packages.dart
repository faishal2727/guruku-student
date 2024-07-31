// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class QrPresentPackages extends StatefulWidget {
  const QrPresentPackages({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrPresentPackagesState();
}
class _QrPresentPackagesState extends State<QrPresentPackages> {
  bool isLoading = false;

  Barcode? result;
  String orderId = '';
  String packageId = '';
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _update() {
    final int? orderIdInt = int.tryParse(orderId);
    final int? packageIdInt = int.tryParse(packageId);
    if (orderIdInt != null && packageIdInt != null) {
      context.read<OrderTeacherBloc>().add(OnUpdatePresentPackage(orderIdInt, packageIdInt, "Hadir"));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Order ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Package Present"),
      ),
      body: BlocListener<OrderTeacherBloc, OrderTeacherState>(
        listener: (context, state) {
          if (state.pac == ReqPresentPac.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    "Gagal",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.pac == ReqPresentPac.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Column(
          children: <Widget>[
            Expanded(flex: 3, child: _buildQrView(context)),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text('Order Id: $orderId'),
                  Text('Package Id: $packageId'),
                  if (result != null)
                    Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Silahkan Scan QR'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006FD4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _update,
                    child: Text(
                      'Absen Sekarang',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006FD4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return Text(
                              'Flash: ${snapshot.data}',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006FD4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        child: FutureBuilder(
                          future: controller?.getCameraInfo(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return Text(
                                'Camera facing ${describeEnum(snapshot.data!)}',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                              );
                            } else {
                              return const Text('loading');
                            }
                          },
                        )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006FD4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await controller?.pauseCamera();
                        },
                        child: Text(
                          'pause',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006FD4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        child: Text(
                          'resume',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return Stack(alignment: Alignment.center, children: [
      QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
        ),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
      if (isLoading) const CircularProgressIndicator(),
    ]);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      isLoading = true;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        isLoading = false;
        final extractedIds = _extractIds(result!.code);
        orderId = extractedIds['orderId'] ?? '';
        packageId = extractedIds['packageId'] ?? '';
      });
    });
  }

  Map<String, String?> _extractIds(String? data) {
    final orderIdRegex = RegExp(r'Order Id: (\d+)');
    final packageIdRegex = RegExp(r'Package Id: (\d+)');

    final orderIdMatch = orderIdRegex.firstMatch(data ?? '');
    final packageIdMatch = packageIdRegex.firstMatch(data ?? '');

    return {
      'orderId': orderIdMatch?.group(1),
      'packageId': packageIdMatch?.group(1),
    };
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}