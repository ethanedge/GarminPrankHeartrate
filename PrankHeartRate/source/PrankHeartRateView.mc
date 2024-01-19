import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Math;
import Toybox.Timer;

class PrankHeartRateView extends WatchUi.View {

    const RAND_MAX = 0x7FFFFFFF;

    // The range in which the heart rate starts between
    const LOW_START = 75;
    const HIGH_START = 100;

    // The range is which the heart rate increments by
    const LOW_INCREMENT = -3;
    const HIGH_INCREMENT = 8;


    private var _heartRateElement;
    private var _heartRate;


    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _heartRateElement = findDrawableById("heart_rate");
        _heartRate = chooseStartValue();

        var _timer = new Timer.Timer();
        _timer.start(method(:incrementHeartRate), 2000, true);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // Chooses the initial heart rate between the LOW_START and HIGH_START (inclusive)
    function chooseStartValue() {

        var _heartRate = getRandNum(LOW_START, HIGH_START);

        displayHeartRate(_heartRate);
        return _heartRate;
    }

    // Get a random number between the low and high value (inclusive)
    function getRandNum(low, high) {

        var value = low + Math.rand() / (RAND_MAX / (high - low + 1) + 1);
        return value;
    }


    // Adds a value between the LOW_INCREMENT and HIGH_INCREMENT (inclusive) to the current heart rate
    function incrementHeartRate() as Void {
        var increment = getRandNum(LOW_INCREMENT, HIGH_INCREMENT);

        _heartRate += increment;
        displayHeartRate(_heartRate);
    }


    // Displays the heart rate and color
    function displayHeartRate(_heartRate) {        
        var label;
        var color;
        
        if (_heartRate < 100) {
            color = Graphics.COLOR_DK_GREEN;
        }
        else if (_heartRate >= 100 and _heartRate <= 125) {
            color = Graphics.COLOR_YELLOW;
        }
        else if (_heartRate > 125 and _heartRate <= 150) {
            color = Graphics.COLOR_ORANGE;
        }
        else {
            color = Graphics.COLOR_RED;
        }

        label = _heartRate.toString() + " BPM";

        _heartRateElement.setText(label);
        _heartRateElement.setColor(color);

        WatchUi.requestUpdate();
    }

}
