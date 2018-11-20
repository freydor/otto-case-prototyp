/*  Bolts and Nuts OpenSCAD Library
    Copyright (C) 2015 Cristiano Gariboldo - Pixel3Design.it

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

use <threads.scad>;

function hex_dia(dia) = dia * ( 2 / sqrt (3) );

render = 1; // Set render at 1 to preview types, set to 0 otherwise.

if ( render == 1 ) {
    allen_bolt (10, 3, 3.5, 5.5, 3, 0.2, 32, 2.5, "metric", 0.425);
   // translate ([10, 0, 0]) hex_bolt (3/8, 2/8, 1/8, 3/8, 1/128, 32, "imperial", 28);
    //translate ([20, 0, 0]) grub_bolt (4, 3, 3, 0.2, 32, 1.5, "metric", 0.425);
   // translate ([30, 0, 0]) cone_head_bolt (10, 3, 1.5, 5.5, 2, 0.2, 32, 2, "metric", 0.425);
    //translate ([0, 10, 0]) hex_nut (1/8, 2/8, 3/8, 1/128, 32, "imperial", 28);
}


echo ((1/8)*25.4);


module hex_nut (height, thread_d, size, tolerance, quality, thread, pitch) {
    difference () {
        $fn = 6;
        if ( thread ) {
            if ( thread == "metric" ) {
                cylinder (r = hex_dia (size - tolerance) / 2, h = height);
            } 
            if ( thread == "imperial" ) {
                size = size * 25.4;
                height = height * 25.4;
                tolerance = tolerance * 25.4;
                cylinder (r = hex_dia (size - tolerance) / 2, h = height);
            }
        }
        if ( thread ) {
            if ( thread == "metric" ) {
                $fn = quality;
                translate ([0, 0, -1]) metric_thread (thread_d + tolerance, pitch, height + 2);
            } 
            if ( thread == "imperial" ) {
                $fn = quality ;
                translate ([0, 0, -1]) english_thread (thread_d + tolerance, pitch, height + (1/10));
            }
        } else {
            $fn = quality / 2;
            translate ([0, 0, -1]) cylinder (r = (thread_d + tolerance) / 2, height + 2);
        }
    }
}

module grub_bolt (lenght, thread_d, a_depth, tolerance, quality, allen_o, thread, pitch) {
    difference () {
        union () {
            if ( thread ) {
                if ( thread == "metric" ) {
                    $fn = quality;
                    metric_thread (thread_d - tolerance, pitch, lenght);
                }
                if ( thread == "imperial" ) {
                    $fn = quality;
                    english_thread (thread_d - tolerance, pitch, lenght);
                }
            } else {
                $fn = quality / 2;
                cylinder (r = (thread_d - tolerance) / 2, h = lenght);
            }
        }
        if ( allen_o ) {
            $fn = 6;
            if ( thread ) {
                if ( thread == "metric" ) {
                    translate ([0, 0, lenght - a_depth + 0.5]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
                if ( thread == "imperial" ) {
                    lenght = lenght * 25.4;
                    a_depth = a_depth * 25.4;
                    allen_o = allen_o * 25.4;
                    tolerance = tolerance * 25.4;
                    translate ([0, 0, lenght - a_depth + 0.5]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
            } else {
                
                    translate ([0, 0, lenght - a_depth + 0.5]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
            }
        }
    }
}

module hex_bolt (lenght, thread_d, head_h, head_d, tolerance, quality, thread, pitch) {
    union () {
        if ( thread ) {
            if ( thread == "metric" ) {
                $fn = quality;
                metric_thread (thread_d - tolerance, pitch, lenght);
            }
            if ( thread == "imperial" ) {
                $fn = quality;
                english_thread (thread_d - tolerance, pitch, lenght);
            }
        } else {
            $fn = quality / 2;
            cylinder (r = (thread_d - tolerance) / 2, h = lenght);
        }
        $fn = 6;
        if ( thread ) {
            if ( thread == "imperial" ) {
                lenght = lenght * 25.4;
                head_d = head_d * 25.4;
                head_h = head_h * 25.4;
                tolerance = tolerance * 25.4;
                translate ([0, 0, lenght]) cylinder (h = head_h - tolerance, r = hex_dia (head_d - tolerance) / 2);
            }
            if ( thread == "metric" ) {
                translate ([0, 0, lenght]) cylinder (h = head_h - tolerance, r = hex_dia (head_d + tolerance) / 2);
            }
        } else {
            translate ([0, 0, lenght]) cylinder (h = head_h - tolerance, r = hex_dia (head_d + tolerance) / 2);
        } 
    }   
}

module cone_head_bolt (lenght, thread_d, head_h, head_d, a_depth, tolerance, quality, allen_o, thread, pitch) {
    difference () {
        union () {
            if ( thread ) {
                if ( thread == "metric" ) {
                    $fn = quality;
                    metric_thread (thread_d - tolerance, pitch, lenght);
                }
                if ( thread == "imperial" ) {
                    $fn = quality;
                    english_thread (thread_d - tolerance, pitch, lenght);
                }
            } else {
                $fn = quality / 2;
                cylinder (r = (thread_d - tolerance) / 2, h = lenght);
            }
            if ( thread ) {
                if ( thread == "imperial" ) {
                    $fn = quality / 2;
                    thread_d = thread_d * 25.4;
                    head_d = head_d * 25.4;
                    head_h = head_h * 25.4;
                    tolerance = tolerance * 25.4;
                    translate ([0, 0, lenght]) cylinder (r1 = thread_d / 2, r2 = (head_d - tolerance) / 2, h = head_h + tolerance);
                }
                if ( thread == "metric" ) {
                    $fn = quality / 2;
                    translate ([0, 0, lenght]) cylinder (r1 = thread_d / 2, r2 = (head_d - tolerance) / 2, h = head_h + tolerance);
                }
            } else {
                translate ([0, 0, lenght]) cylinder (r1 = thread_d / 2, r2 = (head_d - tolerance) / 2, h = head_h + tolerance);
            }
        }
        if ( allen_o ) {
            $fn = 6;
            if ( thread ) {
                if ( thread == "imperial" ) {
                    lenght = lenght * 25.4;
                    head_h = head_h * 25.4;
                    a_depth = a_depth * 25.4;
                    allen_o = allen_o * 25.4;
                    tolerance = tolerance * 25.4;
                    translate ([0, 0, (lenght + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
                if ( thread == "metric" ) {
                    translate ([0, 0, (lenght + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
            } else {
                translate ([0, 0, (lenght + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
            }
        }
    }
}

module allen_bolt (lenght, thread_d, head_h, head_d, a_depth, tolerance, quality, allen_o, thread, pitch) {
    difference () {
        union () {
            if ( thread ) {
                if ( thread == "metric" ) {
                    $fn = quality;
                    metric_thread (thread_d - tolerance, pitch, lenght);
                }
                if ( thread == "imperial" ) {
                    $fn = quality;
                    english_thread (thread_d - tolerance, pitch, lenght);
                }
            } else {
                $fn = quality / 2;
                cylinder (r = (thread_d - tolerance) / 2, h = lenght);
            }
            $fn = quality / 2;
            translate ([0, 0, lenght]) cylinder (h = head_h - tolerance, r = (head_d - tolerance) / 2);
        }
        if ( allen_o ) {
            $fn = 6;
            if ( thread ) {
                if ( thread == "imperial" ) {
                    lenght = lenght * 25.4;
                    head_h = head_h * 25.4;
                    a_depth = a_depth * 25.4;
                    allen_o = allen_o * 25.4;
                    tolerance = tolerance * 25.4;
                    translate ([0, 0, (lenght + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
                if ( thread == "metric" ) {
                    translate ([0, 0, (lenght + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
                }
            } else {
                translate ([0, 0, (lenght + head_h) - (a_depth - 0.5)]) cylinder (h = a_depth, r = hex_dia (allen_o + tolerance) / 2);
            }
        }
    }
}
