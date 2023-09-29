class NumberToWords {
  static const List<String> units = [
    "",
    "thousand",
    "million",
    "billion",
    "trillion",
  ];

  static const List<String> belowTwenty = [
    "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
  ];

  static const List<String> tens = [
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
  ];

  static String convert(int num) {
    if (num == 0) {
      return "zero";
    }

    String result = "";
    int chunkIndex = 0;

    while (num > 0) {
      int chunk = num % 1000;
      if (chunk != 0) {
        String chunkWords = convertChunk(chunk);
        if (chunkIndex > 0) {
          chunkWords += " ${units[chunkIndex]}";
        }
        if (result.isNotEmpty) {
          result = "$chunkWords $result";
        } else {
          result = chunkWords;
        }
      }
      num ~/= 1000;
      chunkIndex++;
    }

    return result.trim();
  }

  static String convertChunk(int chunk) {
    String result = "";
    if (chunk >= 100) {
      result += "${belowTwenty[chunk ~/ 100]} hundred ";
    }

    if (chunk % 100 < 20) {
      result += belowTwenty[chunk % 100];
    } else {
      result += tens[chunk % 100 ~/ 10];
      if (chunk % 10 != 0) {
        result += "-${belowTwenty[chunk % 10]}";
      }
    }

    return result;
  }
}
