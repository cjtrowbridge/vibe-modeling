// Simplified Gigachad head void cutter defaults (all dimensions in mm).
// Positive model intended for subtraction from a head mesh in a slicer.
//
// Coordinate convention:
// - X = left/right (width)
// - Y = front/back depth (main prism extends toward -Y)
// - Z = vertical (up)

// Part selector
// 0 = combined cutter (main back prism + top shaft)
// 1 = main back prism only
// 2 = top shaft only
part_id = 0;

// Main rectangular prism (extends out the back of the head)
main_x = 110;
main_y = 220;
main_z = 110;

// Vertical shaft extending upward from the top of the main prism
shaft_x = 80;
shaft_y = 205; // 220 main depth - 15mm front inset; extends to back face
shaft_z = 100;

// Shaft placement on the top face of the main prism
// Shaft is centered across X by default (80 inside 110 leaves 15mm on each side),
// and inset from one end of the 220-length top face.
shaft_margin_x = 15;
shaft_margin_end = 15;
shaft_from_back_end = false; // false = inset from head-plane end so shaft extends all the way back

// 80mm fan mounting helpers at the base of the vertical shaft
// These are modeled on the cutter as:
// - a negative fan-mount plate relief (to create a positive 3mm fan plate in the final part)
// - positive hole pins (to create actual holes in the final part after subtraction)
fan_mount_enabled = true;
fan_mount_pad_x = 80;       // fan mount feature region width on the shaft base
fan_mount_pad_y = 80;       // fan mount feature region depth on the shaft base
fan_mount_pad_offset_y = 15; // local Y offset from the shaft back end to preserve original fan position
fan_mount_plate_x = 80;      // local plate footprint width (X)
fan_mount_plate_y = 86;      // local plate footprint depth (Y) to bridge tabs around an 80mm hole
fan_mount_plate_thickness = 3; // final fan plate thickness
fan_duct_hole_d = 80;        // circular airflow opening through the fan plate

// Typical 80mm fan pattern (Google summary provided by user)
fan_hole_spacing = 71.5; // center-to-center square spacing
fan_hole_d = 4.4;        // M4-ish clearance
fan_hole_pin_height = 14; // cutter pin height; creates hole depth in final part
