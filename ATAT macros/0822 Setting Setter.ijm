imagejdir = getDirectory("imagej");
foldername = "AT-AT/";
filename1 = "AT-AT Capture Settings.csv";
finaldir1 = imagejdir + foldername + filename1;

middledir = imagejdir + foldername;
File.makeDirectory(middledir);

filename = "AT-AT Capture Settings.csv";
finaldir = imagejdir + foldername + filename;

SettingsStatus = File.exists(finaldir1);

if (SettingsStatus == 1) {
	open(finaldir1);
	
	//PrevAdipocyteResults = Table.getString("Adipocyte Results", 0);
	PrevFibrosityCaptureSettings = Table.getString("Fibrosity", 0);
	PrevBlurRadius = parseFloat(Table.get("Blur Radius", 0));
	PrevMinCircularity = parseFloat(Table.get("Minimum Circularity", 0));
	PrevMinPart = parseFloat(Table.get("Minimum Particle Size", 0));
	PrevMaxPart = parseFloat(Table.get("Maximum Particle Size", 0));
	PrevAdipoBins = parseFloat(Table.get("Adipocyte Bin Size", 0));
	PrevAvgFibrosityBins = parseFloat(Table.get("Average Fibrosity Bin Size", 0));
	PrevMaxFibrosityBins = parseFloat(Table.get("Highest Observed Fibrosity Bin Size", 0));
	PrevTopHat = parseFloat(Table.get("TopHat Radius", 0));

	PrevHistoBuddy = Table.getString("HistoBuddy", 0);
	PrevDarkSetting = Table.getString("Darken Edges", 0);
	PrevBrightSetting = Table.getString("Brighten Images", 0);
	PrevWatershedSetting = Table.getString("Watershed", 0);

	PrevDarkSensitivity = parseFloat(Table.get("Edge Darkening Sensitivity"));
	PrevDarkStrength = parseFloat(Table.get("Edge Darkening Strength"));

	//PrevOutputDir = Table.getString("OutputDir", 0);
	
	run("Close");
	
} else {
	//PrevAdipocyteResults = "Display and Save Results";
	PrevFibrosityCaptureSettings = "No";
	PrevBlurRadius = 1;
	PrevMinCircularity = 0.4;
	PrevMinPart = 150;
	PrevMaxPart = 30000;
	PrevAdipoBins = 500;
	PrevAvgFibrosityBins = 1;
	PrevMaxFibrosityBins = 5;
	PrevTopHat = 2;

	PrevDarkSensitivity = 230;
	PrevDarkStrength = 30;

	PrevHistoBuddy = "No";
	PrevDarkSetting = "No";
	PrevBrightSetting = "No";
	PrevWatershedSetting = "No";
	
	//PrevOutputDir = getDirectory("imagej") + "AT-AT";
}


Dialog.create("Settings");
Dialog.addChoice("Darken Edges", newArray("Yes", "No"), PrevDarkSetting);
Dialog.addChoice("Brighten Images", newArray("Yes", "No"), PrevBrightSetting);
Dialog.addChoice("Watershed", newArray("Yes", "No"), PrevWatershedSetting);
Dialog.addChoice("Measure Pericellular Fibrosity", newArray("Yes", "No"), PrevFibrosityCaptureSettings);
Dialog.addChoice("Run HistoBuddy", newArray("Yes", "No"), PrevHistoBuddy);
//Dialog.addChoice("Adipocyte Results", newArray("Display and Save Results", "Only Display Results", "Only Save Results"), PrevAdipocyteResults);

Dialog.addNumber("Blur Radius", PrevBlurRadius);
Dialog.addNumber("TopHat Radius", PrevTopHat);
Dialog.addNumber("Minimum Circularity", PrevMinCircularity);
Dialog.addNumber("Minimum Particle Size", PrevMinPart);
Dialog.addNumber("Maximum Particle Size", PrevMaxPart);

//Dialog.addDirectory("Save Results To...", PrevOutputDir);

Dialog.show();
DarkenSetting = Dialog.getChoice();
BrightenSetting = Dialog.getChoice();
WatershedSetting = Dialog.getChoice();
fibrositysetting = Dialog.getChoice();
histobuddysetting = Dialog.getChoice();
//AdipoResultsSetting = Dialog.getChoice();

blurradius = Dialog.getNumber();
TopHat = Dialog.getNumber();
MinCirc = Dialog.getNumber();
MinPart = Dialog.getNumber();
MaxPart = Dialog.getNumber();

//outputdir = Dialog.getString();

if (DarkenSetting == "Yes") {
	Dialog.create("Edge Enhancement Settings");
	if (isNaN(PrevDarkStrength)) {
		Dialog.addNumber("Sensitivity, 0-255", 230);
		Dialog.addNumber("Strength, 0-255", 30);
	} else {
		Dialog.addNumber("Sensitivity, 0-255", PrevDarkSensitivity);
		Dialog.addNumber("Strength, 0-255", PrevDarkStrength);
	}

	Dialog.show();
	DarkSensitivity = Dialog.getNumber();
	DarkStrength = Dialog.getNumber();
}

if (histobuddysetting == "Yes") {
	Dialog.create("HistoBuddy Bin Sizes");
	if (isNaN(PrevAdipoBins) || isNaN(PrevAvgFibrosityBins) || isNaN(PrevMaxFibrosityBins)) {
		Dialog.addNumber("Adipocyte Bin Size", 500);
		Dialog.addNumber("Mean & Median Fibrosity Bin Size", 5);
		Dialog.addNumber("Highest Observed Fibrosity Bin Size", 10);
	} else {
		Dialog.addNumber("Adipocyte Bin Size", PrevAdipoBins);
		Dialog.addNumber("Mean & Median Fibrosity Bin Size", PrevAvgFibrosityBins);
		Dialog.addNumber("Highest Observed Fibrosity Bin Size", PrevMaxFibrosityBins);
	}
	
	Dialog.show();
	adipobinsize = Dialog.getNumber();
	avgfibbinsize = Dialog.getNumber();
	maxfibbinsize = Dialog.getNumber();
}

Table.create("Settings");

//Table.set("Adipocyte Results", 0, AdipoResultsSetting);

Table.set("Darken Edges", 0, DarkenSetting);

if (DarkenSetting == "Yes") {
	Table.set("Edge Darkening Sensitivity", 0, DarkSensitivity);
	Table.set("Edge Darkening Strength", 0, DarkStrength);
} else {
	if (isNaN(PrevDarkStrength) || isNaN(PrevDarkSensitivity)) {
	} else {
		Table.set("Edge Darkening Sensitivity", 0, PrevDarkSensitivity);
		Table.set("Edge Darkening Strength", 0, PrevDarkStrength);
	}
}

Table.set("Brighten Images", 0, BrightenSetting);
Table.set("Watershed", 0, WatershedSetting);
Table.set("Fibrosity", 0, fibrositysetting);
Table.set("HistoBuddy", 0, histobuddysetting);

Table.set("Blur Radius", 0, blurradius);
Table.set("TopHat Radius", 0, TopHat);
Table.set("Minimum Circularity", 0, MinCirc);
Table.set("Minimum Particle Size", 0, MinPart);
Table.set("Maximum Particle Size", 0, MaxPart);

if (histobuddysetting == "Yes") {
	Table.set("Adipocyte Bin Size", 0, adipobinsize);
	Table.set("Average Fibrosity Bin Size", 0, avgfibbinsize);
	Table.set("Highest Observed Fibrosity Bin Size", 0, maxfibbinsize);
} else {
	if (isNaN(PrevAdipoBins) || isNaN(PrevAvgFibrosityBins) || isNaN(PrevMaxFibrosityBins)) {
	} else {
		Table.set("Adipocyte Bin Size", 0, PrevAdipoBins);
		Table.set("Average Fibrosity Bin Size", 0, PrevAvgFibrosityBins);
		Table.set("Highest Observed Fibrosity Bin Size", 0, PrevMaxFibrosityBins);
	}
}

//Table.set("OutputDir", 0, outputdir);

//IJ.renameResults("Settings", "AT-AT Capture Settings.csv");

saveAs("Results", finaldir);

selectWindow("AT-AT Capture Settings.csv");
//Table.deleteRows(0, 0);
Table.update;
run("Close");