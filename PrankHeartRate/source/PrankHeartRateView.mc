import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Math;
import Toybox.Timer;

class PrankHeartrateView extends WatchUi.View {

    private var _heartRateElement;
    private var test;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        var _heartRate;
        _heartRateElement = findDrawableById("heart_rate");
        _heartRate = chooseStartValue();
        test = _heartRate;

        var _timer = new Timer.Timer();
        _timer.start(method(:updateHeartRate), 2000, true);
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

    // Chooses the initial heart rate between the minimum and maximum
    function chooseStartValue() {

        var _heartRate = getRandNum(75,100);

        displayHeartRate(_heartRate);
        return _heartRate;
    }

    function getRandNum(low, high) {
        var RAND_MAX = 0x7FFFFFFF;
        var value = low + Math.rand() / (RAND_MAX / (high - low + 1) + 1);
        return value;
    }


    // Adds 1-3 to the current heart rate
    function updateHeartRate() as Void {
        var increment = getRandNum(-3,7);
        var _heartRate = test;
        System.println(_heartRate);
        
        test = test + increment;
        displayHeartRate(test);
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
