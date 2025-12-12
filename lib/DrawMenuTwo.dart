import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawMenuTwo extends StatefulWidget {
  const DrawMenuTwo({super.key});

  @override
  State<StatefulWidget> createState() => _DrawMenuTwo();
}

class _DrawMenuTwo extends State<DrawMenuTwo> {
  final orangeColor = Color.fromRGBO(255, 165, 0, 1.0);
  final orangeYellow = Color.fromRGBO(244, 202, 136, 1.0);
  final orange = Color.fromRGBO(246, 234, 216, 1);
  final orangeColors = const Color(0xFFF97316);
  final blueWhite = Color.fromRGBO(252, 247, 253, 1);
  bool isLoggedIn = false;
  String nickname = "";
  String gptVersion = "";
  bool isLoading = true;

  final double titleFontSize = 32;
  final double fontSize = 18;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); //Drawer 열릴 때 로그인 상태 확인
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedNickname = prefs.getString("nickname");
    String? savedGptVersion = prefs.getString("gptVersion");

    setState(() {
      if (savedNickname != null) {
        isLoggedIn = true;
        nickname = savedNickname;
        gptVersion = savedGptVersion ?? "GPT-4.0";
      } else {
        isLoggedIn = false;
      }
      isLoading = false;
    });
  }

  Future<void> _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      isLoggedIn = false;
      nickname = "";
      gptVersion = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: blueWhite,
      width: screen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : isLoggedIn
            ? _buildLoggedInView(screen)
            : _buildLoginView(screen),
      ),
    );
  }

  Widget _buildLoggedInView(double screen) {
    return ListView(
      children: [
        Container(
          width: screen,
          height: 0.26.sh,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 0.2.sw, right: 0.2.sw),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    width: 0.25.sw,
                    height: 0.11.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  Container(
                    height: 0.015.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 0.05.sh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text("별명"),
                  ),
                  Container(
                    height: 0.015.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),

                  Container(
                    height: 0.05.sh,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text("GPT버전"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginView(double screen) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        SizedBox(height: 0.05.sh),
        Icon(Icons.account_circle, size: 80, color: Colors.black),
        SizedBox(height: 0.06.sh),

        Container(
          height: 0.6.sh,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'JO-GPT',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 0.035.sh),
              kakaoLogin(),
              SizedBox(height: 0.025.sh),
              naverLogin(),
              SizedBox(height: 0.025.sh),
              googleLogin(),
              SizedBox(height: 0.025.sh),
              memberJoin(),
              SizedBox(height: 0.025.sh),

              memberLogin(),
              SizedBox(height: 0.025.sh),
              nonMemberLogin(),
            ],
          ),
        ),
      ],
    );
  }

  Widget kakaoLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFE950),
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          height: 0.0549.sh,
          width: double.infinity,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/kakao-talk.png',
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsetsGeometry.only(right: 0.05.sw),
                  alignment: Alignment.center,
                  child: Text(
                    "카카오 로그인",
                    style: TextStyle(color: Colors.black, fontSize: fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget naverLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF03C75A),
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          width: double.infinity, // 버튼 전체 너비
          height: 0.0549.sh,
          child: Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/naver_icon.png',
                  fit: BoxFit.contain,
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsetsGeometry.only(right: 0.05.sw),

                  alignment: Alignment.center,
                  child: Text(
                    '네이버 로그인',
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget googleLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: Size(double.infinity, 48),
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          height: 0.0549.sh,
          width: double.infinity, // 버튼 전체 너비
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/google.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsetsGeometry.only(right: 0.085.sw),

                  child: Text(
                    '구글 로그인',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget memberJoin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[50],
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          height: 0.0549.sh,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,

                child: ClipRRect(
                  child: Image.asset(
                    'assets/mail.png',
                    width: 0.12.sw,
                    height: 0.05.sh,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsetsGeometry.only(right: 0.085.sw),

                  alignment: Alignment.center,
                  child: Text(
                    'JO-GPT 회원가입',
                    style: TextStyle(color: Colors.blue, fontSize: fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget memberLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: SizedBox(
          height: 0.0549.sh,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/user.png',
                    width: 0.12.sw,
                    height: 0.05.sh,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsetsGeometry.only(right: 0.087.sw),

                  child: Text(
                    'JO-GPT 로그인',
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nonMemberLogin() {
    return SizedBox(
      width: 0.76.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          width: double.infinity, // 버튼 전체 너비
          height: 0.0549.sh,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/people.png',
                    width: 0.12.sw,
                    height: 0.05.sh,
                  ),
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsetsGeometry.only(right: 0.087.sw),

                  child: Text(
                    '비회원 로그인',
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
