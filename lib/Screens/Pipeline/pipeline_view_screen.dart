import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Modul/view_image_screen.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class PipelineViewScreen extends StatefulWidget {
  String calonDebitur;
  String tglPipeline;
  String alamat;
  String telepon;
  String jenisProduk;
  String nominal;
  String cabang;
  String keterangan;
  String status;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String nomorKtp;
  String nomorNip;
  String tglPenyerahan;
  String tanggalAkad;
  // String npwp;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String foto1;
  String fotoAkad1;
  String fotoAkad2;
  String fotoTandaTerima;
  String nomorRekening;
  String nomorPerjanjian;
  String nominalPinjaman;
  String finalOS;
  String nominalTopUp;
  String kodeAO;
  String namaPetugasBank;
  String teleponPetugasBank;

  PipelineViewScreen(
      this.calonDebitur,
      this.tglPipeline,
      this.alamat,
      this.telepon,
      this.jenisProduk,
      this.nominal,
      this.cabang,
      this.keterangan,
      this.status,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.nomorKtp,
      this.nomorNip,
      this.tglPenyerahan,
      this.tanggalAkad,
      // this.npwp,
      this.statusKredit,
      this.pengelolaPensiun,
      this.bankTakeover,
      this.foto1,
      this.fotoAkad1,
      this.fotoAkad2,
      this.fotoTandaTerima,
      this.nomorRekening,
      this.nomorPerjanjian,
      this.nominalPinjaman,
      this.finalOS,
      this.nominalTopUp,
      this.kodeAO,
      this.namaPetugasBank,
      this.teleponPetugasBank);
  @override
  _PipelineViewScreenState createState() => _PipelineViewScreenState();
}

class _PipelineViewScreenState extends State<PipelineViewScreen> {
  List imgList;
  List imgText;

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "https://wa.me/$phone/?text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            // '${widget.calonDebitur}',
            'Detail Pipeline',
            // 'Detail Pipeline',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                String teleponFix = '+62' + widget.telepon;
                launchWhatsApp(phone: teleponFix, message: 'Tes');
              },
              icon: Icon(MdiIcons.whatsapp),
              // color: Colors.green,
              iconSize: 20,
            ),
            IconButton(
              onPressed: () {
                String teleponFix = '+62' + widget.telepon;
                launch('tel:$teleponFix');
              },
              icon: Icon(Icons.call),
              // color: Colors.blue,
              iconSize: 20,
            )
          ],
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              // INFO NASABAH
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Informasi Nasabah',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    fieldDebitur('Nama Lengkap', setNull(widget.calonDebitur),
                        120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('No KTP', setNull(widget.nomorKtp), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('No NIP', setNull(widget.nomorNip), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Telepon', setNull(widget.telepon), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Alamat', setNull(widget.alamat), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Tanggal Lahir', setNull(widget.tanggalLahir),
                        120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Jenis Kelamin',
                        setJenisKelamin(setNull(widget.jenisKelamin)),
                        120.0,
                        ''),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),

              // INFO KREDIT
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Informasi Kredit',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    fieldDebitur('Plafond',
                        formatRupiah(setNull(widget.nominal)), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Cabang', setNull(widget.cabang), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Status Kredit', setNull(widget.statusKredit),
                        120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Pengelola Pensiun',
                        setNull(widget.pengelolaPensiun), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur('Jenis Produk',
                        setJenisProduk(setZero(widget.jenisProduk)), 120.0, ''),
                    SizedBox(height: 10),
                    fieldDebitur(
                        'Keterangan', setNull(widget.keterangan), 120.0, ''),
                    SizedBox(height: 10),
                    // setNull(widget.statusKredit) == 'TAKEOVER'
                    //     ? fieldDebitur('Bank Takeover',
                    //         setNull(widget.bankTakeover), 120.0, '')
                    //     : Text(''),
                    // setNull(widget.statusKredit) == 'TAKEOVER'
                    //     ? SizedBox(height: 10)
                    //     : Text('')
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),

              // DOKUMEN PENYERAHAN
              widget.status != '1'
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dokumen Penyerahan',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          width: 5.0,
                                          color: Colors.black12,
                                        ),
                                      ),
                                      child: Image.network(
                                        'https://tetranabasainovasi.com/marsit/${widget.foto1}',
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tanggal Submit : ',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            // fontSize: 12,
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          setNull(widget.tglPenyerahan),
                                          style: TextStyle(
                                            color: leadsGoColor,
                                            // fontSize: 12,
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),

              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),

              // DATA AKAD
              widget.status == '4'
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Data Akad',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          fieldDebitur('Tanggal Akad',
                              setNull(widget.tanggalAkad), 120.0, ''),
                          SizedBox(height: 10),
                          fieldDebitur('Nomor Rekening',
                              setNull(widget.nomorRekening), 120.0, ''),
                          SizedBox(height: 10),
                          fieldDebitur('Nomor Perjanjian',
                              setNull(widget.nomorPerjanjian), 120.0, ''),
                          SizedBox(height: 10),
                          fieldDebitur('Status Kredit',
                              setNull(widget.statusKredit), 120.0, ''),
                          SizedBox(height: 10),
                          const Divider(
                            height: 10,
                            thickness: 1,
                            indent: 5,
                            endIndent: 30,
                            color: Colors.black26,
                          ),
                          SizedBox(height: 10),
                          fieldDebiturLTR(
                              'Nominal Pinjaman',
                              formatRupiah(setNull(widget.nominalPinjaman)),
                              130.0),
                          SizedBox(height: 10),
                          widget.statusKredit == 'TOP UP'
                              ? Column(
                                  children: [
                                    fieldDebiturLTR(
                                        'Nominal O/S Akhir',
                                        '- ' +
                                            formatRupiah(
                                                setNull(widget.finalOS)),
                                        130.0),
                                    SizedBox(height: 10),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                      indent: 150,
                                      endIndent: 30,
                                      color: leadsGoColor,
                                    ),
                                    SizedBox(height: 10),
                                    fieldDebiturLTR(
                                        'Nominal Top Up',
                                        formatRupiah(
                                            setNull(widget.nominalTopUp)),
                                        130.0),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(height: 10),
                        ],
                      ),
                    )
                  : SizedBox(),

              widget.status == '4'
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Info Petugas Bank',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          fieldDebitur(
                              'Kode AO', setNull(widget.kodeAO), 120.0, ''),
                          SizedBox(height: 10),
                          fieldDebitur('Nama Petugas',
                              setNull(widget.namaPetugasBank), 120.0, ''),
                          SizedBox(height: 10),
                          fieldDebitur('Nomor Telepon',
                              setNull(widget.teleponPetugasBank), 120.0, ''),
                          SizedBox(height: 10),
                        ],
                      ),
                    )
                  : SizedBox(),

              widget.status == '4'
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dokumen Akad',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 120.0,
                                          height: 120.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(
                                              width: 5.0,
                                              color: Colors.black12,
                                            ),
                                          ),
                                          child: Image.network(
                                            'https://tetranabasainovasi.com/marsit/assets/images/pencairan_sales/${widget.fotoAkad1}',
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Foto Lembar\nPertama SPPK',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            // fontSize: 12,
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 120.0,
                                          height: 120.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(
                                              width: 5.0,
                                              color: Colors.black12,
                                            ),
                                          ),
                                          child: Image.network(
                                            'https://tetranabasainovasi.com/marsit/assets/images/pencairan_sales/${widget.fotoAkad2}',
                                            // fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Foto Tanda\nTanggan Akad',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            // fontSize: 12,
                                            fontFamily: 'LeadsGo-Font',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldDebitur(title, value, size, image) {
    return Row(
      children: <Widget>[
        Container(
          width: 130,
          // decoration: new BoxDecoration(
          //   // color: Colors.blueGrey[600],
          //   color: colorStatus(setNull(widget.status)),
          //   borderRadius: BorderRadius.circular(3.0),
          // ),

          child: Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 3.0),
            child: Text(
              title,
              style:
                  TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'LeadsGo-Font',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))),
        SizedBox(
          width: 10,
        ),
        image != ''
            ? InkWell(
                child: Icon(Icons.image_outlined),
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageApp(image, title)));
                },
              )
            : Text('')
      ],
    );
  }

  Widget fieldDebiturLTR(title, value, size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          // decoration: new BoxDecoration(
          //   // color: Colors.blueGrey[600],
          //   color: colorStatus(setNull(widget.status)),
          //   borderRadius: BorderRadius.circular(3.0),
          // ),

          child: Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 3.0),
            child: Text(
              title,
              style:
                  TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  value,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'LeadsGo-Font',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  iconStatus(String status) {
    if (status == '1') {
      return Icons.info;
    } else if (status == '2') {
      return Icons.check;
    } else if (status == '3') {
      return Icons.send;
    } else if (status == '4') {
      return Icons.date_range;
    }
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'PIPELINE';
    } else if (status == '2') {
      return 'PENCAIRAN';
    } else if (status == '3') {
      return 'SUBMIT DOKUMEN';
    } else if (status == '4') {
      return 'AKAD KREDIT';
    }
  }

  colorStatus(String status) {
    if (status == '1') {
      return Colors.deepOrange;
    } else if (status == '2') {
      return Colors.green;
    } else if (status == '3') {
      return Colors.deepPurple;
    } else if (status == '4') {
      return Colors.blueAccent;
    }
  }

  setNull(String data) {
    if (data == null || data == '') {
      return '-';
    } else {
      return data;
    }
  }

  setZero(String data) {
    if (data == null || data == '') {
      return '0';
    } else {
      return data;
    }
  }

  setJenisProduk(String produk) {
    switch (produk) {
      case "1":
        return 'Pegawai Aktif PNS / TNI / POLRI';
        break;
      case "2":
        return 'Prapensiun';
        break;
      case "3":
        return 'Prapensiun';
        break;
      case "4":
        return 'Kredit Insidentil';
        break;
      case "5":
        return 'Kredit Platinum 74 (BTPN)';
        break;
      case "6":
        return 'Kredit Platinum 74 (BJB)';
      case "0":
        return '-';
        break;
    }
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'Rp',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'Rp ' + fmf.output.withoutFractionDigits;
  }

  setJenisKelamin(jenisKelamin) {
    if (jenisKelamin == '0') {
      return 'LAKI-LAKI';
    } else {
      return 'PEREMPUAN';
    }
  }
}
