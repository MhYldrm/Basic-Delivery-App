import 'package:delivery_app/ui/cubit/anasayfa_cubit.dart';
import 'package:delivery_app/ui/cubit/sepet_cubit.dart';
import 'package:delivery_app/ui/cubit/urunDetay_cubit.dart';
import 'package:delivery_app/ui/views/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => UrunDetayCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Anasayfa(),
      ),
    );
  }
}

