import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/presentation/blocs/order/order_bloc.dart';
import 'package:guruku_student/presentation/pages/choose_payment/screens/choose_payment_page.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/widgets/button_order.dart';
import 'package:location/location.dart';

class OrderContent extends StatefulWidget {
  final TeacherDetail teacher;
  final DateTime date;
  final String time;

  const OrderContent({
    Key? key,
    required this.teacher,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  String _selectedPaymentMethod = 'Transfer Bank - Bank BNI';
  String _paymentType = 'bank_transfer';
  String _bankVa = 'bni';

  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  void _order() {
    int price = int.parse(widget.teacher.price.toString());

    context.read<OrderBloc>().add(
          DoOrder(
            onBehalf: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            total: price,
            paymentType: _paymentType,
            bankVa: _bankVa,
            idTeacher: widget.teacher.id,
            meetingDate: widget.date,
            meetingTime: widget.time,
            note: _addressController.text,
          ),
        );
  }

  void _submit() {
    if (_orderFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _order();
    }
  }

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

  Future<void> _getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      _locationData.latitude!,
      _locationData.longitude!,
    );

    geo.Placemark place = placemarks[0];

    setState(() {
      _addressController.text =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Detail Pesanan',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.stateOrder == RequestStateOrder.error) {
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
          } else if (state.stateOrder == RequestStateOrder.loaded) {
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
          child: Form(
            key: _orderFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(thickness: 4, color: pr16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: false,
                        child: Text(
                          "Id Guru : ${widget.teacher.id}",
                          style: AppTextStyle.body2.setRegular(),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: pr13,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Detail Guru :",
                            style: AppTextStyle.body2.setSemiBold(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Nama Guru : ${widget.teacher.name}",
                        style: AppTextStyle.body2.setRegular(),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Mata Pelajaran : ${widget.teacher.typeTeaching} ",
                        style: AppTextStyle.body2.setRegular(),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Harga Pertemuan : Rp.${widget.teacher.price}/meet",
                        style: AppTextStyle.body2.setRegular(),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Tanggal Pertemuan : ${widget.date.toLocal().toString().split(' ')[0]}",
                        style: AppTextStyle.body2.setRegular(),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Jam Pertemuan : ${widget.time}",
                        style: AppTextStyle.body2.setRegular(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Divider(thickness: 10, color: pr16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
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
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              enabled: false,
                              maxLines: 2,
                              controller: _addressController,
                              decoration: const InputDecoration(
                                hintText: 'Masukan alamat sekarang',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Alamat tidak boleh kosong!';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: _getLocation,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: pr13,
                                ),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  size: 40,
                                  color: pr15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Divider(thickness: 10, color: pr16),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 85,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ButtonOrder(
              onPressed: _submit,
              title: 'Bayar Sekarang',
            ),
          ),
        ],
      ),
    );
  }
}
