import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:leadsgo_apps/Screens/Disbursment/view_image.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:photo_view/photo_view.dart';

class DisbursmentViewScreen extends StatefulWidget {
  String calonDebitur;
  String alamat;
  String telepon;
  String tanggalAkad;
  // String nomorAplikasi;
  String nomorRekening;
  String nomorPerjanjian;
  String plafond;
  String nominal;
  String nominal_os_akhir;
  // String nominalTopUp;
  String jenisPencairan;
  String jenisProduk;
  String kantorCabang;
  String informasiSales;
  String foto1;
  String foto2;
  String foto3;
  String tanggalPencairan;
  String jamPencairan;
  String namaTl;
  // String jabatanTl;
  String kodeTL;
  String teleponTl;
  String namaSales;
  String cabang;
  String keterangan;
  String status;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String tanggalPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String tanggalPipeline;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String nomorKtp;
  // String npwp;
  String nomorNip;
  String kodeProduk;

  DisbursmentViewScreen(
    this.calonDebitur,
    this.alamat,
    this.telepon,
    this.tanggalAkad,
    // this.nomorAplikasi,
    this.nomorRekening,
    this.nomorPerjanjian,
    this.plafond,
    this.nominal,
    this.nominal_os_akhir,
    // this.nominalTopUp,
    this.jenisPencairan,
    this.jenisProduk,
    this.kantorCabang,
    this.informasiSales,
    this.foto1,
    this.foto2,
    this.foto3,
    this.tanggalPencairan,
    this.jamPencairan,
    this.namaTl,
    // this.jabatanTl,
    this.kodeTL,
    this.teleponTl,
    this.namaSales,
    this.cabang,
    this.keterangan,
    this.status,
    this.statusKredit,
    this.pengelolaPensiun,
    this.bankTakeover,
    this.tanggalPenyerahan,
    this.namaPenerima,
    this.teleponPenerima,
    this.tanggalPipeline,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.nomorKtp,
    // this.npwp,
    this.nomorNip,
    this.kodeProduk,
  );
  @override
  _DisbursmentViewScreenState createState() => _DisbursmentViewScreenState();
}

class _DisbursmentViewScreenState extends State<DisbursmentViewScreen> {
  List imgList;
  List imgText;
  @override
  Widget build(BuildContext context) {
    String foto1 = 'https://tetranabasainovasi.com/marsit/' + widget.foto1;
    String foto2 = 'https://tetranabasainovasi.com/marsit/' + widget.foto2;
    String foto3 = 'https://tetranabasainovasi.com/marsit/' + widget.foto3;
    imgList = [foto1, foto2, foto3];
    imgText = ['Foto Akad', 'Foto Tanda Tangan Akad', 'Foto Bukti Dana Cair'];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: leadsGoColor,
            title: Text(
              '${widget.calonDebitur}',
              style: TextStyle(
                fontFamily: 'LeadsGo-Font',
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
              color: grey,
              child: ListView(physics: ClampingScrollPhysics(), children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detail Pencairan',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'LeadsGo-Font',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.tanggalPencairan,
                        style: TextStyle(
                            color: leadsGoColor,
                            fontSize: 18,
                            fontFamily: 'LeadsGo-Font',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      _buildBannerMenu(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
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
                                  fontSize: 16,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      fieldDebitur('Tanggal Input', setNull(widget.tanggalPipeline), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Calon Debitur', setNull(widget.calonDebitur), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Tanggal Lahir', setNull(widget.tanggalLahir), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'Jenis Kelamin',
                        setJenisKelamin(setNull(widget.jenisKelamin)),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'No KTP',
                        setNull(widget.nomorKtp),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'No NIP',
                        setNull(widget.nomorNip),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      fieldDebitur('Alamat', setNull(widget.alamat), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Telepon', setNull(widget.telepon), 120.0),
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
                                  fontSize: 16,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      fieldDebitur('Plafond', formatRupiah(setNull(widget.nominal)), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Cabang', setNull(widget.cabang), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Status Kredit', setNull(widget.statusKredit), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Pengelola Pensiun', setNull(widget.pengelolaPensiun), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur(
                          'Jenis Produk', setJenisProduk(setNull(widget.jenisProduk)), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Keterangan', setNull(widget.keterangan), 120.0),
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
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Penyerahan Dokumen',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          fieldDebitur('Tanggal', setNull(widget.tanggalPenyerahan), 120.0),
                          SizedBox(
                            height: 10,
                          ),
                          fieldDebitur(
                              'Pilih Produk', setJenisProduk(setNull(widget.jenisProduk)), 120.0),
                          SizedBox(
                            height: 10,
                          ),
                          // fieldDebitur('Telepon Penerima', setNull(widget.teleponPenerima), 120.0),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
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
                              'Data Akad',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'Tanggal Akad',
                        setNull(widget.tanggalAkad),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'Nomor Rekening',
                        setNull(widget.nomorRekening),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'Nomor Perjanjian',
                        setNull(widget.nomorPerjanjian),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      fieldDebitur(
                        'Status Kredit',
                        setNull(widget.statusKredit),
                        120.0,
                      ),
                      SizedBox(height: 10),
                      const Divider(
                        height: 10,
                        thickness: 1,
                        indent: 5,
                        endIndent: 30,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 10),
                      fieldDebiturLTR('Nominal Pinjaman', formatRupiah(widget.nominal), 130.0),
                      SizedBox(height: 10),
                      widget.statusKredit == 'TOP UP'
                          ? Column(
                              children: [
                                fieldDebiturLTR('Nominal O/S Akhir',
                                    '- ' + formatRupiah(widget.nominal_os_akhir), 130.0),
                                SizedBox(height: 10),
                                const Divider(
                                  height: 0,
                                  thickness: 2,
                                  indent: 200,
                                  endIndent: 30,
                                  color: Colors.black26,
                                ),
                                SizedBox(height: 10),
                                fieldDebiturLTR(
                                    'Nominal Top Up', formatRupiah(widget.plafond), 130.0),
                              ],
                            )
                          : Column(
                              children: [
                                fieldDebiturLTR(
                                    'Total Plafond', formatRupiah(widget.plafond), 130.0),
                              ],
                            ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                // INFO AO
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
                              'Info Petugas Bank',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      fieldDebitur('Kode AO', setNull(widget.kodeTL), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Nama Petugas', setNull(widget.namaTl), 120.0),
                      SizedBox(height: 10),
                      fieldDebitur('Nomor Telepon', setNull(widget.teleponTl), 120.0),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
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
                              'Data Pencairan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'LeadsGo-Font',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      fieldDebitur('Tanggal Pencairan', setNull(widget.tanggalPencairan), 120.0),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ]))),
    );
  }

  Widget fieldDebitur(title, value, size) {
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
              style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
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
              style: TextStyle(fontFamily: 'LeadsGo-Font', color: Colors.black54),
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

  Widget _buildBannerMenu() {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ImageView(item, 'Foto Pencairan')));
                          },
                          child: Image.network(item, fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }

  setNull(String data) {
    if (data == null || data == '' || data.isEmpty) {
      return '-';
    } else {
      return data;
    }
  }

  setJenisKelamin(jenisKelamin) {
    if (jenisKelamin == '0') {
      return 'LAKI-LAKI';
    } else {
      return 'PEREMPUAN';
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
        return 'Pensiun';
        break;
      case "4":
        return 'Kredit Insidentil';
        break;
      case "5":
        return 'Kredit Platinum 74 (BTPN)';
        break;
      case "6":
        return 'KREDIT Platinum 74 (BJB)';
        break;
      default:
        return 'NULL';
    }
  }

  formatRupiah(String data) {
    if (data == null || data == '0' || data == '' || data.isEmpty || data == 'null') {
      return 'Rp 0';
    } else {
      FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
          amount: double.parse(data),
          settings: MoneyFormatterSettings(
            symbol: 'Rp',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
          ));
      return 'Rp ' + fmf.output.withoutFractionDigits;
    }
  }

  messageStatus(String status) {
    if (status == '1') {
      return 'Pipeline';
    } else if (status == '2') {
      return 'Pencairan';
    } else if (status == '3') {
      return 'Submit Dokumen';
    } else if (status == '4') {
      return 'Akad Kredit';
    } else {
      return 'NULL';
    }
  }
}

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(image: ExactAssetImage('assets/tamas.jpg'), fit: BoxFit.cover)),
      ),
    );
  }
}
