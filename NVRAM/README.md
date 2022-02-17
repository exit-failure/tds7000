# Resoring NVRAM Setting when the Backup Battery has run empty

## Replacing the Battery

Since the Power modules from Dallas aren't available any more I modified the existing one for easier battery replcement in the future.

1. Remove the Power module from the NVRAM:

2. Remove the old battery:  
   The tabs are spot welded to the button cell. In my case they felt like they were very firmly attached to the battery I just drilled out the spot welds with a 1mm drill bit and a dremel. After that I was able to take out the battery.

3. Attaching a battery holder the the Power module:

4. Put the Power module back on top of the NVRAM:

## Attaching the cables for serial communication

## NVRAM Settings

TODO: Notice about line breaks in serial console

The following table shows the right settings for a TDS7104 other models may require other settings but I would expect them to be the same.

| setting name | value |
| ----------- | ----------- |
| boot device | sm |
| processor number | 0 |
| host name | host |
| file name | c:/vxBoot/vxWorks.st |
| inet on ethernet (e) | 192.168.0.2:ffffff00 |
| inet on backplane (b) | 192.168.0.1:ffffff00 |
| host inet (h) | 192.168.0.2 |
| gateway inet (g) | 192.168.0.1 |
| user (u) | anonymous |
| flags (f) | 0x1008 |
| target name (tn) | tds7000 |
| startup script (s) | c:/vxboot/topScript.hw |
| other (o) | nvfs0x1008 |
