import 'package:flutter/material.dart';
import 'dart:math';

List finalList = [];
List allowed = [];
Random random = new Random();

String Password(n, u, l, s, length) {
  String str = '';
  if (n == true) {
    finalList.addAll(nums);
    int r = random.nextInt(nums.length);
    str += nums[r].toString();
    length -= 1;
  }
  if (u == true) {
    finalList.addAll(uppercaps);
    int r = random.nextInt(uppercaps.length);
    str += uppercaps[r].toString();
    length -= 1;
  }
  if (l == true) {
    finalList.addAll(smallcaps);
    int r = random.nextInt(smallcaps.length);
    str += smallcaps[r].toString();
    length -= 1;
  }
  if (s == true) {
    finalList.addAll(specialchar);
    int r = random.nextInt(specialchar.length);
    str += specialchar[r].toString();
    length -= 1;
  }

  int strl = str.length;

  for (int i = 0; i < length; i++) {
    int r = random.nextInt(finalList.length);
    str += finalList[r].toString();
  }
  print(str);
  print(12);
  finalList.clear();
  return str;
}

List smallcaps = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

List specialchar = [
  '!',
  '#',
  '%',
  '&',
  '(',
  ')',
  '*',
  '+',
  '-',
  '.',
  '/',
  ':',
  ';' '<',
  '=',
  '>',
  '?',
  '@'
];
List nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
List uppercaps = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
