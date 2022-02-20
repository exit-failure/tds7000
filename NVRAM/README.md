# Replacing the Backup Battery and restoring NVRAM Settings when the Battery has run empty

## Replacing the Battery

TODO: Insert Photos

Since the Power modules from Dallas aren't available any more I modified the existing one for easier battery replcement in the future.

1. Remove the PowerCap module from the NVRAM:  

   <img src="powercap_1.jpg" height="400" />

   Push a small screwdriver into the slit on the side of the PowerCap module and lever it off. You do __not__ need a lot of froce for that.  

   <img src="powercap_1_5.jpg" height="400" /> <img src="powercap_2.jpg" height="400" />

2. Remove the old battery:  
   The tabs are spot welded to the button cell. In my case they felt like they were very firmly attached to the battery I just drilled out the spot welds with a 1mm tungsten carbide drill bit and a dremel. After that I was able to take out the battery.
   <img src="powercap_3.jpg" width="400" />

3. Attaching a battery holder to the PowerCap module:  
   I glued a CR2032 holder to the top of the module and solder wires between the battery holder and the PCB on the underside. I had to cut small slits into the sides of the plastic housing to be able to route the wires properly. Otherwise the module won't clip back onto the NVRAM.  

   <img src="powercap_4.jpg" height="400" /> <img src="powercap_5.jpg" height="400" />

4. Put the Power module back on top of the NVRAM:  

   <img src="powercap_6.jpg" height="400" />

## Restore NVRAM Settings

### 1. Get yourself a PC with a serial interface ot a USB to serial interface

### 2. Connect the scope to the serial interface:

You can use a standard 10-pin IDC to DB9 adapter. ___Notice that there are two types that are wired up differently.___ The one that is required here is the older style (DTK/INTEL style). The new style (AT/EVEREX style) is not suitable for our task.  If you are using such an adapter, please make sure that the pinout matches the one in the table below.  If you do not have an adapter at hand connect, just use a couple of jumper wires. This works just as well. You should only have to connect the following lines:

#### The Pinout of the scope is as follows

<img src="pinout_tds7000.jpg" height="300" />

| PIN TDS7000 (10 pin IDC )|signal|description |
|--|--|--|
|1|DCD|Data Carrier Detect|
|2|DSR|Data Set Ready|
|3|RX|Receive Data|
|4|RTS|Request to Send|
|5|TX|Transmit Data|
|6|CTS|Clear to Send|
|7|DTR|Data Terminal Ready|
|8|RI|Ring Indicator|
|9|GND|System Ground|
|10|not connected|---|

#### The pinout of a standard female serial port (the type you find on a PC) is as follows

<img src="pinout_serial.jpg" height="300" />

|PIN female DB9 (serial)|signal|
| -- | -- |
|1|DCD|
|2|RX|
|3|TX|
|4|DTR|
|5|GND|
|6|DSR|
|7|RTS|
|8|CTS|
|9|RI|

### 3. Connect to the serial interface with a terminal software of your liking.  

* I used [Tera Term](https://osdn.net/projects/ttssh2/releases/). Tera Term should come with the correct serial port settiongs out of the box. If you want to check, you can find the seetings under `Setup` -> `Serial Port...`.  
* For Linux I often use [CuteCom](http://cutecom.sourceforge.net/) if I want something with a graphical user interface.
*  I usually use [HTerm](https://www.der-hammer.info/ages/terminal.html) but for some reason the communication didn't work properly after sending a random character to interrupt the boot process.  

The required settings for the serial interface are:

|setting|value|
|--|--|
|baud rate|9600|
|data bits|8|
|stop bits|1|
|parity|none|
|flow control|no|

* Please note that you need to reinstall the upper main board again. Otherwise the scope will not turn on.
* Start your terminal software and connect to the serial port. After that start your scope.
* When the countdown appears send any character to interrupt the startup process.
* Send `?` to display the main menu.

### 4. Set the settings to their proper values:

In the main menu send `c` to get into the configuration dialog.
The following table shows the right settings for a TDS7104 other models may require other settings but I would expect them to be the same.

| setting name | value |
| -- | -- |
| boot device |sm|
| processor number |0|
| host name |host|
| file name |c:/vxBoot/vxWorks.st|
| inet on ethernet (e) |192.168.0.2:ffffff00|
| inet on backplane (b) |192.168.0.0:ffffff00|
| host inet (h) |192.168.0.1|
| gateway inet (g) |192.168.0.2|
| user (u) | anonymous |
| ftp password (pw) |anonymous|
| flags (f) |0x1000|
| target name (tn) |tds7000|
| startup script (s) |c:/vxBoot/topScript.hw|
| other (o) |nvfs=0x1000|

Go through the list and enter the right values. Send `.` to clear options that have wrong balues set and enter the options menu again after you are through to set the option. Go through the menu one last time to make sure everything is set correctly.

When you're done send an `@` to continue booting the scope when the scope software splash screen is already showing. Otherwise switch the scope off, make sure that Windows boots correctly and turn it back on again. The scope software should now start without a problem.

## Troubleshooting

* If you have trouble using the menu properly because the menu always seems to skip every other option, try chaning the line break characters, your terminal software sends after pressing enter. If it is set to send `\r` (carriage return) __AND__ `\n` (line feed) try instead using __only one__ or the other.
