import "package:flutter/material.dart";

class ScissorPage extends StatelessWidget {
  const ScissorPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Danger Detection'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight >= 896 ? screenHeight : 896,
          color: Color(0xFFFAFAFA),
          child: Stack(
            children: [
              // Your existing content here
              // Adjust dimensions and positions based on screenWidth and screenHeight
              Positioned(
                left: 14,
                top: 48,
                child: Container(
                  width: 386,
                  height: 23,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 3,
                        child: Container(width: 24, height: 18, child: Stack()),
                      ),
                      Positioned(
                        left: 131,
                        top: 0,
                        child: Text(
                          'Danger Alerts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF44413E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 370,
                        top: 2,
                        child: Container(width: 16, height: 18, child: Stack()),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 101,
                child: Container(
                  width: 386,
                  height: 95,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 386,
                          height: 95,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 48,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 93,
                        top: 0,
                        child: Container(
                          width: 138,
                          height: 43,
                          padding: const EdgeInsets.only(top: 23, right: 30),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Danger Alerts',
                                style: TextStyle(
                                  color: Color(0xFF44413E),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 149,
                child: Text(
                  'Scissor Proximity Detected',
                  style: TextStyle(
                    color: Color(0xFF9F9C9A),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 567,
                child: Container(
                  width: 386,
                  height: 288,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 43,
                        child: Container(
                          width: 386,
                          height: 71,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 48,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 33,
                        top: 51,
                        child: SizedBox(
                          width: 339,
                          child: Text(
                            '"A scissor has been detected near your toddler. Immediate attention may be required."',
                            style: TextStyle(
                              color: Color(0xFF44413E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 157,
                        child: Container(
                          width: 386,
                          height: 48,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 185,
                                  height: 48,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 185,
                                        height: 48,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 1, color: Color(0xFFFF7000)),
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'DONE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFFF7000),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 201,
                                top: 0,
                                child: Container(
                                  width: 185,
                                  height: 48,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 185,
                                        height: 48,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFFF7000),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'CALL TO CAREGIVER',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 800,
                child: Container(
                  width: 414,
                  height: 96,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 28,
                        child: Container(
                          width: 414,
                          height: 68,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 48,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 51,
                        child: Container(
                          width: 23,
                          height: 22,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 23,
                                  height: 22,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/23x22"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.60,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFFFF7000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 116,
                        top: 51,
                        child: Container(
                          width: 10,
                          height: 22,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/10x22"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.40,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFF979797),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 179,
                        top: 0,
                        child: Container(
                          width: 56,
                          height: 56,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF7000),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 19,
                                top: 19,
                                child: Container(width: 18, height: 18, child: Stack()),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 287,
                        top: 51,
                        child: Container(width: 17, height: 22, child: Stack()),
                      ),
                      Positioned(
                        left: 355,
                        top: 51,
                        child: Container(
                          width: 19,
                          height: 22,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 4.75,
                                top: 0,
                                child: Container(
                                  width: 9.50,
                                  height: 9.78,
                                  decoration: ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(
                                        width: 1.80,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFF9F9C9A),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 242,
                 child: Image.asset(
                        "assets/scissorimg.png",
                        width: 277,
                        height: 279,
                        scale: 0.9,
                      ),
              ),
              Positioned(
                left: 50,
                top: 130,
                 child: Image.asset(
                        "assets/scissorimg.png",
                        width: 40,
                        height: 40,
                        scale: 0.9,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
