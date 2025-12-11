import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'DrawMenuOne.dart';
import 'DrawMenuTwo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'JO-GPT',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true, // 선택 사항: Material 3 디자인을 쓰고 싶을 때
          ),
          // 여기서 ResponsiveWrapper 적용
          builder: (context, widget) => ResponsiveWrapper.builder(
            widget,
            breakpoints: [
              ResponsiveBreakpoint.resize(320, name: 'SMALL_PHONE'),
              ResponsiveBreakpoint.resize(375, name: 'NORMAL_PHONE'),
              ResponsiveBreakpoint.resize(480, name: 'LARGE_PHONE'),
            ],
          ),

          home: const Center(child: MyHomePage(title: 'JO-GPT')),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final orangeColor = Color.fromRGBO(255, 165, 0, 1.0);
  final orange = Color.fromRGBO(246, 234, 216, 1);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true, // 기본값이지만 명시적으로 설정
      backgroundColor: orangeColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, size: 36, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();

            },
            icon: Icon(Icons.account_circle, size: 36, color: Colors.black),
          ),
        ],
        backgroundColor: orangeColor,
        centerTitle: true,
        title: Column(children: [Text(widget.title)]),
      ),
      drawer:const DrawMenuOne(),
      endDrawer:const DrawMenuTwo(),

      body: Container(
        color: orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위와 아래로 분리

          children: [
            Container(color: orangeColor),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget bottom() {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: Container(
        height: 0.08.sh,
        decoration: BoxDecoration(color: orangeColor),
        child: Row(
          children: [
            SizedBox(height: 150.h, width: 0.02.sw),
            GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (_) => _googleAppMenu());
              },
              child: Container(
                height: 150.h,
                width: 0.138.sw,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.add, size: 36, color: Colors.black),
              ),
            ),
            SizedBox(width: 0.02.sw),
            Expanded(
              child: Container(
                height: 150.h,

                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 14),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(
                                width: 0.64.sw,
                                height: 150.h,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  expands: true,

                                  textAlignVertical: TextAlignVertical.center,
                                  // ✅ 세로 가운데
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.zero, // ✅ zero로 변경!

                                    border: InputBorder.none,
                                    hintText: '내용을 입력하세요',
                                  ),
                                ),
                              ),
                              Container(
                                height: 150.h,
                                alignment: Alignment.center,

                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,  // 세로 중앙
                                  crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙
                                  children: [ IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.search_rounded, size: 34),
                                ),
                              ]),
                      )],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 0.02.sw),
          ],
        ),
      ),
    );
  }

  Widget _googleAppMenu() {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      alignment: Alignment.bottomCenter, // ⬅️ 하단 정렬!

      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 280.w,
            width: 350,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _appIcon(Icons.camera_alt, "카메라"),
                _appIcon(Icons.image, "사진"),
                _appIcon(Icons.attach_file, "파일"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, size: 30, color: Colors.black87),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
