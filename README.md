# GUI applocation for liquid volume measurement in a glass
This is a MATLAB implementation of a GUI application that allows loquid volume estimation by sound in real time

## IMPORTANT NOTE
For me, the applocation works well in matlab of version ```2020_b```. There may be some problems with newer MATLAB versions. For example, it didn't work well in ```2022_a```.


## Prediction methods
For the description of math inside, look at ```peoject_report.pdf``` file.

## Usage
The GUI looks like this:
![Screenshot](https://user-images.githubusercontent.com/35429810/211539550-32d63cbc-8eaa-4fcb-b883-6fb6590922ba.png)

On the right panel sound signal in time and frequency domains is displayed in real time.
Beneath plots, two gauges are showing current estimation of volume if calibration was already performed

### Calibration
Before calibration, some glass parameters should be entered on the left panel:
* Glass volume
* Glass height if method 2 is used too (```use glass shape for calibration``` checkbox checked)
* Values next to checked checkboxes if some glass parameters should be fixed

It is also important to note that for calibration, a measurements with 0 volume always MUST be present.

For calibration, 2 methods may be used:
* Calibration from file. Some example ```csv``` files are present in this repository. To do so, just click on ```read points from file``` button and select a file.
* Real time. For this, enter current liquid volume in the field, start rubbing the glass and click ```Add calibration point``` button when the sound is loud and clear.
This will add a calibration point to the list. If something is measured wrong, just delete the point and measure once more.
After a sufficient number of points are added, click ```Calibrate``` button to perform calibration.

After calibration, its result is shown on plot on the left. There, circles are measurements, red curve is prediction by method 1 and blue curve is the prediction
by method 2.
