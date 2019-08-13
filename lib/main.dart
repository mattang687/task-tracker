import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_manager/database/database_model.dart';
import 'package:time_manager/home_screen/selected_info.dart';
import 'home_screen/home_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DatabaseModel>.value(value: DatabaseModel()),
        ],
        child: MaterialApp(
          title: 'Time Tracker',
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<SelectedInfo>.value(value: SelectedInfo()),
            ],
            child: HomeScreen(),
          ),
        ),
      ),
    );
