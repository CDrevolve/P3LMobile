
class Presensi {
  int id_presensi;
  int id_karyawan;
  String tanggal;
  String status;

Presensi(
    {
      required this.id_presensi,
      required this.id_karyawan,
      required this.tanggal,
      required this.status,
    }
  );

  factory Presensi.fromJson(Map<String,dynamic>json){
    return Presensi(
      id_presensi: json['id'],
      id_karyawan: json['id_karyawan'],
      tanggal: json['tanggal'],
      status: json['status'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id' : id_presensi,
      'id_karyawan' : id_karyawan,
      'tanggal' : tanggal,
      'status' : status,
    };
  }
}
