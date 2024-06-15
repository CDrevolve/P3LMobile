import 'package:p3lmobile/model/pengeluaran.dart';
import 'dart:convert';

class Pemasukan {
  final int totalPemasukan;
  final int totalPengeluaran;
  final int totaltips;
  final String bulanFormatted;
  final String tahun;
  final int gaji;

  final List<Pengeluaran?>? pengeluaran;

  Pemasukan({
    required this.totalPemasukan,
    required this.totalPengeluaran,
    required this.totaltips,
    required this.bulanFormatted,
    required this.tahun,
    required this.gaji,
    this.pengeluaran,
  });

  factory Pemasukan.fromJson(Map<String, dynamic> json) {
    return Pemasukan(
      totalPemasukan: json['total_pemasukan'],
      totalPengeluaran: json['total_pengeluaran'],
      totaltips: json['total_tips'],
      bulanFormatted: json['bulan_formatted'],
      tahun: json['tahun'],
      gaji: json['gaji'],
      pengeluaran: json['pengeluaran'] != null
          ? List<Pengeluaran>.from(
              json["pengeluaran"].map((x) => Pengeluaran.fromJson(x)))
          : null,
    );
  }
}
