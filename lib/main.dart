import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_manager/database/database_model.dart';
import 'home_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DatabaseModel>.value(value: DatabaseModel()),
        ],
        child: MaterialApp(
          title: 'Time Tracker',
          home: HomeScreen(),
        ),
      ),
    );
