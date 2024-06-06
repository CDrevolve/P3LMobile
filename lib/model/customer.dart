
class Customer {
  int id_customer;
  int id_user;
  String nama;
  DateTime tanggal_lahir;
  String saldo;
  String no_telp;
  String poin;


Customer(
    {
      required this.id_customer,
      required this.id_user,
      required this.nama,
      required this.tanggal_lahir,
      required this.no_telp,
      required this.poin,
      required this.saldo,
    }
  );

  factory Customer.fromJson(Map<String,dynamic>json){
    return Customer(
      id_customer: json['id'],
      id_user: json['id_user'],
      nama: json['nama'],
      tanggal_lahir: json['tanggal_lahir'],
      no_telp: json['no_telp'],
      poin: json['poin'],
      saldo: json['saldo'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id' : id_customer,
      'id_user' : id_user,
      'nama' : nama,
      'tanggal_lahir' : tanggal_lahir,
      'no_telp' : no_telp,
      'poin' : poin,
      'saldo' : saldo,
    };
  }
}
