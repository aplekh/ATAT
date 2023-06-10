setBatchMode(true);

Dialog.create("Edge Enhancement Strength");
Dialog.addNumber("", 30);
Dialog.show();
DarkStrength = Dialog.getNumber();

subtractme = 255 - DarkStrength;

imagename = getTitle();
image1name = replace(imagename, ".tif", "-1.tif");

if (is("grayscale")) {
} else {
	run("8-bit");
}

run("Duplicate...", " ");
rename(image1name);
run("Find Edges");
run("Subtract...", "value=35");
run("Multiply...", "value=255");
run("Invert");
run("Watershed");
run("Invert");
run("Maximum...", "radius=2");
run("Minimum...", "radius=2");

run("Subtract...", "value=subtractme");
imageCalculator("Subtract", imagename, image1name);
close(image1name);
