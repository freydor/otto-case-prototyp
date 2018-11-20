include <defaults.scad>;
use <Polygon.scad>;

module Nut(
  h=10,
  l=10,
  A=10,
  d=5,
  tolerance=default_metric_tolerance,
  extra_tolerance=default_bolt_extra_tolerance,
  inset=1
) {
  r = d/2;  
  translate([0, 0, -h/2+0.01+((1-inset)*h)])
  Hexagon(
    A=A+tolerance,
    h=h+tolerance*2
  );
    
    translate([0, 0, -l+0.01])
    cylinder(r=r+tolerance*2+extra_tolerance, h=l+0.01);
}
