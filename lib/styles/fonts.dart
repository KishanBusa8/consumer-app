part of styles;

class AppFont {
  static TextStyle getAppFont({
     FontWeight? fontWeight,
     double? fontSize,
     Color? color,
  }) {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ));
  }
  
}
class HeaderFonts {
  static final primaryHeader = AppFont.getAppFont(
    fontSize: 37,
    fontWeight: FontWeight.w500,
    color: TextColors.primary,
  );
  static final secondaryHeader = AppFont.getAppFont(
    fontSize: 37,
    fontWeight: FontWeight.w500,
    color: TextColors.ternary,
  );
  static final ternaryHeader = AppFont.getAppFont(
    fontSize: 37,
    fontWeight: FontWeight.w500,
    color: TextColors.quaternary,
  );

  // static final secondaryHeader = AppFont.getAppFont(
  //   fontWeight: FontWeight.normal,
  //   fontSize: 20,
  //   color: TextColors.primary,
  // );
}

class BoldHeader{
    static final primaryText = AppFont.getAppFont(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: TextColors.quaternary,
  );
  static final secondaryText = AppFont.getAppFont(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: TextColors.secondary
  );
}
class SmallHeader{
    static final primaryText = AppFont.getAppFont(
    fontSize: 21,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
class loginHint{
    static final primaryText = AppFont.getAppFont(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: Colors.black.withOpacity(0.4),
  );
}
class errorText{
    static final primaryText = AppFont.getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color.fromARGB(255, 253, 88, 66),
  );
}
class TextFonts{
    static final primaryText = AppFont.getAppFont(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: TextColors.primary,
  );
  static final secondaryText = AppFont.getAppFont(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: TextColors.ternary,
  );
  static final ternaryText = AppFont.getAppFont(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: TextColors.quaternary,
  );
   static final quaternaryText = AppFont.getAppFont(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: TextColors.secondary,
  );
}