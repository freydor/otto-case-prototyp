                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:1802332
Nut and Bolt Cutouts M2 + M3 (OpenSCAD Library) by brianjorgensen is licensed under the Creative Commons - Attribution - Share Alike license.
http://creativecommons.org/licenses/by-sa/3.0/

# Summary

Please see the [GitHub repository](https://github.com/b33j0r/Metric).

# Nut and Bolt Cutouts

This library provides printable profiles of nuts and bolts. Currently, it includes M2 and M3 profiles.

The tolerance and part constants are based on empirical measurements from a digital caliper, using machine head metric nuts/screws/bolts, and from prints on my QIDI printer with various ABS filaments.

A calibration object for tuning this to your hardware is included as `MetricCalibrationPlate.scad`.

In my case, I have found that a tolerance (extra space around edges of profiles) of 0.1 millimeters results in tight fitting parts that aren't difficult to insert, and 0.2 millimeters results in a loose fitting part.

## Usage

The intended usage is to use this library for `difference` cutouts:

```scad
use <Metric/M3.scad>;

$fs = 0.5;
$fa = 2;

w = 10;
h = 10;

difference() {
  translate([-w/2, -w/2, -h])
  cube([w, w, h]);

  BoltM3(l=15);
}
```

![cube with inset bolt](https://raw.githubusercontent.com/b33j0r/Metric/master/static/images/cube-bolt-inset.png)

# Inset

By default, all parts have their origin extending in the negative Z direction, with the head of the part at [0, 0, 0]. You can place the head above the X-Y plane by specifying the optional parameter `inset=0`

```scad
use <Metric/M3.scad>;

$fs = 0.5;
$fa = 2;

w = 10;
h = 10;

difference() {
  translate([-w/2, -w/2, -h])
  cube([w, w, h]);

  BoltM3(l=15, inset=0);
}
```

![cube without inset bolt](https://raw.githubusercontent.com/b33j0r/Metric/master/static/images/cube-bolt-no-inset.png)

# Parts

```scad
use <Metric/M3.scad>;
use <Metric/M2.scad>;

$fs = 0.5;
$fa = 2;

BoltM3();

translate([0, -10, 0])
NutM3();

translate([10, 0, 0])
BoltM2();

translate([10, -10, 0])
NutM2();
```

## Inset
![Inset](https://raw.githubusercontent.com/b33j0r/Metric/master/static/images/inset.png)

## No Inset
![No Inset](https://raw.githubusercontent.com/b33j0r/Metric/master/static/images/no-inset.png)