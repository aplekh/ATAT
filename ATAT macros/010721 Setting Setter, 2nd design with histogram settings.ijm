imagejdir = getDirectory("imagej");
foldername = "PATTI/";
filename1 = "PATTI Capture Settings.csv";
finaldir1 = imagejdir + foldername + filename1;

SettingsStatus = File.exists(finaldir1);

if (SettingsStatus == 1) {
	open(finaldir1);
	
	PrevAdipocyteResults = Table.getString("Adipocyte Results", 0);
	PrevFibrosityCaptureSettings = Table.getString("Fibrosity Capture Settings", 0);
	PrevBlurRadius = parseFloat(Table.get("Blur Radius", 0));
	PrevMinCircularity = parseFloat(Table.get("Minimum Circularity", 0));
	PrevMinPart = parseFloat(Table.get("Minimum Particle Size", 0));
	PrevMaxPart = parseFloat(Table.get("Maximum Particle Size", 0));
	PrevAdipoBins = parseFloat(Table.get("Adipocyte Bin Size", 0));
	PrevAvgFibrosityBins = parseFloat(Table.get("Average Fibrosity Bin Size", 0));
	PrevMaxFibrosityBins = parseFloat(Table.get("Highest Observed Fibrosity Bin Size", 0));
	PrevTopHat = parseFloat(Table.get("TopHat Radius", 0));

	PrevOutputDir = Table.getString("OutputDir", 0);
	
	run("Close");
} else {
	PrevAdipocyteResults = "Display and Save Results";
	PrevFibrosityCaptureSettings = "Capture Only";
	PrevBlurRadius = 3;
	PrevMinCircularity = 0.4;
	PrevMinPart = 300;
	PrevMaxPart = 30000;
	PrevAdipoBins = 500;
	PrevAvgFibrosityBins = 1;
	PrevMaxFibrosityBins = 5;
	PrevTopHat = 5;
	
	PrevOutputDir = getDirectory("imagej") + "PATTI";
}



Dialog.create("Adipocyte Capture Settings");
Dialog.addChoice("Adipocyte Results", newArray("Display and Save Results", "Only Display Results", "Only Save Results"), PrevAdipocyteResults);
Dialog.addNumber("Blur Radius", PrevBlurRadius);
Dialog.addNumber("Minimum Circularity", PrevMinCircularity);
Dialog.addNumber("Minimum Particle Size", PrevMinPart);
Dialog.addNumber("Maximum Particle Size", PrevMaxPart);
Dialog.addNumber("TopHat Radius", PrevTopHat);
Dialog.show();
AdipoResultsSetting = Dialog.getChoice();
blurradius = Dialog.getNumber();
MinCirc = Dialog.getNumber();
MinPart = Dialog.getNumber();
MaxPart = Dialog.getNumber();
TopHat = Dialog.getNumber();

//Pericellular Fibrosity Setting

Dialog.create("Pericellular Fibrosity Capture Settings");
Dialog.addChoice(" ", newArray("Capture Only", "Capture and Display", "Don't Capture"), PrevFibrosityCaptureSettings);
Dialog.show();

fibrositysetting = Dialog.getChoice();

//Creation of the table to store settings.

Table.create("Settings");

Table.set("Adipocyte Results", 0, AdipoResultsSetting);
Table.set("Fibrosity Capture Settings", 0, fibrositysetting);

Table.set("Blur Radius", 0, blurradius);
Table.set("Minimum Circularity", 0, MinCirc);
Table.set("Minimum Particle Size", 0, MinPart);
Table.set("Maximum Particle Size", 0, MaxPart);
Table.set("TopHat Radius", 0, TopHat);


imagejdir = getDirectory("imagej");
foldername = "PATTI/";
middledir = imagejdir + foldername;

File.makeDirectory(middledir);


filename = "PATTI Capture Settings.csv";
finaldir = imagejdir + foldername + filename;

//NEW
Dialog.create("HistoBuddy Settings");
histobuddyoptions = newArray(2);
histobuddyoptions[0] = "No";
histobuddyoptions[1] = "Yes";
Dialog.addChoice("Run HistoBuddy", newArray("Yes", "No"), "No");
Dialog.show();
histobuddysetting = Dialog.getChoice();

if (histobuddysetting == "Yes") {
	Dialog.create("Bin Sizes");
	Dialog.addNumber("Adipocyte Bin Size", PrevAdipoBins);
	Dialog.addNumber("Mean & Median Fibrosity Bin Size", PrevAvgFibrosityBins);
	Dialog.addNumber("Highest Observed Fibrosity Bin Size", PrevMaxFibrosityBins);
	Dialog.show();
	adipobinsize = Dialog.getNumber();
	avgfibbinsize = Dialog.getNumber();
	maxfibbinsize = Dialog.getNumber();
	Table.set("HistoBuddy", 0, "Yes");
	Table.set("Adipocyte Bin Size", 0, adipobinsize);
	Table.set("Average Fibrosity Bin Size", 0, avgfibbinsize);
	Table.set("Highest Observed Fibrosity Bin Size", 0, maxfibbinsize);
} else {
	Table.set("HistoBuddy", 0, "No");
	Table.set("Adipocyte Bin Size", 0, PrevAdipoBins);
	Table.set("Average Fibrosity Bin Size", 0, PrevAvgFibrosityBins);
	Table.set("Highest Observed Fibrosity Bin Size", 0, PrevMaxFibrosityBins);
}


//ENDNEW


//IJ.renameResults("Settings", "PATTI Capture Settings.csv");

//saveAs("Results", finaldir);

Dialog.create("Select Output Directory");

defaultpath = PrevOutputDir;

Dialog.addDirectory("Save To...", defaultpath);

Dialog.show();

outputdir = Dialog.getString();

Table.set("OutputDir", 0, outputdir);

IJ.renameResults("Settings", "PATTI Capture Settings.csv");

saveAs("Results", finaldir);