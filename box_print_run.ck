/*
Copyright (C) 2011 by Jordan Orelli

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
fun string prompt(string msg)
{
    ConsoleInput cin;
    cin.prompt(msg) => now;
    StringTokenizer tok;
    string response;
    while(cin.more()) {
        tok.set(cin.getLine());
        while(tok.more()) {
            tok.next() => response;
        }
    }
    return response;
}

int midiChannel;
int x;
int y;
int width;
int height;
if(me.args() > 0) {
    Std.atoi(me.arg(0)) => midiChannel;
} else {
    Std.atoi(prompt("Enter Midi port #: ")) => midiChannel;
    Std.atoi(prompt("X: ")) => x;
    Std.atoi(prompt("Y: ")) => y;
    Std.atoi(prompt("Width: ")) => width;
    Std.atoi(prompt("Height: ")) => height;
}

Launchpad.Launchpad(midiChannel) @=> Launchpad lp;
Box b;
b.init(lp, x, y, width, height);
while(true) {
    100::ms => now;
}
