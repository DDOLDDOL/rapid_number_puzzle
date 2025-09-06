import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_number_puzzle/auth/blocs/auth_bloc.dart';
import 'package:rapid_number_puzzle/home/widgets/home_menu_bottom_sheet_tile.dart';

class HomeMenuBottomSheetBody extends StatelessWidget {
  const HomeMenuBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        HomeMenuBottomSheetTile(
          label: '로그아웃',
          onTap: () => context.read<AuthBloc>().add(
            AuthEvent.oauthSingOutRequested(oauthProvider: 'google.com'),
          ),
        ),
      ],
    );
  }
}
