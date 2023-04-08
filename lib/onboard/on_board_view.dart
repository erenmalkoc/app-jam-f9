import 'package:app_jam_f9/models/onboard_model.dart';
import 'package:app_jam_f9/onboard/tab_indicator.dart';
import 'package:app_jam_f9/padding/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/login.dart';
import 'on_board_card.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final String _skipText = 'Skip';

  int _selectedIndex = 0;


  bool get _isLastPage => _selectedIndex == OnBoardModels.onBoardItems.length - 1;

  void _incrementChange([int? value]) {
    if (_isLastPage && value ==null) {
      return;
    }
    _incrementSelectedPageIndex(value);
  }

  void _incrementSelectedPageIndex([int? value]) {



    setState(() {
      _selectedIndex = value ?? _selectedIndex+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoş Geldin',
        style: TextStyle(color:Color(0XFF01579B)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [TextButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }, child: Text(_skipText,
        style: const TextStyle(color: Color(0XFF01579B)),))],

      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged:(value) {
                _incrementChange(value);
                },
                  itemCount: OnBoardModels.onBoardItems.length,
                  itemBuilder: (context, index) {
                    return OnBoardCard(
                        model: OnBoardModels.onBoardItems[index]);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabIndicator(
                  selectedIndex: _selectedIndex,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
