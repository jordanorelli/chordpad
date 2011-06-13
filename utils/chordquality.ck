public class ChordQuality
{
    static int M7[];      // major 7
    static int dom7[];    // dominant 7
    static int aug3[];    // augmented triad
    static int M[];       // major
    static int m[];       // minor
    static int dim[];     // diminished
    static int m7b5[];    // minor 7 flat 5 (half diminished)
    static int m7[];      // diminished seventh (fully diminished)
}

[0, 4, 7, 11] @=> ChordQuality.M7;
[0, 4, 7, 10] @=> ChordQuality.dom7;
[0, 4, 8] @=> ChordQuality.aug3;
[0, 4, 7] @=> ChordQuality.M;
[0, 3, 7] @=> ChordQuality.m;
[0, 3, 6] @=> ChordQuality.dim;
[0, 3, 6, 10] @=> ChordQuality.m7b5;
[0, 3, 6, 9] @=> ChordQuality.m7;
