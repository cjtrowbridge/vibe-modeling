// 3 Rectangles arranged in a Symmetric Triangle configuration
// Dimensions: 113mm x 57mm
// Outside circle diameter: 211.89mm
// Wrapped in a 290mm outer circle to show clearance

$fn = 100; // High resolution rendering

// Parameters
rect_l = 113;
rect_w = 57;
inner_side = 113;

// 290mm Reference Bounding Circle
color([0.8, 0.8, 0.8, 0.2]) {
    linear_extrude(height = 1) 
        circle(d = 290);
}



// Distance from center to the inner edge of each rectangle
// For an equilateral triangle of side L, inradius r = L / (2 * sqrt(3))
inradius = inner_side / (2 * sqrt(3)); 

// The 3 Rectangles
for (i = [0 : 2]) {
    rotate([0, 0, i * 120]) {
        // Shift outward so the inner edge touches the inradius,
        // and center it along the side length
        translate([-rect_l/2, inradius, 0]) {
            color([0.2, 0.6, i * 0.4 + 0.2]) {
                cube([rect_l, rect_w, 10]);
            }
        }
    }
}

