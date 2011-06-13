public class Chord
{
    float tonic;
    float tones[];
    int intervals[];

    fun float[] set(float _tonic, int _intervals[])
    {
        float _tones[_intervals.size()];
        for(0 => int i; i < _intervals.size(); i++)
        {
            _tonic * Math.pow(ToneCalc.step(12), _intervals[i]) => _tones[i];
        }
        _tonic => tonic;
        _tones @=> tones;
        _intervals @=> intervals;
        return tones;
    }

    fun float[] setTonic(float _tonic)
    {
        float _tones[intervals.size()];
        for(0 => int i; i < intervals.size(); i++)
        {
            _tonic * Math.pow(ToneCalc.step(12), intervals[i]) => _tones[i];
        }
        _tones @=> tones;
        _tonic => tonic;
        return tones;
    }

    fun float[] setQuality(int _intervals[])
    {
        float _tones[_intervals.size()];
        for(0 => int i; i < _intervals.size(); i++)
        {
            tonic * Math.pow(ToneCalc.step(12), _intervals[i]) => _tones[i];
        }
        _tones @=> tones;
        _intervals @=> intervals;
        return tones;
    }
}
