import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dnplgkuhwiehworgojnv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRucGxna3Vod2llaHdvcmdvam52Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI2NzM3NDMsImV4cCI6MjA0ODI0OTc0M30.Psrvw9_mYKK9sAqNMotvSOM4p6lVslwy499Nu4IXT18',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
