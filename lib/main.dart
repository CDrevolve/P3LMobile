import 'package:flutter/material.dart';
import 'package:p3lmobile/client/karyawan_client.dart';
import 'package:p3lmobile/client/presensi_client.dart';
import 'package:p3lmobile/model/karyawan.dart';
import 'package:p3lmobile/model/presensi.dart';

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

 void editPresensi(int index) async {
  try {
    int karyawanId = daftarKaryawan[index].id_karyawan;
    List<Presensi> presensiList = await PresensiClient.fetchAll();
    Presensi? targetPresensi;

    // Mencari presensi untuk karyawan yang dipilih
    for (Presensi presensi in presensiList) {
      if (presensi.id_karyawan == karyawanId) {
        targetPresensi = presensi;
        break;
      }
    }

    // Menyiapkan nilai default untuk DropdownButtonFormField
    String? defaultStatus = targetPresensi?.status;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Presensi"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Nama Karyawan: ${daftarKaryawan[index].nama_karyawan}"),
            DropdownButtonFormField<String>(
              value: defaultStatus,
              items: ['Hadir', 'Tidak Hadir'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  defaultStatus = newValue;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              try {
                if (targetPresensi != null) {
                  await PresensiClient.update(targetPresensi.id_presensi, defaultStatus ?? 'unknown');
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Presensi berhasil diperbarui"),
                  ));
                } else {
                  throw Exception("Presensi tidak ditemukan");
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: $e"),
                  ),
                );
              }
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
      ),
    );
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
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                      "${daftarKaryawan[index].nama_karyawan} - ${daftarKaryawan[index].alamat_karyawan}"),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      editPresensi(index);
                    },
                  ),
                ),
                ExpansionTile(
                  title: Text("presensi"),
                  children: <Widget>[
                    FutureBuilder<List<Presensi>>(
                      future: PresensiClient.fetchAll(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.data == null) {
                          return Text("Data tidak tersedia");
                        } else {
                          List<Presensi> presensiList = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: presensiList.length,
                            itemBuilder: (context, index) {
                              if (presensiList[index].id_karyawan ==
                                  daftarKaryawan[index].id_karyawan) {
                                return ListTile(
                                  title: Text(
                                      "${presensiList[index].tanggal} - ${presensiList[index].status}"),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
