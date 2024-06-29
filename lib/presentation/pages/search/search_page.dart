// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/teacher_search/teacher_search_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-teacher';
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Cari Guru',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16),
                  onChanged: (
                    name,
                  ) {
                    context.read<TeacherSearchBloc>().add(OnQueryChanged(name));
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari Guru . . .',
                    hintStyle: TextStyle(color: AppColors.neutral.ne05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primary.pr13,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primary.pr13,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AppColors.primary.pr13,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: AppTextStyle.body3.setSemiBold(),
              ),
              BlocBuilder<TeacherSearchBloc, TeacherSearchState>(
                builder: (context, state) {
                  if (state is SearchTeacherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchTeacherHasData) {
                    final result = state.result;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final teacher = result[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: CardTeacherVertical(teacher: teacher),
                          );
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else if (state is SearchTeacherError) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          state.message,
                          key: const Key('error_message'),
                        ),
                      ),
                    );
                  } else if (state is SearchTeacherEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const EmptySection(),
                      ],
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
