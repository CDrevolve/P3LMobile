class Customer {
  int idCustomer;
  int idUser;
  String nama;
  DateTime tanggalLahir;
  String noTelp;
  int poin;
  double saldo;

  Customer({
    required this.idCustomer,
    required this.idUser,
    required this.nama,
    required this.tanggalLahir,
    required this.noTelp,
    required this.poin,
    required this.saldo,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      idCustomer: json['id'],
      idUser: json['id_user'],
      nama: json['nama'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      noTelp: json['no_telp'],
      poin: json['poin'],
      saldo: json['saldo'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idCustomer,
      'id_user': idUser,
      'nama': nama,
      'tanggal_lahir': tanggalLahir.toIso8601String(),
      'no_telp': noTelp,
      'poin': poin,
      'saldo': saldo,
    };
  }
}
