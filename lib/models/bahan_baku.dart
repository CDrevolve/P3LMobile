class BahanBaku {
  final String nama;
  final String satuan;
  final int stok;

  BahanBaku({
    required this.nama,
    required this.satuan,
    required this.stok,
  });

  factory BahanBaku.fromJson(Map<String, dynamic> json) {
    return BahanBaku(
      nama: json['nama'],
      satuan: json['satuan'],
      stok: json['stok'],
    );
  }
}