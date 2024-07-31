import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/presentation/blocs/order/order_bloc.dart';
import 'package:guruku_student/presentation/pages/choose_payment/screens/choose_payment_page.dart';
import 'package:guruku_student/presentation/pages/packages/widgets/button_order_packages.dart';
import 'package:location/location.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailOrderPackagesContent extends StatefulWidget {
  final Packages data;
  final String selectedTime;

  const DetailOrderPackagesContent({
    super.key,
    required this.data,
    required this.selectedTime,
  });

  @override
  State<DetailOrderPackagesContent> createState() =>
      _DetailOrderPackagesContentState();
}

class _DetailOrderPackagesContentState
    extends State<DetailOrderPackagesContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  Location location = Location();
  String _selectedPaymentMethod = 'Transfer Bank - Bank BNI';
  String _paymentType = 'bank_transfer';
  String _bankVa = 'bni';

  // late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // late LocationData _locationData;
  double? _latitude;
  double? _longitude;

  Future<void> _selectPaymentMethod() async {
    final selectedMethod = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ChoosePaymentPage();
        },
      ),
    );
    if (selectedMethod != null) {
      setState(() {
        _selectedPaymentMethod =
            selectedMethod['name'] ?? _selectedPaymentMethod;
        _paymentType = selectedMethod['paymentType'] ?? _paymentType;
        _bankVa = selectedMethod['bankVa'] ?? _bankVa;
      });
    }
  }

  void _order() {
    int price = int.parse(widget.data.price.toString()) + 6500;

    context.read<OrderBloc>().add(
          DoOrderPackages(
            onBehalf: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            total: price,
            paymentType: _paymentType,
            bankVa: _bankVa,
            packageId: widget.data.id,
            idTeacher: 61,
            address: _addressController.text,
            lat: _latitude?.toString() ?? '',
            lon: _longitude?.toString() ?? '',
            time: widget.selectedTime,
            mapel: "MATEMATIKA",
          ),
        );
  }

  void _submit() {
    if (_orderFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _order();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.stateOrderPackages == RequestStateOrderPackages.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    'Gagal Membuat Order',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.stateOrderPackages == RequestStateOrderPackages.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil Order',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _orderFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Id Paket : ${widget.data.id} ",
                      style: AppTextStyle.body3.setRegular()),
                  Text("Id Guru : ${widget.data.teacher!.id} ",
                      style: AppTextStyle.body3.setRegular()),
                  Text("Nama Paket : ${widget.data.name} ",
                      style: AppTextStyle.body3.setRegular()),
                  Text("Pertemuan : ${widget.data.sessions} Kali",
                      style: AppTextStyle.body3.setRegular()),
                  Text("Durasi : ${widget.data.duration} Jam",
                      style: AppTextStyle.body3.setRegular()),
                  Text("Harga : Rp.${widget.data.price} ",
                      style: AppTextStyle.body3.setRegular()),
                  Row(
                    children: [
                      Text("Hari Pertemuan : ",
                          style: AppTextStyle.body3.setRegular()),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: widget.data.day != null &&
                                widget.data.day!.isNotEmpty
                            ? Wrap(
                                direction: Axis.horizontal,
                                spacing: 8.0,
                                children: widget.data.day!.map((type) {
                                  return Text(
                                    type,
                                    style: AppTextStyle.body3.setRegular(),
                                  );
                                }).toList(),
                              )
                            : Text(
                                "No teaching types available",
                                style: AppTextStyle.body3.setSemiBold().copyWith(
                                      color: AppColors.primary.pr13,
                                    ),
                              ),
                      ),
                    ],
                  ),
                  Text("Jam Pertemuan : ${widget.selectedTime} ",
                      style: AppTextStyle.body3.setRegular()),
                  const SizedBox(height: 8),
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: _addressController,
                    googleAPIKey:
                        "AIzaSyCrwJlZ6WKybOec-vLvtHzb2AHL3sLwso0", // Ganti dengan kunci API Anda
                    inputDecoration: const InputDecoration(
                      hintText: "Cari tempat...",
                    ),
                    countries: const ["id"], // Sesuaikan dengan kode negara Anda
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (prediction) async {
                      // Mengambil detail tempat menggunakan prediksi
                      List<geo.Location> locations = await geo
                          .locationFromAddress(prediction.description ?? '');
                      if (locations.isNotEmpty) {
                        setState(() {
                          _latitude = locations[0].latitude;
                          _longitude = locations[0].longitude;
                        });
                      }
                    },
                    itemClick: (prediction) async {
                      // Saat pengguna memilih item dari daftar, dapatkan detail lokasi
                      List<geo.Location> locations = await geo
                          .locationFromAddress(prediction.description ?? '');
                      if (locations.isNotEmpty) {
                        setState(() {
                          _latitude = locations[0].latitude;
                          _longitude = locations[0].longitude;
                          _addressController.text = prediction.description ?? '';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Masukan nama . . .',
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Masukan email . . .',
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong!';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Email tidak valid!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Masukan nomor hp . . .',
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No Hp tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.payment, color: pr13),
                            const SizedBox(width: 8),
                            Text(
                              'Metode Pembayaran',
                              style: AppTextStyle.body3.setMedium(),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: _selectPaymentMethod,
                              child: Text(
                                'Pilih Metode >',
                                style: AppTextStyle.body3.setMedium(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _selectedPaymentMethod,
                            style: AppTextStyle.body3.setSemiBold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonOrderPackages(onPressed: _submit, title: 'Pesan Paket')
                ],
              ),
            ),
          ),
        ));
  }
}
