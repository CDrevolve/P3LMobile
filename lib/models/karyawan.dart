
class Karyawan {
  int id_karyawan;
  String nama_karyawan;
  String tanggal_lahir;
  String alamat_karyawan;
  String notelp_karyawan;
  int gaji;

  Karyawan(
    {
      required this.id_karyawan,
      required this.nama_karyawan,
      required this.tanggal_lahir,
      required this.alamat_karyawan,
      required this.notelp_karyawan,
      required this.gaji,
    }
  );

  factory Karyawan.fromJson(Map<String,dynamic>json){
    return Karyawan(
      id_karyawan: json['id'],
      nama_karyawan: json['nama'],
      tanggal_lahir: json['tanggal_lahir'],
      alamat_karyawan: json['alamat'],
      notelp_karyawan: json['no_telp'],
      gaji: json['gaji'],

    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id' : id_karyawan,
      'nama' : nama_karyawan,
      'tanggal_lahir' : tanggal_lahir,
      'alamat' : alamat_karyawan,
      'no_telp' : notelp_karyawan,
      'gaji' : gaji,
    };
  }
}
