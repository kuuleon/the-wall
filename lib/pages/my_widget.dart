import 'dart:math';
import 'package:flutter/material.dart';

import '../ string/strings.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with WidgetsBindingObserver {
  Color _backgroundColor = Colors.black; //  背景色を保持する変数
  String _text = 'Hello, World!'; //  テキストの文字列を保持する変数

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this); // WidgetsBindingObserverを登録
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this); // WidgetsBindingObserverを解除
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // アプリケーションがフォアグラウンドに移行したときの処理
      setState(() {
        _backgroundColor = _getRandomColor(); // 背景色をランダムな色に変更
        _text = _getRandomText(); // テキストの文字列をランダムな文字列に変更
      });
    } else if (state == AppLifecycleState.paused) {
      // アプリケーションがバックグラウンドに移行したときの処理
      setState(() {
        _backgroundColor = _getRandomColor(); // 背景色をランダムな色に変更
        _text = _getRandomText(); // テキストの文字列をランダムな文字列に変更
      });
    }
  }

  Color _getRandomColor() {
    Random random = Random();
    Color randomColor;
    do {
      randomColor = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    } while (randomColor == _backgroundColor); // 背景色と同じ色の場合は再生成
    return randomColor;
  }

  String _getRandomText() {
    texts = texts;
    Random random = Random();
    return texts[random.nextInt(texts.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _text,
            style:
                const TextStyle(fontSize: 20, color: Colors.white), // テキストの色を設定
          ),
        ),
      ),
    );
  }
}
