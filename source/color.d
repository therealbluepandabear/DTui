module color;

import std.stdio;
import std.conv;
import std.math.exponential;
import std.ascii;
import std.algorithm;
import std.format;

struct Color {
    int r;
    int g;
    int b;

    static Color Red = Color(255, 0, 0);
    static Color Green = Color(0, 255, 0);
    static Color Blue = Color(0, 0, 255);

    private static int hexToDouble(string hex) {
        int num;

        foreach (indx, hexChar; hex) {
            int b10;

            if (isDigit(hexChar)) {
                b10 = cast(int)(hexChar - '0');
            } else {
                b10 = cast(int)((toUpper(hexChar) - 0x40) + 9);
            }

            num += (b10 * pow(16, ((hex.length - indx) - 1)));
        }

        return num;
    }

    private static bool validateHexColorFormat(ref string hex) {
        if (hex.length == 7 && hex[0] == '#') {
            hex = hex[1..7];
        }

        foreach (hexChar; hex) {
            if (!isDigit(hexChar) && (toUpper(hexChar) != 'A' && toUpper(hexChar) != 'B' && toUpper(hexChar) != 'C' && toUpper(hexChar) != 'D' && toUpper(hexChar) != 'E' && toUpper(hexChar) != 'F')) {
                return false;
            }
        }

        return true;
    }

    static Color fromHex(string hex) {
        if (!validateHexColorFormat(hex)) {
            throw new Exception(format("Invalid format for hex string %s", hex));
        }

        int r = Color.hexToDouble(hex[0..2]);
        int g = Color.hexToDouble(hex[2..4]);
        int b = Color.hexToDouble(hex[4..6]);

        return Color(r, g, b);
    }
}
