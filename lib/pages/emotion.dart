import 'package:flutter/material.dart';

class Emotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
            child: Stack(
              children: [
                Positioned(
                  left: constraints.maxWidth * 0.034,
                  top: constraints.maxHeight * 0.05357,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: constraints.maxWidth * 0.043,
                            height: constraints.maxHeight * 0.02,
                            child: Stack()),
                        SizedBox(width: constraints.maxWidth * 0.33696),
                        Text(
                          'Emotion',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF44413E),
                            fontSize: constraints.maxWidth * 0.038,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.33696),
                        Container(
                            width: constraints.maxWidth * 0.038,
                            height: constraints.maxHeight * 0.02,
                            child: Stack()),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: constraints.maxHeight * 0.925223,
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.075,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.075,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0A000000),
                                  blurRadius: constraints.maxWidth * 0.115942,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: constraints.maxWidth * 0.096618,
                          top: constraints.maxHeight * 0.025,
                          child: Container(
                            width: constraints.maxWidth * 0.055,
                            height: constraints.maxHeight * 0.02455,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: constraints.maxWidth * 0.055,
                                    height: constraints.maxHeight * 0.02455,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/23x22"),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width:
                                              constraints.maxWidth * 0.001449,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
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
                        Positioned(
                          left: constraints.maxWidth * 0.280193,
                          top: constraints.maxHeight * 0.025,
                          child: Container(
                            width: constraints.maxWidth * 0.024154,
                            height: constraints.maxHeight * 0.02455,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/10x22"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: constraints.maxWidth * 0.003623,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFF979797),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: constraints.maxWidth * 0.68958,
                          top: constraints.maxHeight * 0.025,
                          child: Container(
                              width: constraints.maxWidth * 0.041,
                              height: constraints.maxHeight * 0.02455,
                              child: Stack()),
                        ),
                        Positioned(
                          left: constraints.maxWidth * 0.854589,
                          top: constraints.maxHeight * 0.025,
                          child: Container(
                            width: constraints.maxWidth * 0.045893,
                            height: constraints.maxHeight * 0.02455,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: constraints.maxWidth * 0.011,
                                  top: 0,
                                  child: Container(
                                    width: constraints.maxWidth * 0.02299,
                                    height: constraints.maxHeight * 0.01094,
                                    decoration: ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                          width: constraints.maxWidth * 0.00435,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
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
                  left: constraints.maxWidth * 0.034,
                  top: constraints.maxHeight * 0.01339,
                  child: Container(
                    width: constraints.maxWidth * 0.93019,
                    height: constraints.maxHeight * 0.01563,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/386x14"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.2657,
                  top: constraints.maxHeight * 0.7089,
                  child: Container(
                    width: constraints.maxWidth * 0.446859,
                    height: constraints.maxHeight * 0.05357,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.446859,
                          height: constraints.maxHeight * 0.05357,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFF7000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  constraints.maxHeight * 0.02678),
                            ),
                          ),
                        ),
                        Text(
                          'VIEW LIVE FEED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxWidth * 0.028985,
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
                  left: constraints.maxWidth * 0.43478,
                  top: constraints.maxHeight * 0.886161,
                  child: Container(
                    width: constraints.maxWidth * 0.135266,
                    height: constraints.maxHeight * 0.0625,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: constraints.maxWidth * 0.135266,
                            height: constraints.maxHeight * 0.0625,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF7000),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: constraints.maxWidth * 0.33937,
                          top: constraints.maxHeight * 0.33929,
                          child: Container(
                              width: constraints.maxWidth * 0.0343,
                              height: constraints.maxHeight * 0.02009,
                              child: Stack()),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.29038,
                  top: constraints.maxHeight * 0.15067,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.429952,
                    height: constraints.maxHeight * 0.01902,
                    child: Text(
                      'CURRENT EMOTION\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: constraints.maxWidth * 0.088,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.14493,
                  top: constraints.maxHeight * 0.26004,
                  child: Container(
                    width: constraints.maxWidth * 0.736715,
                    height: constraints.maxHeight * 0.34152,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/305x305"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
