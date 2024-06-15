class Pengeluaran {
  final int id;
  final String nama;
  final int total;

  Pengeluaran({
    required this.id,
    required this.nama,
    required this.total,
  });

  factory Pengeluaran.fromJson(Map<String, dynamic> json) {
    return Pengeluaran(
      id: json['id'],
      nama: json['nama'],
      total: json['total'],
    );
  }
}
