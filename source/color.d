module color;

struct Color {
    const int r;
    const int g;
    const int b;

    static const Color Red = Color(255, 0, 0);
    static const Color Green = Color(0, 255, 0);
    static const Color Blue = Color(0, 0, 255);
}
