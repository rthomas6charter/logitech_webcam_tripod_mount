use <threads.scad>;

inchesPerMillimeter=0.03937008;

cameraBracketCenterThickness=13;
cameraBracketWidth=38;

lowerThickness=5;

sideThickness=6;


bracketDepth=33;
bracketSideRadius=6.4;
bracketBumpRadius=2.25;
bracketBumpCenterToCenter=28;
cornerRoundnessRadius=3;

screwMountBodyDepth=bracketDepth*2/3;

screwMountDepth=9;
screwMountDepthInches=screwMountDepth*inchesPerMillimeter;

outerWidth=cameraBracketWidth+sideThickness*2;
screwMountBodyWidth=outerWidth*2/3;
bracketReceiverHeight=lowerThickness*2+cameraBracketCenterThickness;
outerHeight=bracketReceiverHeight+screwMountDepth;

overlap=0.01;
$fn=50;

difference() {
    union() {
        hull() {
            hullPlate(outerWidth, bracketDepth, cornerRoundnessRadius);
            translate([0,0,bracketReceiverHeight-cornerRoundnessRadius*2])
                hullPlate(outerWidth, bracketDepth, cornerRoundnessRadius);
        }
        translate([(outerWidth-screwMountBodyWidth)/2,(bracketDepth-screwMountBodyDepth)/2,bracketReceiverHeight])
            hull() {
                translate([0,0,-overlap])
                    cube([screwMountBodyWidth, screwMountBodyDepth, 1]);
                translate([0,0,screwMountDepth-cornerRoundnessRadius*2])
                    hullPlate(screwMountBodyWidth, screwMountBodyDepth, cornerRoundnessRadius);
            }
    }
    translate([outerWidth/2,bracketDepth/2,outerHeight-screwMountDepth+overlap*2])
        english_thread(0.25, 20, screwMountDepthInches, internal=true, leadin=1);
    translate([outerWidth/2,0,(outerHeight-screwMountDepth)/2]) {
        cameraBracketShape();
    }
}


module cameraBracketShape() {
    translate([0,-overlap,0]) rotate([-90,0,0])
    union() {
        hull() {
            translate([-cameraBracketWidth/2+bracketSideRadius,0,0])
                cylinder(r=bracketSideRadius, h=bracketDepth+overlap*2);
            translate([cameraBracketWidth/2-bracketSideRadius,0,0])
                cylinder(r=bracketSideRadius, h=bracketDepth+overlap*2);
        }
        translate([-bracketBumpCenterToCenter/2,-bracketSideRadius+bracketBumpRadius/2,0])
            cylinder(r=bracketBumpRadius, h=bracketDepth+overlap*2);
        translate([bracketBumpCenterToCenter/2,-bracketSideRadius+bracketBumpRadius/2,0])
            cylinder(r=bracketBumpRadius, h=bracketDepth+overlap*2);
    }
}

/*
   moved above z axis and within +x +y
 */
module hullPlate(hullPlateWidth, hullPlateHeight, hullPlateCornerRoundnessRadius) {
    translate([hullPlateCornerRoundnessRadius,hullPlateCornerRoundnessRadius,hullPlateCornerRoundnessRadius]) {
        sphere(r=cornerRoundnessRadius);
        translate([hullPlateWidth-hullPlateCornerRoundnessRadius*2,0,0])
            sphere(r=cornerRoundnessRadius);
        translate([0,hullPlateHeight-hullPlateCornerRoundnessRadius*2,0])
            sphere(r=cornerRoundnessRadius);
        translate([hullPlateWidth-hullPlateCornerRoundnessRadius*2,hullPlateHeight-hullPlateCornerRoundnessRadius*2,0])
            sphere(r=cornerRoundnessRadius);
    }
}