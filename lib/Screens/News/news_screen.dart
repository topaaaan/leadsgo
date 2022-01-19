import 'package:flutter/material.dart';
import 'package:leadsgo_apps/Screens/provider/berita_provider.dart';
import 'package:leadsgo_apps/Screens/News/news_view_screen.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class BeritaScreen extends StatefulWidget {
  @override
  _BeritaScreen createState() => _BeritaScreen();
}

class _BeritaScreen extends State<BeritaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: leadsGoColor,
          title: Text(
            'Berita',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
        //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
        body: RefreshIndicator(
            onRefresh: () => Provider.of<BeritaProvider>(context, listen: false).getBerita(),
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                future: Provider.of<BeritaProvider>(context, listen: false).getBerita(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(leadsGoColor)),
                    );
                  }
                  return Consumer<BeritaProvider>(
                    builder: (context, data, _) {
                      print(data.dataBerita.length);
                      if (data.dataBerita.length == 0) {
                        return Center(
                          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.new_releases_outlined, size: 70),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Baca Berita Yuk!',
                              style: TextStyle(
                                  fontFamily: "LeadsGo-Font",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Temukan berita terbaru dari kantor pusat.',
                              style: TextStyle(
                                fontFamily: "LeadsGo-Font",
                                fontSize: 12,
                              ),
                            ),
                          ]),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: data.dataBerita.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: FittedBox(
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => DetailNews(
                                                data.dataBerita[i].title,
                                                data.dataBerita[i].path,
                                                data.dataBerita[i].content,
                                                data.dataBerita[i].createdAt)));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${data.dataBerita[i].title}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'LeadsGo-Font',
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.date_range_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('${data.dataBerita[i].createdAt}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontFamily: 'LeadsGo-Font',
                                                            fontWeight: FontWeight.bold)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            height: 200,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(24.0),
                                              child: Image(
                                                height: 100,
                                                fit: BoxFit.contain,
                                                alignment: Alignment.topRight,
                                                image: NetworkImage(
                                                  'https://tetranabasainovasi.com/marsit/${data.dataBerita[i].path}',
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            )),
      ),
    );
  }
}
