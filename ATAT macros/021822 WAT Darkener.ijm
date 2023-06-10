imagename = replace(getTitle(), ".Tif", ".tif");
rename(imagename);
image1name = replace(imagename, ".tif", "-1.tif");

if (is("grayscale")) {
} else {
	run("8-bit");
}

run("Duplicate...", " ");
run("Find Edges");
run("Subtract...", "value=35");
run("Multiply...", "value=255");
run("Invert");
run("Watershed");
run("Invert");
run("Maximum...", "radius=2");
run("Minimum...", "radius=2");

run("Subtract...", "value=230");
imageCalculator("Subtract", imagename, image1name);
close(image1name);
