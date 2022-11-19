module color;

struct Color {
    int r;
    int g;
    int b;

    static Color Red = Color(255, 0, 0);
    static Color Green = Color(0, 255, 0);
    static Color Blue = Color(0, 0, 255);
}
