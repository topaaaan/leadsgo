import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:leadsgo_apps/Screens/Modul/view_image_screen.dart';
import 'package:leadsgo_apps/Screens/Modul/view_modul_screen.dart';
import 'package:leadsgo_apps/Screens/Modul/view_video_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class ModulScreen extends StatefulWidget {
  @override
  _ModulScreenState createState() => _ModulScreenState();
}

class _ModulScreenState extends State<ModulScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  int progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  _createFolder() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final folderName = "LeadsGo";
    final path = Directory("storage/emulated/0/Download/$folderName");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      path.create();
    }
  }

  bool _isLoading = false;
  final String apiUrl = 'https://tetranabasainovasi.com/api_marsit_v1/service.php/getModul';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.get(Uri.parse(apiUrl));
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Modul'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Modul'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _title(dynamic user) {
    return user['title'];
  }

  String _path(dynamic user) {
    return user['path'];
  }

  String _created_at(dynamic user) {
    return user['created_at'];
  }

  String _jenis(dynamic user) {
    return user['jenis'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
    _createFolder();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
        if (progress == 100) {
          Navigator.of(context).pop();
        }
      });

      print(message);
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  String pathPDF = "";
  File file;
  Future<File> createFileOfPdfUrl(final url) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Berita',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Toast.show(
                  'Download file tersimpan di interal_storage/Download/LeadsGo/',
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.CENTER,
                  backgroundColor: Colors.blueAccent,
                );
              },
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading == true) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor),
      ));
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              final path = 'https://tetranabasainovasi.com/marsit/' + _path(_users[index]);
              return Container(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black12,
                ))),
                child: InkWell(
                  onTap: () {
                    if (_jenis(_users[index]) == 'FILE') {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                          title: Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                          ),
                          actions: <Widget>[],
                        ),
                      );
                      createFileOfPdfUrl(path).then((f) async {
                        pathPDF = f.path;
                        if (pathPDF != '' && _jenis(_users[index]) == 'FILE') {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFScreen(pathPDF, _title(_users[index]))));
                        }
                      });
                    } else if (_jenis(_users[index]) == 'VIDEO') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VideoApp(_path(_users[index]), _title(_users[index]))));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ImageApp(_path(_users[index]), _title(_users[index]))));
                    }
                  },
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _title(_users[index]),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LeadsGo-Font'),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            _jenis(_users[index]) == 'FILE'
                                ? Icon(
                                    Icons.picture_as_pdf_outlined,
                                    color: Colors.black54,
                                  )
                                : Icon(Icons.video_collection_outlined, color: Colors.black54),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _jenis(_users[index]),
                              style: TextStyle(fontFamily: 'LeadsGo-Font'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.date_range_outlined, color: Colors.black54),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _created_at(_users[index]),
                              style: TextStyle(fontFamily: 'LeadsGo-Font'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      child: Icon(
                        Icons.file_download,
                      ),
                      onTap: () async {
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          final externalDir = await getExternalStorageDirectory();
                          String fileName = _path(_users[index])
                              .substring(_path(_users[index]).lastIndexOf("/") + 1);
                          final id = await FlutterDownloader.enqueue(
                            url: "https://tetranabasainovasi.com/marsit/" + _path(_users[index]),
                            savedDir: "/storage/emulated/0/Download/LeadsGo/",
                            fileName: fileName,
                            showNotification: true,
                            openFileFromNotification: true,
                          );
                        } else {
                          print("Permission deined");
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.hourglass_empty, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Berita belum tersedia',
              style:
                  TextStyle(fontFamily: "LeadsGo-Font", fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]),
        );
      }
    }
  }
}
