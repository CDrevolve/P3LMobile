class Pemesanan {
  int id_pemesanan;
  int id_customer;
  int id_karyawan;
  int id_alamat;
  String nama;
  String isi;
  double harga;
  String status;
  String pickup;
  DateTime tanggal;
  int jarak;
  double ongkir;
  double jumlah_pembayaran;
  double tips;
  String bukti_pembayaran;

  Pemesanan({
    required this.id_pemesanan,
    required this.id_customer,
    required this.id_karyawan,
    required this.id_alamat,
    required this.nama,
    required this.isi,
    required this.harga,
    required this.status,
    required this.pickup,
    required this.tanggal,
    required this.jarak,
    required this.ongkir,
    required this.jumlah_pembayaran,
    required this.tips,
    required this.bukti_pembayaran,
  });

  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    return Pemesanan(
      id_pemesanan: json['id'],
      id_customer: json['id_customer'],
      id_alamat: json['id_alamat'],
      id_karyawan: json['id_karyawan'],
      nama: json['nama'],
      isi: json['isi'],
      harga: json['harga'],
      status: json['status'],
      pickup: json['pickup'],
      tanggal: DateTime.parse(json['tanggal']),
      jarak: json['jarak'],
      ongkir: json['ongkir'],
      jumlah_pembayaran: json['jumlah_pembayaran'],
      tips: json['tips'],
      bukti_pembayaran: json['bukti_pembayaran'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id_pemesanan,
      'id_customer': id_customer,
      'id_alamat': id_alamat,
      'id_karyawan': id_karyawan,
      'nama': nama,
      'isi': isi,
      'harga': harga,
      'status': status,
      'pickup': pickup,
      'tanggal': tanggal.toIso8601String(),
      'jarak': jarak,
      'ongkir': ongkir,
      'bukti_pembayaran': bukti_pembayaran,
      'jumlah_pembayaran': jumlah_pembayaran,
      'tips': tips,
    };
  }
}
