import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;
bool isDarkMode = brightness == Brightness.dark;

String toolbox = 'assets/images/toolbox_logo.png';
String toolboxLogo = isDarkMode
    ? 'assets/images/toolbox_dark-mode_logo.png'
    : 'assets/images/toolbox_light-mode_logo.png';
