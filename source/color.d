module color;

import std.stdio;
import std.conv;
import std.math.exponential;
import std.ascii;
import std.algorithm;
import std.format;

struct Color {
    ubyte r;
    ubyte g;
    ubyte b;

    private bool isTerminal;

    this(ubyte r, ubyte g, ubyte b) {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    private this(bool isTerminal) {
        this.isTerminal = isTerminal;
    }

    static Color Red = Color(255, 0, 0);
    static Color Green = Color(0, 255, 0);
    static Color Blue = Color(0, 0, 255);

    // Credits go to https://sashamaps.net/docs/resources/20-colors/

    static Color Maroon = Color.fromHex("800000");
    static Color Brown = Color.fromHex("9a6324");
    static Color Olive = Color.fromHex("808000");
    static Color Teal = Color.fromHex("469990");
    static Color Navy = Color.fromHex("000075");
    static Color Black = Color.fromHex("000000");
    static Color Orange = Color.fromHex("f58231");
    static Color Yellow = Color.fromHex("ffe119");
    static Color Lime = Color.fromHex("bfef45");
    static Color Cyan = Color.fromHex("42d4f4");
    static Color Purple = Color.fromHex("911eb4");
    static Color Magenta = Color.fromHex("f032e6");
    static Color Gray = Color.fromHex("a9a9a9");
    static Color Pink = Color.fromHex("fabed4");
    static Color Apricot = Color.fromHex("ffd8b1");
    static Color Biege = Color.fromHex("fffac8");
    static Color Mint = Color.fromHex("aaffc3");
    static Color Lavender = Color.fromHex("dcbeff");
    static Color White = Color.fromHex("ffffff");

    static Color terminal() {
        return Color(true);
    }

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

    private static string doubleToHex(int num) {
        char[] hex;

        for (int i = num; num != 0; num /= 16) {
            int remainder = num % 16;

            if (remainder > 9) {
                hex ~= cast(char)(('A') + (remainder - 10));
            } else {
                hex ~= cast(int)(remainder + '0');
            }
        }

        return hex.reverse().idup;
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

        ubyte r = cast(ubyte)Color.hexToDouble(hex[0..2]);
        ubyte g = cast(ubyte)Color.hexToDouble(hex[2..4]);
        ubyte b = cast(ubyte)Color.hexToDouble(hex[4..6]);

        return Color(r, g, b);
    }

    string toHex(bool printHashtag = true) {
        string r0 = "";

        if (doubleToHex(r).length < 2) {
            r0 = "0";
        }

        string g0 = "";

        if (doubleToHex(g).length < 2) {
            g0 = "0";
        }

        string b0 = "";

        if (doubleToHex(b).length < 2) {
            b0 = "0";
        }

        string hex = r0 ~ doubleToHex(r) ~ g0 ~ doubleToHex(g) ~ b0 ~ doubleToHex(b);

        if (printHashtag) {
            return '#' ~ hex;
        }

        return hex;
    }
}
