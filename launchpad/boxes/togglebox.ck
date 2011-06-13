public class ToggleBox extends Box
{
    int selectedColor;
    int unselectedColor;
    int selectedX;
    int selectedY;

    fun void init(Launchpad @ _lp, int _x, int _y, int _width,
                  int _height, int _selectedColor, int _unselectedColor)
    {
        init(_lp, _x, _y, _width, _height);
        _selectedColor => selectedColor;
        _unselectedColor => unselectedColor;
        for(x => int i; i < x + width; i++)
        {
            for(y => int j; j < y + height; j++)
            {
                lp.setGridLight(i, j, unselectedColor);
            }
        }
    }

    fun void handle(int column, int row, int velocity)
    {
        if(velocity == 127)
        {
            lp.setGridLight(x + selectedX, y + selectedY, unselectedColor);
            lp.setGridLight(x + column, y + row, selectedColor);
            column => selectedX;
            row => selectedY;
        }
        e.set(column, row, velocity);
        e.broadcast();
    }
}
