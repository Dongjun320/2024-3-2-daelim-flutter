import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:daelim_project/common/scaffold/app_scaffold.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _onSearch(String value) {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appScren: AppScreen.users,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 유저 목록 타이틀
          const Text(
            '유저 목록',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          10.heightBox,
          //검색바
          TextField(
            onChanged: _onSearch,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFE4E4E7),
                ),
              ),
              hintText: '유저 검색....',
              prefixIcon: Icon(LucideIcons.search),
            ),
          ),
          10.heightBox
        ],
      ),
    );
  }
}
