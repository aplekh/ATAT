setBatchMode(true);
run("8-bit");

Dialog.create("Edge Enhancement Settings");
Dialog.addNumber("Sensitivity, 0-255", 230);
Dialog.addNumber("Strength, 0-255", 30);
Dialog.show();
DarkSensitivityInverse = Dialog.getNumber();
DarkStrength = Dialog.getNumber();

subtractstrength = 255 - DarkStrength;
subtractsensitivity = 255 - DarkSensitivityInverse;

imagename = getTitle();
image1name = replace(imagename, ".tif", "-1.tif");

run("Duplicate...", " ");
rename(image1name);
run("Find Edges");
run("Subtract...", "value=subtractsensitivity");
run("Multiply...", "value=255");
run("Invert");
run("Watershed");
run("Invert");
run("Maximum...", "radius=2");
run("Minimum...", "radius=2");

run("Subtract...", "value=subtractstrength");
imageCalculator("Subtract", imagename, image1name);
close(image1name);
