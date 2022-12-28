// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/my_helper.dart';
import '../common/my_style.dart';
import '../screens/chat_list_screen.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_network_image.dart';
import '../common/my_const.dart';
import '../providers/chat_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _showData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: Text(
              'Ketika kamu memilih salah satu user di bawah, berarti ibaratnya anda login sebagai user tersebut',
              textAlign: TextAlign.center,
              style:
                  MyStyle.textParagraph.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: chatProvider.siswaList.length,
                itemBuilder: (context, index) {
                  var data = chatProvider.siswaList[index];

                  return ListTile(
                    onTap: () => MyHelper.navPush(ChatListScreen(
                      itsMe: data,
                    )),
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
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _showData() async {
    await Provider.of<ChatProvider>(context, listen: false).showSiswaList(null);
  }
}
