import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rapid_number_puzzle/common/utils/show_app_modal_bottom_sheet.dart';
import 'package:rapid_number_puzzle/home/widgets/home_menu_bottom_sheet_body.dart';
import 'package:rapid_number_puzzle/number_puzzle/repository/number_puzzle_repository.dart';
import 'package:rapid_number_puzzle/number_puzzle/widgets/level_tile.dart';

class SelectLevelScreen extends StatelessWidget {
  const SelectLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const _AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + kToolbarHeight),
          child: Column(
            spacing: 12,
            children: [
              Text(
                '도전할 퍼즐 크기를 선택하세요',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(
                    20,
                  ).copyWith(top: 8, bottom: MediaQuery.of(context).viewPadding.bottom + 20),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return LevelTile(
                      onTap: () => context.push('/number-puzzle?boardSize=${index + 3}'),
                      boardSize: index + 3,
                      levelText: ['천국', '매우 쉬움', '쉬움', '보통', '어려움', '매우 어려움', '지옥'][index],
                      color: [
                        Color(0xFF90eeab),
                        Color(0xFF48bb78),
                        Color(0xFF38b2ac),
                        Color(0xFF4299e1),
                        Color(0xFFed8936),
                        Color(0xFFe53e3e),
                        Color(0xFFFF0000),
                      ][index],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        '난이도 선택',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            onPressed: () {
              showAppModalBottomSheet(
                context: context,
                title: '메뉴',
                body: HomeMenuBottomSheetBody(),
              );
            },
            icon: Icon(Icons.settings, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
