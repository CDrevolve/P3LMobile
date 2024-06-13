class Product {
  final int id;
  final int idJenis;
  final int? idPenitip;
  final String nama;
  final double stok;
  final double harga;
  final int kuotaHarian;
  final String? foto;

  Product({
    required this.id,
    required this.idJenis,
    this.idPenitip,
    required this.nama,
    required this.stok,
    required this.harga,
    required this.kuotaHarian,
    this.foto

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      idJenis: json['id_jenis'],
      idPenitip: json['id_penitip'],
      nama: json['nama'],
      stok: json['stok'],
      harga: json['harga'],
      kuotaHarian: json['kuota_harian'],
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_jenis': idJenis,
      'id_penitip': idPenitip,
      'nama': nama,
      'stok': stok,
      'harga': harga,
      'kuota_harian': kuotaHarian,
      'foto': foto,
    };
  }
}
