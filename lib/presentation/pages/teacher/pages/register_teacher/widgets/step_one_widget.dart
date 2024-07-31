import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class StepOneWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController gelarController;
  final TextEditingController jurusanController;
  final TextEditingController tahunLulusController;
  final String? selectedEducation;
  final TextEditingController educationDetailController;
  final ValueChanged<String?> onEducationChanged;

  const StepOneWidget({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.gelarController,
    required this.jurusanController,
    required this.tahunLulusController,
    required this.selectedEducation,
    required this.educationDetailController,
    required this.onEducationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Lengkap 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama lengkap kamu ...',
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
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan email kamu ...',
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
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No.Hp 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Masukkan no hp kamu ...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone tidak boleh kosong!';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pendidikan 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              DropdownButton<String>(
                value: selectedEducation,
                hint: const Text('Pilih pendidikan kamu ...'),
                items: ['S1', 'S2', 'S3', 'D1', 'D2', 'D3', 'D4'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onEducationChanged,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jurusan 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: jurusanController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Masukkan jurusan kamu ...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jurusan tidak boleh kosong!';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gelar 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: gelarController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Masukkan gelar kamu ...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Gelar tidak boleh kosong!';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tahun Lulus 🔅',
                style: AppTextStyle.body3.setMedium(),
              ),
              TextFormField(
                controller: tahunLulusController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Masukkan tahun lulus kamu ...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone tidak boleh kosong!';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
