import 'package:example/basic/all.dart';
import 'package:example/basic/checkbox.dart';
import 'package:example/basic/date.dart';
import 'package:example/basic/radio.dart';
import 'package:example/basic/select.dart';
import 'package:example/basic/testArea.dart';
import 'package:example/basic/text.dart';
import 'package:example/basic/upload.dart';
import 'package:flutter/material.dart';


class SFormPage extends StatelessWidget {
  const SFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("静态示例"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("基本输入组件-text"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormTextPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("多行文本输入框-textArea"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormTextAreaPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("选择器组件-select"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormSelectPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("时间选择器-date"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormDatePage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("单项选择器-radio"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormRadioPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("多项选择器-checkbox"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormCheckBoxPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("文件上传-upload"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormUpload(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("合集"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SFormAll(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

