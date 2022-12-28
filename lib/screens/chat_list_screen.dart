// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../common/my_helper.dart';
import '../common/my_style.dart';
import '../screens/chat_detail.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_network_image.dart';
import '../common/my_const.dart';
import '../models/siswa_list_model.dart';
import '../providers/chat_provider.dart';

class ChatListScreen extends StatefulWidget {
  final Datum? itsMe;

  const ChatListScreen({Key? key, this.itsMe}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    _showData();
    _automaticRefresh();
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<ChatProvider>(context, listen: false).stopTimerSiswa();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chatting'),
      ),
      body: SmartRefresher(
        controller: chatProvider.refreshSiswaController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () => _showData(),
        child: ListView.builder(
            itemCount: chatProvider.siswaList.length,
            itemBuilder: (context, index) {
              var data = chatProvider.siswaList[index];

              if (data.id.toString() == widget.itsMe!.id.toString()) {
                return SizedBox();
              }

              return ListTile(
                onTap: () {
                  Provider.of<ChatProvider>(context, listen: false).stopTimerSiswa();
                  MyHelper.navPush(ChatDetailScreen(
                    itsMe: widget.itsMe,
                    datum: data,
                  ));
                },
                leading: CustomCard(
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(1000),
                    child: CustomNetworkImage(
                      url: MyConst.placeholder + '?random=${data.id}',
                    )),
                title: Text(
                  data.nama ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MyStyle.textParagraph
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  data.lastMessage ?? '',
                  style: MyStyle.subText,
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Text(
                    MyHelper.formatIndoDateTime(data.lastTime.toString()),
                    style: MyStyle.subText.copyWith(fontSize: 10),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> _showData() async {
    var params = {'siswa_sender_id': widget.itsMe!.id};

    await Provider.of<ChatProvider>(context, listen: false)
        .showSiswaList(params);
  }

  Future<void> _automaticRefresh() async {
    var params = {'siswa_sender_id': widget.itsMe!.id};

    await Provider.of<ChatProvider>(context, listen: false)
        .showSiswaListAutomatic(params);
  }
}
