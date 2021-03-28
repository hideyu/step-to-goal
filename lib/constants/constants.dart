import 'package:flutter/material.dart';

// **************************
// 配色の設定
// **************************

const kBrandColor = "#d62e2e"; // メインのブランドカラー
const kBaseColor = "#f4f5f9"; // 背景とかに使うベースカラー
const kSupplementalColor = "#dddfe6"; // 線とかに使う補助的なカラー
const kAccentColor = "#4e3f30"; // 目立たせる箇所に使うアクセントカラー
const kFontColorLight = "#283d3e"; // フォントカラー
// const kFontColorDark = "#333333";

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
