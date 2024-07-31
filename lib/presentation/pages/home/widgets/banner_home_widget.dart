import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/cubits/carousel/carousel_cubit.dart';
class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const _Content(
        svgPath: 'assets/images/pana.svg',
        title: 'Selamat Datang \ndi Guruku',
        subtitle: 'Cari guru terbaikmu dan \nraih prestasi tertinggi',
      ),
      const _Content(
        svgPath: 'http://source.unsplash.com/1000x600?laptop',
        title: 'Belajar dengan Nyaman',
        subtitle: 'Temukan kenyamanan belajar \ndengan teknologi terbaik',
      ),
    ];

    final carouselOptions = CarouselOptions(
      viewportFraction: 1,
      aspectRatio: MediaQuery.of(context).size.height /
          MediaQuery.of(context).size.width,
      autoPlay: false,
      onPageChanged: (index, _) {
        context.read<CarouselCubit>().onPageChanged(index);
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: items.length,
            itemBuilder: (context, index, realIndex) {
              final item = items[index];
              return Card(
                color: AppColors.primary.pr13,
                surfaceTintColor: AppColors.primary.pr13,
                clipBehavior: Clip.hardEdge,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: AppTextStyle.heading5
                                  .setSemiBold()
                                  .copyWith(color: AppColors.neutral.ne01),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.subtitle,
                              style: AppTextStyle.body4
                                  .setRegular()
                                  .copyWith(color: AppColors.neutral.ne01),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: SvgPicture.asset(item.svgPath))
                    ],
                  ),
                ),
              );
            },
            options: carouselOptions,
          ),
          const SizedBox(
            height: 8.0,
          ),
          _Indicator(itemCount: items.length),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.svgPath,
    required this.title,
    required this.subtitle,
  });

  final String svgPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final imageWidget = Container(
      color: Colors.red,
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        svgPath,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
      ),
    );
    return Column(
      children: [imageWidget],
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary.pr13;
    const inactiveColor = Color(0xFFCDD5DF);

    return BlocBuilder<CarouselCubit, int>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, activeIndex) {
        final items = List.generate(itemCount, (index) {
          final active = index == activeIndex;
          final dimension = active ? 8.0 : 6.0;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: dimension,
            height: dimension,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? activeColor : inactiveColor,
            ),
          );
        });

        return Wrap(
          spacing: 8,
          children: items,
        );
      },
    );
  }
}
