import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_number_puzzle/auth/blocs/auth_bloc.dart';

import 'package:rapid_number_puzzle/auth/widgets/google_sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    _slideController = AnimationController(duration: Duration(milliseconds: 1200), vsync: this);
    _pulseController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _startAnimations();
    _pulseController.repeat(reverse: true);
  }

  void _startAnimations() async {
    await Future.delayed(Duration(milliseconds: 300));
    _fadeController.forward();
    await Future.delayed(Duration(milliseconds: 200));
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // state.isFetchingUser
        //     ? OverlayManager.show(
        //         context,
        //         overlayWidgetBuilder: (_) => Center(child: CircularProgressIndicator()),
        //       )
        //     : OverlayManager.hide();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildFloatingNumbers(),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 게임 로고/제목
                        FadeTransition(opacity: _fadeAnimation, child: _buildGameLogo()),

                        SizedBox(height: 60),

                        // 로그인 카드
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(opacity: _fadeAnimation, child: _buildLoginCard()),
                        ),

                        SizedBox(height: 40),

                        // 하단 설명 텍스트
                        FadeTransition(opacity: _fadeAnimation, child: _buildBottomText()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingNumbers() {
    return Container(
      height: 120,
      child: Stack(
        children: [
          // 떠다니는 숫자들
          _FloatingNumber(number: '1', left: 30, top: 20, delay: 0),
          _FloatingNumber(number: '5', right: 40, top: 15, delay: 500),
          _FloatingNumber(number: '9', left: 80, top: 50, delay: 1000),
          _FloatingNumber(number: '3', right: 80, top: 60, delay: 1500),
          _FloatingNumber(number: '7', left: 150, top: 10, delay: 2000),
          _FloatingNumber(number: '2', right: 150, top: 45, delay: 2500),
        ],
      ),
    );
  }

  Widget _buildGameLogo() {
    return Column(
      children: [
        // 3x3 미니 퍼즐 그리드 로고
        Container(
          width: 120,
          height: 120,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
              return AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: index == 4 ? _pulseAnimation.value : 1.0, // 가운데만 펄스
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF0f3460), Color(0xFF16213e)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withAlpha(76), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(76),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${numbers[index]}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        SizedBox(height: 24),

        // 게임 제목
        Text(
          'RAPID',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 4,
          ),
        ),
        Text(
          'NUMBER PUZZLE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white.withAlpha(205),
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(51), width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(103), blurRadius: 20, offset: Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Text(
            '시작하기',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),

          SizedBox(height: 8),

          Text(
            '최고 기록에 도전해보세요!',
            style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(178)),
          ),

          SizedBox(height: 32),

          // Google 로그인 버튼
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return GoogleSignInButton(
                isLoading: state.isFetchingUser,
                onPressed: () => context.read<AuthBloc?>()?.add(
                  AuthEvent.oauthSignInRequested(oauthProvider: 'google.com'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomText() {
    return Column(
      children: [
        Text('1부터 순서대로 터치하여', style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 14),),
        Text('모든 숫자를 제거하세요', style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 14),),
      ],
    );
  }
}

// 떠다니는 숫자 위젯
class _FloatingNumber extends StatefulWidget {
  final String number;
  final double? left, right, top;
  final int delay;

  const _FloatingNumber({
    required this.number,
    this.left,
    this.right,
    this.top,
    required this.delay,
  });

  @override
  State<_FloatingNumber> createState() => _FloatingNumberState();
}

class _FloatingNumberState extends State<_FloatingNumber> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 3000), vsync: this);

    _floatAnimation = Tween<double>(
      begin: 0,
      end: -20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      right: widget.right,
      top: widget.top,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Text(
                widget.number,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
