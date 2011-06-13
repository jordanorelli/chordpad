public class BoxEvent extends Event
{
    int column;
    int row;
    int velocity;

    fun void set(int _column, int _row, int _velocity)
    {
        _column => column;
        _row => row;
        _velocity => velocity;
    }
}
