import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/chatting_model.dart' as chatting_model;
import '../models/send_message_model.dart';
import '../models/siswa_list_model.dart' as siswa_list_model;
import '../common/my_helper.dart';
import '../services/api.dart';

class ChatProvider with ChangeNotifier {
  RefreshController refreshSiswaController =
      RefreshController(initialRefresh: true);
  Timer? timerSiswa;
  List<siswa_list_model.Datum> siswaList = [];
  String? lastMessage = '';
  bool loadingSiswa = true;

  Timer? timerChatting;
  List<chatting_model.Datum> chattingList = [];
  int? latestChattingId;
  bool loadingChatting = true;

  bool loadingSendMessage = false;

  Future<void> showSiswaList(var params) async {
    var data = await API.getForChatting(API.apiUrl + 'siswa-list', params);

    var result = siswa_list_model.SiswaListModel.fromJson(data);

    if (result.status!) {
      lastMessage = result.data!.first.lastMessage;

      siswaList = [];
      siswaList = result.data!;
    } else {
      MyHelper.toast(result.message ?? '-');
    }

    loadingSiswa = false;
    refreshSiswaController.refreshCompleted();
    notifyListeners();
  }

  Future<void> showSiswaListAutomatic(var params) async {
    var _duration = const Duration(seconds: 3);

    timerSiswa = Timer.periodic(_duration, (_) async {
      print("Start Timer Siswa");

      var data = await API.getForChatting(API.apiUrl + 'siswa-list', params);
      var result = siswa_list_model.SiswaListModel.fromJson(data);

      if (result.status!) {
        if (result.data!.isNotEmpty) {
          if (lastMessage != result.data!.first.lastMessage) {
            lastMessage = result.data!.first.lastMessage;

            siswaList = [];
            siswaList = result.data!;
          }
        }
      } else {
        MyHelper.toast(result.message ?? '-');
      }

      notifyListeners();
    });
  }

  void stopTimerSiswa() {
    timerSiswa!.cancel();
  }

  Future<void> showChatting(var params) async {
    var data = await API.getForChatting(API.apiUrl + 'chatting-show', params);
    var result = chatting_model.ChattingModel.fromJson(data);

    if (result.status!) {
      chattingList = [];
      chattingList = result.data!;

      if (result.data!.isNotEmpty) latestChattingId = result.data!.first.id;
    } else {
      MyHelper.toast(result.message ?? '-');
    }

    loadingChatting = false;
    notifyListeners();
  }

  Future<void> automaticRefresh(var params) async {
    var _duration = const Duration(seconds: 3);

    timerChatting = Timer.periodic(_duration, (_) async {
      print("Start Timer Chatting");

      if (latestChattingId != null) {
        params['latest_chatting_id'] = latestChattingId;
      }

      var data = await API.getForChatting(API.apiUrl + 'chatting-show', params);
      var result = chatting_model.ChattingModel.fromJson(data);

      if (result.status!) {
        if (result.data!.isNotEmpty) {
          latestChattingId = result.data!.first.id;

          for (var element in result.data!) {
            chattingList.insert(0, element);

            int index = siswaList.indexWhere((element) =>
                (element.id.toString() ==
                    params['siswa_receiver_id'].toString()));
            if (index > -1) siswaList[index].lastMessage = element.komentar;
            if (index > -1) {
              siswaList[index].lastTime = element.createdAt.toString();
            }
          }

          notifyListeners();
        }
      }
    });
  }

  void stopTimer() {
    timerChatting!.cancel();
  }

  Future<SendMessageModel?> sendMessage(var params) async {
    loadingSendMessage = true;
    notifyListeners();

    var data = await API.postForChatting(API.apiUrl + 'send-message', params);
    var result = SendMessageModel.fromJson(data);

    if (result.status!) {
      loadingSendMessage = false;

      latestChattingId = result.data!.id;

      showChatting(params);
      showSiswaList(params);
      notifyListeners();
      return result;
    } else {
      MyHelper.toast(result.message ?? '-');
      loadingSendMessage = false;
      notifyListeners();
      return null;
    }
  }
}
