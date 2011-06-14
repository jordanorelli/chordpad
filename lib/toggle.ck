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
ToggleBox rateSelect;
rateSelect.init(lp, 0, 7, 8, 1, LaunchpadColor.red, 0);
// ToggleBox inversionSelect;
// inversionSelect.init(lp, 4, 2, 4, 1, LaunchpadColor.yellow, 0);
ToggleBox octaveSelect;
octaveSelect.init(lp, 0, 3, 8, 1, LaunchpadColor.orange, 0);

Chord chord;
chord.set(baseFreq, ChordQuality.M);
SinOsc @ ugens[4];
Gain g;
ADSR adsr;
for(0 => int i; i < ugens.size(); i++)
{
    SinOsc s;
    0.8 => s.gain;
    0 => s.op;
    s => g;
    s @=> ugens[i];
}
g => adsr => dac;


1::minute / 120.0 => dur rootBeat;
rootBeat => dur beat;
2.0 => float duty;
adsr.set(beat / 10 / duty, beat / 4 / duty, 0.20, beat / 4 / duty);
false => int pulseEnabled;
fun void pulse()
{
    while(true)
    {
        beat - (now % beat) => now;
        adsr.keyOn();
        beat / duty => now;
        adsr.keyOff();
    }
}

fun void rateSelectHandler(BoxEvent e)
{
    while(true)
    {
        e => now;
        if(e.velocity == 127)
        {
            rootBeat / (e.column + 1) => beat;
            adsr.set(beat / 10 / duty, beat / 4 / duty, 0.2, beat / 4 / duty);
        }
    }
}

fun void octaveSelectHandler(BoxEvent e)
{
    while(true)
    {
        e => now;
        if(e.velocity == 127)
        {
            ToneCalc.grid(tonicSelect.width, tonicSelect.height, 1, tonicSelect.width,
            baseFreq * Math.pow(ToneCalc.step(12), 12 * (e.column - 4)), 12) @=> tones;
            chord.setTonic(tones[tonicSelect.selectedX][tonicSelect.selectedY]);
            setTones(ugens, chord.tones);
        }
    }
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
    [[ChordQuality.m, ChordQuality.dim,  ChordQuality.m7b5, ChordQuality.m7],
     [ChordQuality.M, ChordQuality.aug3, ChordQuality.dom7, ChordQuality.M7]]
     @=> int qualityMap[][][];

    while(true)
    {
        e => now;
        if(e.velocity == 127)
        {
            chord.setQuality(qualityMap[e.row][e.column]);
            setTones(ugens, chord.tones);
        }
    }
}

spork ~ pulse();
spork ~ tonicSelectHandler(tonicSelect.e);
spork ~ qualitySelectHandler(qualitySelect.e);
spork ~ octaveSelectHandler(octaveSelect.e);
spork ~ rateSelectHandler(rateSelect.e);
while(true)
{
    100::ms => now;
}
