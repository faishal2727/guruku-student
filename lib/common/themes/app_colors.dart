part of 'themes.dart';

abstract final class AppColors {
  static final PrimaryColor primary = PrimaryColor();
  static final SecondaryColor secondary = SecondaryColor();
  static final InfoColor info = InfoColor();
  static final WarningColor warning = WarningColor();
  static final SuccessColor success = SuccessColor();
  static final DangerColor danger = DangerColor();
  static final NeutralColor neutral = NeutralColor();
}

// class PrimaryColor {
//   final Color pr01 = const Color(0xFFE9F6FD);
//   final Color pr02 = const Color(0xFFD3E8F4);
//   final Color pr03 = const Color(0xFFA8CDE2);
//   final Color pr04 = const Color(0xFF67A5C8);
//   final Color pr05 = const Color(0xFF106FA4);
//   final Color pr06 = const Color(0xFF0B568D);
//   final Color pr07 = const Color(0xFFdceef3);
//   final Color pr08 = const Color(0xFFc2e2ea);
//   final Color pr09 = const Color(0xFFa7d5e1);
//   final Color pr10 = const Color(0xFF8dc8d8);
//   final Color pr11 = const Color(0xFF72bbce);
//   final Color pr12 = const Color(0xFFEBF5FB);
// }

class PrimaryColor {
  final Color pr01 = const Color(0xFFEDEBF5);
  final Color pr02 = const Color(0xFFC3BBE5);
  final Color pr03 = const Color(0xFF53494A);
  final Color pr04 = const Color(0xFFB6ADDE);
  final Color pr05 = const Color(0xFFC6C09F);
  final Color pr06 = const Color(0xFFA99A9D);
  final Color pr07 = const Color(0xFF8B8F97);
  final Color pr08 = const Color(0xFF130D11);
  final Color pr09 = const Color(0xFF8A80FF);
  final Color pr10 = const Color(0xFF17204B);
  final Color pr11 = const Color(0xFFFFFFFF);
  final Color pr12 = const Color(0xFFF5F3FF);
  final Color pr13 = const Color(0xFF006FD4);
  final Color pr14 = const Color(0xFF90CAF9);
  final Color pr15 = const Color(0xFFDEEFFD);
}

class SecondaryColor {
  final ScYellow scYellow = ScYellow();
  final ScRed scRed = ScRed();
  final ScGreen scGreen = ScGreen();
}

class ScYellow {
  final Color sc01 = const Color(0xFFFEF6D0);
  final Color sc02 = const Color(0xFFFEEAA2);
  final Color sc03 = const Color(0xFFFDDB73);
  final Color sc04 = Color.fromARGB(255, 90, 74, 32);
  final Color sc05 = const Color(0xFFFAB317);
  final Color sc06 = const Color(0xFFD79210);
  final Color sc07 = const Color(0xFFB3740B);
  final Color sc08 = const Color(0xFFB3740B);
  final Color sc09 = const Color(0xFF774404);
}

class ScRed {
  final Color sc01 = const Color(0xFFFEDBD7);
  final Color sc02 = const Color(0xFFFDB1AF);
  final Color sc03 = const Color(0xFFF9868F);
  final Color sc04 = const Color(0xFFF4677F);
  final Color sc05 = const Color(0xFFED3768);
  final Color sc06 = const Color(0xFFCB2864);
  final Color sc07 = const Color(0xFFAA1B5D);
  final Color sc08 = const Color(0xFF891154);
  final Color sc09 = const Color(0xFF710A4E);
}

class ScGreen {
  final Color sc01 = const Color(0xFFE3FBDA);
  final Color sc02 = const Color(0xFFC2F7B6);
  final Color sc03 = const Color(0xFF95E88D);
  final Color sc04 = const Color(0xFF6AD26A);
  final Color sc05 = const Color(0xFF3EB449);
  final Color sc06 = const Color(0xFF2D9A41);
  final Color sc07 = const Color(0xFF1F813A);
  final Color sc08 = const Color(0xFF136832);
  final Color sc09 = const Color(0xFF0B562D);
  final Color sc10 = const Color(0xFF3CBC13);
  final Color sc11 = const Color(0xFF00AF6E);
  final Color sc12 = const Color(0xFFB5EB2E);
}

class InfoColor {
  final Color inf01 = const Color(0xFFD6E4FF);
  final Color inf02 = const Color(0xFFADC8FF);
  final Color inf03 = const Color(0xFF85A9FF);
  final Color inf04 = const Color(0xFF6690FF);
  final Color inf05 = const Color(0xFF3366FF);
  final Color inf06 = const Color(0xFF254EDA);
  final Color inf07 = const Color(0xFF1A39B6);
  final Color inf08 = const Color(0xFF102693);
  final Color inf09 = const Color(0xFF0A1A7A);
  final Color inf10 = const Color(0xFF228BE6);
}

class WarningColor {
  final Color wn01 = const Color(0xFFFFF7D0);
  final Color wn02 = const Color(0xFFFEED9F);
  final Color wn03 = const Color(0xFFFEE06E);
  final Color wn04 = const Color(0xFFFED24B);
  final Color wn05 = const Color(0xFFFEBF10);
  final Color wn06 = const Color(0xFFDA9E0A);
  final Color wn07 = const Color(0xFFB67F08);
  final Color wn08 = const Color(0xFF926105);
  final Color wn09 = const Color(0xFF794D04);
  final Color wn10 = const Color(0xFFE19E05);
  final Color wn11 = const Color(0xFFFFF7E6);
}

class SuccessColor {
  final Color scs01 = const Color(0xFFFCFDF5);
  final Color scs02 = const Color(0xFFFAFEEF);
  final Color scs03 = const Color(0xFFF5FDE5);
  final Color scs04 = const Color(0xFFF2FDDF);
  final Color scs05 = const Color(0xFFEBFCD2);
  final Color scs06 = const Color(0xFFBCD89B);
  final Color scs07 = const Color(0xFF8FB56A);
  final Color scs08 = const Color(0xFF679243);
  final Color scs09 = const Color(0xFF4B7728);
  final Color scs10 = const Color(0xFF0CA678);
  final Color scs11 = const Color(0xFFE7F6F2);
  final Color scs12 = const Color.fromARGB(255, 61, 213, 10);
}

class DangerColor {
  final Color dng01 = const Color(0xFFFEE8D3);
  final Color dng02 = const Color(0xFFFDCBA8);
  final Color dng03 = const Color(0xFFFEA77C);
  final Color dng04 = const Color(0xFFFE845D);
  final Color dng05 = const Color(0xFFFE4C28);
  final Color dng06 = const Color(0xFFD92E1C);
  final Color dng07 = const Color(0xFFB61714);
  final Color dng08 = const Color(0xFF930B15);
  final Color dng09 = const Color(0xFF7A0718);
  final Color dng10 = const Color(0xFFF6DCDB);
  final Color dng11 = const Color(0xFFDB342C);
}

class NeutralColor {
  final Color ne01 = const Color(0xFFF5F5F5);
  final Color ne02 = const Color(0xFFE5E5E5);
  final Color ne03 = const Color(0xFFD4D4D4);
  final Color ne04 = const Color(0xFFA3A3A3);
  final Color ne05 = const Color(0xFF737373);
  final Color ne06 = const Color(0xFF525252);
  final Color ne07 = const Color(0xFF404040);
  final Color ne08 = const Color(0xFF262626);
  final Color ne09 = const Color(0xFF171717);
  final Color ne10 = const Color(0xFF697586);
  final Color ne11 = const Color(0xFF9AA4B2);
  final Color ne12 = const Color(0xFF202939);
  final Color ne13 = const Color(0xFFE3E8EF);
  final Color ne14 = const Color(0xFF9AA4B2);
  final Color ne15 = const Color(0xFF697586);
  final Color ne16 = const Color(0xFFCDD5DF);
}
