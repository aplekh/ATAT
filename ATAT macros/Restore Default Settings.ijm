Table.create("Settings");

Table.set("Adipocyte Results", 0, "Display and Save Results");
Table.set("Fibrosity Capture Settings", 0, "Capture Only");

Table.set("Blur Radius", 0, 3);
Table.set("Minimum Circularity", 0, 0.4);
Table.set("Minimum Particle Size", 0, 300);
Table.set("Maximum Particle Size", 0, 30000);

imagejdir = getDirectory("imagej");
foldername = "PATTI/";
middledir = imagejdir + foldername;

File.makeDirectory(middledir);

filename = "PATTI Capture Settings.csv";
finaldir = imagejdir + foldername + filename;

IJ.renameResults("Settings", "PATTI Capture Settings.csv");

saveAs("Results", finaldir);

selectWindow("PATTI Capture Settings.csv");

Table.update;

run("Close");