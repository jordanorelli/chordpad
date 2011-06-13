// fun void setTones(float tonic, int intervals[], SinOsc @ _ugens[])
fun void setTones(SinOsc @ _ugens[], float tones[])
{
    for(0 => int i; i < _ugens.size(); i++)
    {
        if(tones.size() > i)
        {
            tones[i] => _ugens[i].freq;
            1 => _ugens[i].op;
        }
        else
        {
            0 => _ugens[i].op;
        }
    }
}

261.62556609 => float baseFreq;

Launchpad.Launchpad(0) @=> Launchpad lp;
ToggleBox tonicSelect;
tonicSelect.init(lp, 0, 0, 4, 3, LaunchpadColor.red, 0);

float tones[tonicSelect.width][tonicSelect.height];
ToneCalc.grid(tonicSelect.width, tonicSelect.height, 1, tonicSelect.width,
              baseFreq, 12) @=> tones;

ToggleBox qualitySelect;
qualitySelect.init(lp, 4, 0, 4, 2, LaunchpadColor.orange, 0);
ToggleBox inversionSelect;
inversionSelect.init(lp, 4, 2, 4, 1, LaunchpadColor.yellow, 0);
ToggleBox octaveSelect;
octaveSelect.init(lp, 0, 3, 8, 1, LaunchpadColor.orange, 0);

Chord chord;
chord.set(baseFreq, ChordQuality.M);
SinOsc @ ugens[4];
for(0 => int i; i < ugens.size(); i++)
{
    SinOsc s;
    0 => s.op;
    s => dac;
    s @=> ugens[i];
}

fun void tonicSelectHandler(BoxEvent e)
{
    while(true)
    {
        e => now;
        if(e.velocity == 127)
        {
            chord.setTonic(tones[e.column][e.row]);
            setTones(ugens, chord.tones);
        }
    }
}

fun void qualitySelectHandler(BoxEvent e)
{
    [[ChordQuality.m, ChordQuality.dim, ChordQuality.m7b5, ChordQuality.m7],
     [ChordQuality.M, ChordQuality.aug3, ChordQuality.dom7, ChordQuality.M7]]
     @=> int qualityMap[][][];

    chout <= qualityMap.size() <= IO.newline();
    chout <= qualityMap[0].size() <= IO.newline();
    chout <= qualityMap[0][0].size() <= IO.newline();
    while(true)
    {
        e => now;
        if(e.velocity == 127)
        {
            chout <= e.column <= "\t" <= e.row <= IO.newline();
            chord.setQuality(qualityMap[e.row][e.column]);
            setTones(ugens, chord.tones);
        }
    }
}

spork ~ tonicSelectHandler(tonicSelect.e);
spork ~ qualitySelectHandler(qualitySelect.e);
while(true)
{
    100::ms => now;
}
