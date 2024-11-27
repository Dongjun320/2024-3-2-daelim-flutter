import 'package:daelim_project/helpers/api_helper.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  const ChatScreen({super.key, required this.roomId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _primaryColor = const Color(0xFF4E80EE);
  final _secondaryColor = Colors.white;
  final _backgroundColor = const Color(0xFFF4F4F6);

  final _dummyChatList = List.generate(6, (index) {
    return {
      'sender_id': 'a',
      'message': '안녕하세요! 눈이 너무 많이 오네요',
      'create_at': DateTime.now().add(-index.toMinute),
    };
  });

  void _onSendMessage() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          title: const Text('챗봇'),
        ),
        body: Column(
          children: [
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _secondaryColor,
                border: const Border(
                  top: BorderSide(color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요....',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        filled: false,
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
                        backgroundColor: _primaryColor),
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
            )
          ],
        ));
  }
}
