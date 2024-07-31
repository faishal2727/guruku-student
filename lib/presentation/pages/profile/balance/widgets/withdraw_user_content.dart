// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/blocs/withdraw/withdraw_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/balance/widgets/button_req_wd_student.dart';

class WithdrawUserContent extends StatefulWidget {
  final DetailProfileResponse profile;

  const WithdrawUserContent({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  _WithdrawUserContentState createState() => _WithdrawUserContentState();
}

class _WithdrawUserContentState extends State<WithdrawUserContent> {
  final TextEditingController _ammountController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final GlobalKey<FormState> _reqWdFormKey = GlobalKey<FormState>();
  bool _isChecked = false;
  String? _errorText;
  String? _selectedBank;

  void _onCheckboxChanged(bool? newValue) {
    setState(() {
      _isChecked = newValue ?? false;
      if (_isChecked) {
        _ammountController.text = widget.profile.balanceUser.toString();
      } else {
        _ammountController.clear();
      }
      _validateInput(_ammountController.text);
    });
  }

  void _validateInput(String value) {
    final numValue = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), ''));
    setState(() {
      if (numValue == null || numValue < 10000) {
        _errorText = 'Minimum amount is 10,000';
      } else {
        _errorText = null;
      }
    });
  }

  void _reqWd() {
    context.read<WithdrawBloc>().add(
          ReqWd(
            amount: _ammountController.text,
            bankName: _selectedBank.toString(),
            noBank: _accountNumberController.text,
            idTeacher: 0,
          ),
        );
  }

  void _submit() {
    if (_reqWdFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _reqWd();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Harap lengkapi semua kolom yang diperlukan.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawBloc, WithdrawState>(
      listener: (context, state) {
        if (state.stateWd == RequestStateWd.error) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red[400],
              ),
            );
        } else if (state.stateWd == RequestStateWd.loaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Form(
        key: _reqWdFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Jumlah Penarikan Saldo',
                    style: AppTextStyle.body2.setMedium(),
                  ),
                  TextFormField(
                    controller: _ammountController,
                    keyboardType: TextInputType.number,
                    style: AppTextStyle.heading3,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Rp.',
                            style: AppTextStyle.heading3
                                .setMedium()
                                .copyWith(color: pr13)),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                      errorText: _errorText,
                    ),
                    onChanged: _validateInput,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah penarikan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedBank,
                    hint: Text('Pilih Bank',
                        style: AppTextStyle.body2.setMedium()),
                    items: ['BNI', 'BRI', 'BCA'].map((String bank) {
                      return DropdownMenuItem<String>(
                        value: bank,
                        child: Text(bank),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBank = newValue;
                        if (_selectedBank == null) {
                          _accountNumberController.clear();
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih salah satu bank';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_selectedBank != null)
                    TextFormField(
                      controller: _accountNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor rekening tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nomor Rekening',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Tarik saldo saat ini Rp. ${widget.profile.balanceUser}',
                        style: AppTextStyle.body3
                            .setMedium()
                            .copyWith(color: pr13),
                      ),
                      Checkbox(
                        value: _isChecked,
                        onChanged: _onCheckboxChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonReqWdStudent(onPressed: _submit, title: 'Kirim'),
            )
          ],
        ),
      ),
    );
  }
}
