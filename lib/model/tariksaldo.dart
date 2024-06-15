class TarikSaldo {
  TarikSaldo({
    required this.id,
    required this.idCustomer,
    required this.saldo,
    required this.bank,
    required this.noRekening,
    required this.status,
    required this.tanggal,
  });

  int id;
  int idCustomer;
  int saldo;
  String bank;
  String noRekening;
  String status;
  String tanggal;

  factory TarikSaldo.fromJson(Map<String, dynamic> json) => TarikSaldo(
        id: json["id"],
        idCustomer: json["id_customer"],
        saldo: json["saldo"],
        bank: json["bank"],
        noRekening: json["no_rekening"],
        status: json["status"],
        tanggal: DateTime.parse(json['created_at']).toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_customer": idCustomer,
        "saldo": saldo,
        "bank": bank,
        "no_rekening": noRekening,
        "status": status,
        "tanggal": tanggal,
      };
}
