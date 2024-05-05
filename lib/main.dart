import 'package:flutter/material.dart';
import 'package:p3lmobile/client/karyawan_client.dart';
import 'package:p3lmobile/model/karyawan.dart';

void main() {
  runApp(PresensiApp());
}

class PresensiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presensi Karyawan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PresensiPage(),
    );
  }
}

class PresensiPage extends StatefulWidget {
  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  List<Karyawan> daftarKaryawan = [];

  @override
  void initState() {
    super.initState();
    fetchKaryawan();
  }

  void fetchKaryawan() async {
    try {
      List<Karyawan> karyawan = await KaryawanClient.fetchAll();
      setState(() {
        daftarKaryawan = karyawan;
      });
    } catch (e) {
      print('Error fetching karyawan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Karyawan'),
      ),
      body: ListView.builder(
        itemCount: daftarKaryawan.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${daftarKaryawan[index].nama_karyawan} - ${daftarKaryawan[index].alamat_karyawan}"),
            // Jika Anda ingin menampilkan status kehadiran, tambahkan baris ini:
            // subtitle: Text(daftarKaryawan[index].hadir ? 'Hadir' : 'Tidak Hadir'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Tambahkan logika untuk mengedit karyawan
              },
            ),
          );
        },
      ),
    );
  }
}
