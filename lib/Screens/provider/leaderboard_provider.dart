import 'package:leadsgo_apps/Screens/models/leaderboard_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderboardItem {
  String nik;

  LeaderboardItem(this.nik);
}

class LeaderboardProvider extends ChangeNotifier {
  List<LeaderboardModel> _data = [];
  List<LeaderboardModel> get dataLeaderboard => _data;

  Future<List<LeaderboardModel>> getLeaderboard(
      LeaderboardItem leaderboardItem) async {
    final url = Uri.parse(
        'https://tetranabasainovasi.com/api_marsit_v1/service.php/getRank');
    final response =
        await http.post(url, body: {'nik_sales': leaderboardItem.nik});
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['Rank'].cast<Map<String, dynamic>>();
      _data = result
          .map<LeaderboardModel>((json) => LeaderboardModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
