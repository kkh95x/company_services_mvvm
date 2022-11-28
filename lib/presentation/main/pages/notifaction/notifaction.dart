import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm_desgin_app/presentation/resource/string_manager.dart';

class NotifactionPage extends StatefulWidget {
  const NotifactionPage({super.key});

  @override
  State<NotifactionPage> createState() => _NotifactionPageState();
}

class _NotifactionPageState extends State<NotifactionPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  Text(AppString.notifaction),
    );
  }
}