import 'package:flutter/widgets.dart';

import '../constants/const.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: screenWidth * 0.30,
    );
  }
}
