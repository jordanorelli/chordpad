public class Chord
{
    float tonic;
    float tones[];

    fun float[] set(float _tonic, int intervals[])
    {
        float _tones[intervals.size()];
        for(0 => int i; i < intervals.size(); i++)
        {
            _tonic * Math.pow(ToneCalc.step(12), intervals[i]) => _tones[i];
        }
        _tonic => tonic;
        _tones @=> tones;
        return tones;
    }
}
