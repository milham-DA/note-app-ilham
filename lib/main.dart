import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/bloc/auth_bloc.dart';
import 'package:note_app/pages/auth_page.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider( create: (context) => AuthBloc(),child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),),
      
    );
  }
}
