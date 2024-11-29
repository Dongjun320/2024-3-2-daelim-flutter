import 'dart:async';

import 'package:daelim_project/helpers/storage_helper.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class ChatScreen extends StatefulWidget {
  final String roomId;
  const ChatScreen({
    super.key,
    required this.roomId,
  });
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {

  final _client = Supabase.instance.client;
  String get _roomId = widget.roomId;
  StreamSubscription<List<Map<String,dynamic>>> ? _messageStream;

  final _textController = TextEditingController();

  final _primaryColor = const Color(0xFF4E80EE);
  final _secondaryColor = Colors.white;
  final _backgroundColor = const Color(0xFFF3F4F6);
  var _dummyChatList = List<Map<String, dynamic>>.generate(6, (index) {
    return {
      'sender_id': index % 2 == 0 ? 'b' : 'a',
      'message': '현재 메시지 테스트 중입니다.',
      'created_at': DateTime.now().add(-index.toMinute),
    };
  },);

  @override
  

  @override
  void initState() {
    super.initState();
    _dummyChatList = 
    _dummyChatList.sortedBy((e) => e['created_at']);
  }

  //메시지 스트림 시작
  void _startMessageStream(){
    _client
    .from('chat_message')
    .stream(primaryKey: ['id'],
    )
    .eq('room_id', widget.roomId)
    .listen((data){
      Log.green(data);
    });
  }

  //메시지 스트림 종료
  void _stopMessageStream(){
    _messageStream?.cancel();
    _messageStream = null;
  }

  // Note: 메시지 전송하기
  Future<void> _onSendMessage() async{

    final message = _textController.text;
    final senderId = StorageHelper().authData,userId;
    if (message.isEmpty || message.trim().isEmpty) return;

    _client //
      .from('chat_message')
      .insert({
        'room__id' : _roomId,
        'sender_id' : 
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('챗봇'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _dummyChatList.length,
              separatorBuilder: (context, index) {
                return 10.heightBox;
              },
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              itemBuilder: (context, index) {
                final dummy = _dummyChatList[index];
                final String senderId = dummy['sender_id'];
                final String message = dummy['message'];
                final DateTime createdAt = dummy['created_at'];
                final isMy = senderId == 'a';
                return Row(
                  mainAxisAlignment: isMy //
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 250,
                        minWidth: 50,
                      ),
                      decoration: BoxDecoration(
                        color: isMy //
                          ? _primaryColor
                          : _secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      child: ListTile(
                        title: Text(
                          message,
                          style: TextStyle(
                          color: isMy ? Colors.white : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          createdAt.toFormat('HH:mm'),
                          style: TextStyle(
                          color: isMy ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // NOTE: 메시지 전송 영역
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _secondaryColor,
              border: Border(
                top: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: false,
                      hintText: '메시지를 입력하세요...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                10.widthBox,
                ElevatedButton(
                  onPressed: _onSendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                  ),
                  child: const Text(
                    '전송',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}