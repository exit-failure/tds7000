# Replacing the Backup Battery and Restoring NVRAM Settings when the Battery has run empty

## Replacing the Battery

TODO: Insert Photos

Since the Power modules from Dallas aren't available any more I modified the existing one for easier battery replcement in the future.

1. Remove the Power module from the NVRAM:

2. Remove the old battery:  
   The tabs are spot welded to the button cell. In my case they felt like they were very firmly attached to the battery I just drilled out the spot welds with a 1mm drill bit and a dremel. After that I was able to take out the battery.

3. Attaching a battery holder the the Power module:

4. Put the Power module back on top of the NVRAM:

## Restore NVRAM Settings

### 1. Get yourself a PC with a serial interface ot a USB to serial interface

### 2. Connect the scope to the serial interface:

You can use a standard 10-pin IDC to DB9 adapter. If you do not have one at hand connect the TODO: pins.

The Pinout of the scope is as follows:

TODO: Insert Images

| PIN TDS7104 | description |
| -- | -- |
|1|DCD|
|2||
|3||
|4||
|5||
|6||
|7||
|8||
|9||
|10||

The pinout of a standard female serial port (the type you find on a PC) is as follows:

PIN female DB9 connector | description |
| -- | -- |
|1||
|2||
|3||
|4||
|5||
|6||
|7||
|8||
|9||

### 3. Connect to the serial interface with a terminal software of your liking.  

* I used [Tera Term](https://osdn.net/projects/ttssh2/releases/). Tera Term should come with the correct serial port settiongs out of the box. If you want to check, you can find the seetings under `Setup` -> `Serial Port...`.  
* For Linux I ofen use [CuteCom](http://cutecom.sourceforge.net/) if I want something with a graphical user interface.
*  I usually use [HTerm](https://www.der-hammer.info/ages/terminal.html) but for some reason the communication didn't work properly after sending a random character to interrupt the boot process.  

The required settings for the serial interface are:

|setting|value|
|--|--|
|baud rate|9600|
|data bits|8|
|stop bits|1|
|parity|none|
|flow control|no|

* Please note that you reinstall the upper main board again. Otherwise the scope will not turn on.
* Start your terminal software and connect to the serial port. After that start your scope.
* When the countdown appears send any character to interrupt the startup process.
* Send `?` to display the main menu.

### 4. Set the settings to their proper values:

In the main menu press `c` to get into the configuration dialog.
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
