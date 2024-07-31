// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/presentation/blocs/packages/packages_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/widgets/button_update_packages.dart';
import 'package:intl/intl.dart';

class UpdatePackagesPage extends StatefulWidget {
  static const ROUTE_NAME = "/update-package";
  final Packages data;
  const UpdatePackagesPage({
    super.key,
    required this.data,
  });

  @override
  State<UpdatePackagesPage> createState() => _UpdatePackagesPageState();
}

class _UpdatePackagesPageState extends State<UpdatePackagesPage> {
  final GlobalKey<FormState> _postFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Map<String, bool> daysOfWeek = {
    "Senin": false,
    "Selasa": false,
    "Rabu": false,
    "Kamis": false,
    "Jumat": false,
    "Sabtu": false,
    "Minggu": false,
  };
  List<TextEditingController> timeControllers = [];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.data.name ?? '';
    descController.text = widget.data.desc ?? '';
    priceController.text = widget.data.price?.toString() ?? '0';
    durationController.text = widget.data.duration?.toString() ?? '0';

    // Initialize selected days
    if (widget.data.day != null) {
      for (var day in widget.data.day!) {
        daysOfWeek[day] = true;
      }
    }

    // Initialize time controllers
    if (widget.data.time != null) {
      for (var time in widget.data.time!) {
        timeControllers.add(TextEditingController(text: time));
      }
    }

    Future.microtask(() {
      context.read<PackagesBloc>().add(OnDetailPackagesEvent(widget.data.id));
    });
  }

  void _addTimeInput() {
    if (timeControllers.length < 7) {
      setState(() {
        timeControllers.add(TextEditingController());
      });
    }
  }

  void _removeTimeInput(int index) {
    setState(() {
      timeControllers[index].dispose();
      timeControllers.removeAt(index);
    });
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedTime = DateFormat.Hm()
            .format(DateTime(0, 0, 0, picked.hour, picked.minute));
        timeControllers[index].text = formattedTime;
      });
    }
  }

  List<String> getSelectedDays(Map<String, bool> days) {
    return days.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  void _updatePackages() {
    int duration = int.parse(durationController.text);
    int price = int.parse(priceController.text);
    List<String> selectedDays = getSelectedDays(daysOfWeek);

    context.read<PackagesBloc>().add(
          OnUpdateDataPackages(
            id: 4,
            duration: duration,
            name: nameController.text,
            price: price,
            desc: descController.text,
            day: selectedDays,
            time: timeControllers.map((controller) => controller.text).toList(),
          ),
        );
  }

  void _submit() {
    if (_postFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _updatePackages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<PackagesBloc, PackagesState>(
        listener: (context, state) {
          if (state.updateState == RequestStateUpdatePackages.error) {
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
          } else if (state.updateState == RequestStateUpdatePackages.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _postFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormField(
                          labelText: "Nama Paket",
                          controller: nameController,
                          hintText: 'Masukan Nama Paket . . .',
                          lable: 'Nama Paket',
                        ),
                        const SizedBox(height: 8),
                        MyTextFormField(
                          labelText: "Durasi Paket",
                          controller: durationController,
                          keyboardType: TextInputType.number,
                          hintText: 'Masukan Durasi Paket . . .',
                          lable: 'Durasi Paket',
                        ),
                        const SizedBox(height: 8),
                        MyTextFormField(
                          labelText: "Harga Paket",
                          controller: priceController,
                          hintText: 'Masukan Harga Paket . . .',
                          lable: 'Harga Paket',
                        ),
                        const SizedBox(height: 8),
                        MyTextFormField(
                          labelText: "Deskripsi Paket",
                          controller: descController,
                          hintText: 'Masukan Deskripsi Paket . . .',
                          lable: 'Deskripsi Paket',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pilih Hari:',
                          style: AppTextStyle.body3.setSemiBold(),
                        ),
                        Column(
                          children: daysOfWeek.keys.map((String key) {
                            return CheckboxListTile(
                              title: Text(key),
                              value: daysOfWeek[key],
                              onChanged: (bool? value) {
                                setState(() {
                                  daysOfWeek[key] = value ?? false;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pilih Jam:',
                          style: AppTextStyle.body3.setSemiBold(),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children:
                              timeControllers.asMap().entries.map((entry) {
                            int index = entry.key;
                            TextEditingController controller = entry.value;
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectTime(context, index),
                                    child: AbsorbPointer(
                                      child: MyTextFormField(
                                        labelText: "Jam ${index + 1}",
                                        controller: controller,
                                        hintText: 'Masukan Jam . . .',
                                        lable: 'Jam ${index + 1}',
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () => _removeTimeInput(index),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        if (timeControllers.length < 7)
                          TextButton(
                            onPressed: _addTimeInput,
                            child: const Text('Tambah Jam'),
                          ),
                      ],
                    ),
                  ),
                  Divider(thickness: 8, color: Colors.grey.shade100),
                  ButtonUpdatePackages(onPressed: _submit, title: 'Edit')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
