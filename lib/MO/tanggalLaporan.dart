import 'package:flutter/material.dart';
import 'package:p3lmobile/Client/LaporanPP_client.dart';
import 'package:p3lmobile/model/pemasukan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TanggalLaporanScreen extends StatefulWidget {
  const TanggalLaporanScreen({super.key});

  @override
  State<TanggalLaporanScreen> createState() => _TanggalLaporanScreenState();
}

class _TanggalLaporanScreenState extends State<TanggalLaporanScreen> {
  String? selectedMonth;
  int? selectedYear;
  Pemasukan? pemasukan;

  bool _isLoading = true;
  late SharedPreferences prefs;
  String token = '';
  int idRole = 0;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<int> years =
      List<int>.generate(5, (index) => DateTime.now().year - index);

  Future<void> refresh() async {
    try {
      int monthIndex = months.indexOf(selectedMonth!) + 1;
      String formattedMonth = monthIndex.toString().padLeft(2, '0');
      String formattedDate = '${selectedYear.toString()}-$formattedMonth';

      final pemasukan = await LaporanPPClient.fetchAll(
        token,
        formattedDate,
      );

      setState(() {
        this.pemasukan = pemasukan;
      });
    } catch (e) {
      print('Failed to get Laporan: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
      idRole = prefs.getInt('idRole')!;
      _isLoading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Month and Year'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  hint: Text('Select Month'),
                  value: selectedMonth,
                  onChanged: (newValue) {
                    setState(() {
                      selectedMonth = newValue;
                    });
                  },
                  items: months.map((month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),
                DropdownButton<int>(
                  hint: Text('Select Year'),
                  value: selectedYear,
                  onChanged: (newValue) {
                    setState(() {
                      selectedYear = newValue;
                    });
                  },
                  items: years.map((year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    await refresh();
                    if (selectedMonth != null && selectedYear != null) {
                      final snackBar = SnackBar(
                        content: Text('Selected: $selectedMonth $selectedYear'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Generate'),
                ),
              ],
            ),
            if (pemasukan != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Atma Kitchen',
                        style: Theme.of(context).textTheme.headline6),
                    Text('Jl. Centralpark No. 10 Yogyakarta'),
                    SizedBox(height: 16),
                    Text('LAPORAN Pemasukan dan Pengeluaran',
                        style: Theme.of(context).textTheme.headline6),
                    Text('Bulan: ' + pemasukan!.bulanFormatted),
                    Text('Tahun: ' + pemasukan!.tahun.toString()),
                    Text(
                        'Tanggal cetak: ${DateTime.now().toLocal().toString().split(' ')}'),
                    SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                          },
                          children: [
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Deskripsi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Pemasukan',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Pengeluaran',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            if (pemasukan == null)
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Tidak Ada Data',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Kosong',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Kosong',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            else
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Pengeluaran',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          pemasukan!.totalPemasukan.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Tips',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        )),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(pemasukan!.totaltips.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        )),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Gaji Karyawan',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        )),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        )),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(pemasukan!.gaji.toString(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            if (pemasukan?.pengeluaran != null)
                              ...pemasukan!.pengeluaran!.map((pengeluaran) {
                                return TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(pengeluaran!.nama,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            )),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            )),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Text(pengeluaran.total.toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                )),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        pemasukan!.totalPemasukan.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        (pemasukan!.totalPengeluaran +
                                                pemasukan!.gaji)
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
