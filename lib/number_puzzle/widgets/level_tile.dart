import 'package:flutter/material.dart';

class LevelTile extends StatelessWidget {
  const LevelTile({
    super.key,
    required this.boardSize,
    required this.levelText,
    required this.color,
    this.onTap,
  });

  final int boardSize;
  final String levelText;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white, Colors.white.withOpacity(0.95)],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: color.withAlpha(76), blurRadius: 8, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$boardSize X $boardSize',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  levelText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2d3748),
                  ),
                ),
              ),
              _arrowRight(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _arrowRight() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: Color(0xFFf7fafc), borderRadius: BorderRadius.circular(12)),
      child: Icon(Icons.arrow_forward_ios, color: Color(0xFF4a5568), size: 16),
    );
  }
}
