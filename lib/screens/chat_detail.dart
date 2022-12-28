// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/my_helper.dart';
import '../common/my_style.dart';
import '../models/chatting_model.dart' as chatting_model;
import '../models/siswa_list_model.dart' as siswa_list_model;
import '../widgets/custom_card.dart';
import '../widgets/custom_loading.dart';
import '../widgets/custom_network_image.dart';
import '../common/my_const.dart';
import '../providers/chat_provider.dart';

class ChatDetailScreen extends StatefulWidget {
  final siswa_list_model.Datum? itsMe;
  final siswa_list_model.Datum? datum;
  const ChatDetailScreen({Key? key, this.itsMe, this.datum}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  var inputController = TextEditingController();

  @override
  void initState() {
    _showData();
    _automaticRefresh();
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<ChatProvider>(context, listen: false).stopTimer();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context);

    Widget boxMe(chatting_model.Datum datumx) {
      return Row(
        children: [
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  MyHelper.formatIndoDateTime(datumx.createdAt.toString()),
                  style: MyStyle.subText.copyWith(fontSize: 10),
                ),
                CustomCard(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(1000),
                  bgColor: Colors.blue,
                  child: Text(
                    datumx.komentar ?? '',
                    style: MyStyle.textParagraph.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget boxHim(chatting_model.Datum datumx) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  MyHelper.formatIndoDateTime(datumx.createdAt.toString()),
                  style: MyStyle.subText.copyWith(fontSize: 10),
                ),
                CustomCard(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(1000),
                  bgColor: Colors.white,
                  child: Text(
                    datumx.komentar ?? '',
                    style: MyStyle.textParagraph,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
          ),
        ],
      );
    }

    Widget inputBox() {
      return CustomCard(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          bgColor: Colors.grey.shade300,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: inputController,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    sendMessage();
                  },
                  icon: chatProvider.loadingSendMessage
                      ? CustomLoading(
                          color: Colors.grey,
                        )
                      : Icon(Icons.send))
            ],
          ));
    }

    return WillPopScope(
      onWillPop: () async {
        _onWillPop();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CustomCard(
                  height: 40,
                  width: 40,
                  borderRadius: BorderRadius.circular(1000),
                  child: CustomNetworkImage(
                    url: MyConst.placeholder + '?random=${widget.datum!.id}',
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(child: Text(widget.datum?.nama ?? ''))
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: chatProvider.chattingList.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    var data = chatProvider.chattingList[index];

                    if (data.siswaId.toString() ==
                        widget.itsMe!.id.toString()) {
                      return boxMe(data);
                    } else {
                      return boxHim(data);
                    }
                  }),
            ),
            inputBox()
          ],
        ),
      ),
    );
  }

  Future<void> _showData() async {
    var params = {
      'siswa_sender_id': widget.itsMe!.id,
      'siswa_receiver_id': widget.datum!.id
    };

    var charProv = Provider.of<ChatProvider>(context, listen: false);

    charProv.chattingList = [];
    await charProv.showChatting(params);
  }

  Future<void> _automaticRefresh() async {
    var params = {
      'siswa_sender_id': widget.itsMe!.id,
      'siswa_receiver_id': widget.datum!.id,
    };

    await Provider.of<ChatProvider>(context, listen: false)
        .automaticRefresh(params);
  }

  Future<void> sendMessage() async {
    if (inputController.text != '') {
      Provider.of<ChatProvider>(context, listen: false).stopTimer();

      var params = {
        'siswa_id': widget.itsMe!.id.toString(),
        'siswa_sender_id': widget.itsMe!.id.toString(),
        'siswa_receiver_id': widget.datum!.id.toString(),
        'komentar': inputController.text,
      };

      var result = await Provider.of<ChatProvider>(context, listen: false)
          .sendMessage(params);

      if (result!.status!) {
        inputController.text = '';
      }

      _automaticRefresh();
    }
  }

  void _onWillPop() async {
    var params = {'siswa_sender_id': widget.itsMe!.id};

    await Provider.of<ChatProvider>(context, listen: false)
        .showSiswaListAutomatic(params);
  }
}
