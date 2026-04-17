import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar());
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text('Daily News', style: GoogleFonts.mulish()));
  }
}
