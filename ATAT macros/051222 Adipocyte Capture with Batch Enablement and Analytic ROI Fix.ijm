tieEnabled = false; // allows for easy code direction changing with just 1 var based on whether or not TIE is enabled

if (tieEnabled)
{
	run("Launch Macroextension...");
	Ext.setupRoundness("true", 0.40, 1.00);
}

setBatchMode(true);

imagename = getTitle();
imagedir = File.directory;
imagefullpath = imagedir + imagename;

image1nameprime = imagename + "-1";
image1name = replace(image1nameprime, ".tif", "") + ".tif";

image2nameprime = imagename + "-2";
image2name = replace(image2nameprime, ".tif", "") + ".tif";

image3nameprime = imagename + "-3";
image3name = replace(image3nameprime, ".tif", "") + ".tif";

image4nameprime = imagename + "-4";
image4name = replace(image4nameprime, ".tif", "") + ".tif";

rofimage1nameprime = "Result of " + image1name;
rofimage1name = replace(rofimage1nameprime, ".tif", "") + ".tif";

rofimage2nameprime = "Result of " + image2name;
rofimage2name = replace(rofimage2nameprime, ".tif", "") + ".tif";

rofimage3nameprime = "Result of " + image3name;
rofimage3name = replace(rofimage3nameprime, ".tif", "") + ".tif";

rofimage4nameprime = "Result of " + image4name;
rofimage4name = replace(rofimage4nameprime, ".tif", "") + ".tif";

one = 1;
toScaled(one);

roiManager("Show All without labels");
roiManager("Show None");
imagejdir = getDirectory("imagej");
foldername = "AT-AT/";
filename1 = "AT-AT Capture Settings.csv";
finaldir1 = imagejdir + foldername + filename1;
roifilename = replace(imagename, ".tif", "Analytic ROI.roi");
//roipath = imagejdir + roifilename;

SettingsStatus = File.exists(finaldir1);

if (SettingsStatus == 0) {
	OutputDir = getDirectory("imagej") + "AT-AT/";
	Table.create("Settings");
	
	Table.set("Adipocyte Results", 0, "Display and Save Results");
	Table.set("Fibrosity Capture Settings", 0, "Capture Only");
	
	Table.set("Blur Radius", 0, 3);
	Table.set("Minimum Circularity", 0, 0.4);
	Table.set("Minimum Particle Size", 0, 300);
	Table.set("Maximum Particle Size", 0, 30000);
	Table.set("TopHat Radius", 0, 5);
	Table.set("OutputDir", 0, OutputDir);
	
	imagejdir = getDirectory("imagej");
	foldername = "AT-AT/";
	middledir = imagejdir + foldername;
	
	File.makeDirectory(middledir);
	
	filename = "AT-AT Capture Settings.csv";
	finaldir = imagejdir + foldername + filename;
	
	IJ.renameResults("Settings", "AT-AT Capture Settings.csv");
	
	saveAs("Results", finaldir);
	
	selectWindow("AT-AT Capture Settings.csv");
	
	Table.update;
	
	run("Close");
}

open(finaldir1);

//Added table selection to try to fix variable problem
selectWindow("AT-AT Capture Settings.csv");
Table.update;

AdipocyteResults = Table.getString("Adipocyte Results", 0);
// FibrosityCaptureSettings = Table.getString("Fibrosity Capture Settings", 0); // being replaced with 1.1.8
FibrosityCaptureSettings = Table.getString("Fibrotic Lines", 0);
BlurRadius = parseFloat(Table.get("Blur Radius", 0));
MinCircularity = parseFloat(Table.get("Minimum Circularity", 0));
MinPart = parseFloat(Table.get("Minimum Particle Size", 0));
MaxPart = parseFloat(Table.get("Maximum Particle Size", 0));
TopHat = parseFloat(Table.get("TopHat Radius", 0));

OutputDir = Table.getString("OutputDir", 0);
rawdatadir = OutputDir + "Data/";
AdipoROIsdir = OutputDir + "AdipoROIs/";
technicaldir = OutputDir + "Technical Files/";
File.makeDirectory(rawdatadir);
File.makeDirectory(AdipoROIsdir);
File.makeDirectory(technicaldir);

run("Close");

//open(finaldir2);  

//outputdir = Table.getString("", 0);

//run("Close");

if (is("grayscale")){
	
} else {
	run("8-bit");
}

//rename("Image");

Table.create("Peak Storage");
Table.setColumn("PeakValue");
Table.setColumn("PeakCount");
Table.setColumn("Red");
Table.setColumn("Blue");
Table.setColumn("Green");
Table.setColumn("Analytic Area");

rois = roiManager("count");

outcome = 1;
if (rois>1) {
	selectionarray = Array.getSequence(rois);
	roiManager("select", selectionarray);
	roiManager("combine");
	roiManager("add");
	roismin1 = roiManager("count") - 1;
	deletionarray = Array.getSequence(roismin1);
	roiManager("select", deletionarray);
	roiManager("delete");
}

if (rois==0) {
	run("Select All");
	roiManager("add");
}

roiManager("select", 0);
Roi.getBounds(xROI, yROI, widthROI, heightROI);
run("Set Measurements...", "area centroid bounding redirect=None decimal=3");
run("Measure");
roipath = technicaldir + roifilename;
roiManager("save", roipath);
BX = parseFloat(getResult("BX", 0));
BY = parseFloat(getResult("BY", 0));
//xRoiCentroid = parseFloat(getResult("X", 0));
//yRoiCentroid = parseFloat(getResult("Y", 0));
xmove = 0 - BX;
ymove = 0 - BY;
AnalyticArea = getResult("Area", 0);
//Table.set("Analytic Area", 0, AnalyticArea);
run("Clear Results");
selectWindow("Peak Storage");
Table.set("Analytic Area", 0, AnalyticArea);
run("Duplicate...", " ");
rename(image1name);
run("Duplicate...", " ");
rename(image2name);

// New Mask Maker!!!

run("Set Measurements...", "bounding redirect=None decimal=3");
if (selectionType() == -1) {
	 run("Select All");
}
roiManager("add");
roiManager("select", 0);
roiManager("delete");
roiManager("select", 0);
roiManager("measure");

//AnalyticArea = getResult("Area", 0);
/* BX = parseFloat(getResult("BX", 0));
BY = parseFloat(getResult("BY", 0));
xmove = 0 - BX; // Am temporarily commenting this out to see if it will fix ROI shift bug.
ymove = 0 - BY;*/

roiManager("show all with labels");
roiManager("select", 0);
//roiManager("translate", xmove, ymove);
roiManager("show none");

run("Create Mask");
run("Clear Results");

//End New!!!

run("Invert");
roiManager("select", 0);
run("Subtract...", "value=255");
selectWindow(image2name);
roiManager("deselect");
roiManager("delete");
run("Select None");

//rename("Image");
//run("Duplicate...", " ");
//run("Mean...", "radius=1");

//Table.create("Peak Storage");
//Table.setColumn("PeakValue");
//Table.setColumn("PeakCount");
//Table.setColumn("Red");
//Table.setColumn("Blue");
//Table.setColumn("Green");
//Table.setColumn("Analytic Area");

// 16-section Image Divider

width = getWidth();
height = getHeight();

blockwidth = floor(width/4)+1;
blockheight = floor(height/4)+1;
blockwidth2 = 2* blockwidth;
blockheight2 = 2* blockheight;
blockwidth3 = 3* blockwidth;
blockheight3 = 3* blockheight;


//Column 1
makeRectangle(0, 0, blockwidth, blockheight);
roiManager("add");
roiManager("select", 0);
roiManager("rename", "0");
makeRectangle(0, blockheight, blockwidth, blockheight);
roiManager("add");
roiManager("select", 1);
roiManager("rename", "1");
makeRectangle(0, blockheight2, blockwidth, blockheight);
roiManager("add");
roiManager("select", 2);
roiManager("rename", "2");
makeRectangle(0, blockheight3, blockwidth, blockheight);
roiManager("add");
roiManager("select", 3);
roiManager("rename", "3");

//Column 2
makeRectangle(blockwidth, 0, blockwidth, blockheight);
roiManager("add");
roiManager("select", 4);
roiManager("rename", "4");
makeRectangle(blockwidth, blockheight, blockwidth, blockheight);
roiManager("add");
roiManager("select", 5);
roiManager("rename", "5");
makeRectangle(blockwidth, blockheight2, blockwidth, blockheight);
roiManager("add");
roiManager("select", 6);
roiManager("rename", "6");
makeRectangle(blockwidth, blockheight3, blockwidth, blockheight);
roiManager("add");
roiManager("select", 7);
roiManager("rename", "7");

//Column 3
makeRectangle(blockwidth2, 0, blockwidth, blockheight);
roiManager("add");
roiManager("select", 8);
roiManager("rename", "8");
makeRectangle(blockwidth2, blockheight, blockwidth, blockheight);
roiManager("add");
roiManager("select", 9);
roiManager("rename", "9");
makeRectangle(blockwidth2, blockheight2, blockwidth, blockheight);
roiManager("add");
roiManager("select", 10);
roiManager("rename", "10");
makeRectangle(blockwidth2, blockheight3, blockwidth, blockheight);
roiManager("add");
roiManager("select", 11);
roiManager("rename", "11");

//Column 4
makeRectangle(blockwidth3, 0, blockwidth, blockheight);
roiManager("add");
roiManager("select", 12);
roiManager("rename", "12");
makeRectangle(blockwidth3, blockheight, blockwidth, blockheight);
roiManager("add");
roiManager("select", 13);
roiManager("rename", "13");
makeRectangle(blockwidth3, blockheight2, blockwidth, blockheight);
roiManager("add");
roiManager("select", 14);
roiManager("rename", "14");
makeRectangle(blockwidth3, blockheight3, blockwidth, blockheight);
roiManager("add");
roiManager("select", 15);
roiManager("rename", "15");

Table.set("Block Thresholds", 0, 0);

roiManager("select", 0);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 0, Threshold);

roiManager("select", 1);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 1, Threshold);

roiManager("select", 2);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 2, Threshold);

roiManager("select", 3);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 3, Threshold);

roiManager("select", 4);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 4, Threshold);

roiManager("select", 5);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 5, Threshold);

roiManager("select", 6);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 6, Threshold);

roiManager("select", 7);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 7, Threshold);

roiManager("select", 8);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 8, Threshold);

roiManager("select", 9);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 9, Threshold);

roiManager("select", 10);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 10, Threshold);

roiManager("select", 11);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 11, Threshold);

roiManager("select", 12);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 12, Threshold);

roiManager("select", 13);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 13, Threshold);

roiManager("select", 14);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 14, Threshold);

roiManager("select", 15);
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 15, Threshold);

roiManager("deselect");
//runMacro("102020 Threshold Calculator, string-corrected");
run("MacroRunner", "102020 Threshold Calculator, string-corrected.ijm");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 16, Threshold);

//If I don't mean-filter it first, it captures crappy pixels. If I do, background pixels adjacent to tissue fail to be removed.

run("Select None");
run("Mean...", "radius=BlurRadius");

selectWindow("Results");
run("Close");

thresholdoutcome = 0;

for (i = 0; i < 16; i++) {
	currentthreshold = parseFloat(Table.get("Block Thresholds", i));
	roiManager("select", i);
	if (currentthreshold > (-1)) {
		run("Subtract...", "value=currentthreshold");
		thresholdoutcome = 1;
	} else {
		substitutethreshold = parseFloat(Table.get("Block Thresholds", 16));
		if (substitutethreshold > (-1)) {
			run("Subtract...", "value=substitutethreshold");
			thresholdoutcome = 2;
		}
	}
	if (thresholdoutcome == 0) {
	peakvalue = parseFloat(Table.get("PeakValue", 0));
	subvalue = peakvalue;
	//if (subvalue < (0.95 * blockthreshmean)) {
	//	subvalue = blockthreshmean;
	//}
	run("Subtract...", "value=subvalue");
	}
	thresholdoutcome = 0;
}




run("Select None");

run("Multiply...", "value=255");

//Originally prime minus one
imageCalculator("Subtract create", image1name, image2name);

// Let's try identifying the lowest of the thresholds and removing all pixels above this value.

selectWindow("Peak Storage");

thresh0 = Table.get("Block Thresholds", 0);
thresh1 = Table.get("Block Thresholds", 1);
thresh2 = Table.get("Block Thresholds", 2);
thresh3 = Table.get("Block Thresholds", 3);
thresh4 = Table.get("Block Thresholds", 4);
thresh5 = Table.get("Block Thresholds", 5);
thresh6 = Table.get("Block Thresholds", 6);
thresh7 = Table.get("Block Thresholds", 7);
thresh8 = Table.get("Block Thresholds", 8);
thresh9 = Table.get("Block Thresholds", 9);
thresh10 = Table.get("Block Thresholds", 10);
thresh11 = Table.get("Block Thresholds", 11);
thresh12 = Table.get("Block Thresholds", 12);
thresh13 = Table.get("Block Thresholds", 13);
thresh14 = Table.get("Block Thresholds", 14);
thresh15 = Table.get("Block Thresholds", 15);

allblockthresholds = newArray(thresh0, thresh1, thresh2, thresh3, thresh4, thresh5, thresh6, thresh7, thresh8, thresh9, thresh10, thresh11, thresh12, thresh13, thresh14, thresh15);
allblockthresholds = Array.deleteValue(allblockthresholds, NaN);
Array.getStatistics(allblockthresholds, min, max, mean, stdDev);

residualthreshold = mean;

selectWindow(rofimage1name);

run("Duplicate...", " ");
rename(rofimage2name);

run("Subtract...", "value=residualthreshold");
run("Multiply...", "value=255");

imageCalculator("Subtract", rofimage1name, rofimage2name);
if (outcome == 1) {
	imageCalculator("Subtract", rofimage1name, "Mask");
}
//selectWindow(rofimage1name);
//close();
selectWindow(rofimage1name);
run("Select None");

nBins = 256;
row = 0;
//run("8-bit");
getHistogram(values, counts, nBins);
for (i=0; i<nBins; i++) {
	setResult("Value", row, values[i]);
	setResult("Count", row, counts[i]);
	row++;
}

updateResults();
selectWindow("Results");
Table.deleteRows(0, 0);
Table.deleteRows(residualthreshold, 255);

//Calculating our results!

initialpixelcount = 0;
previouspixelcount = 0;

minusone = residualthreshold - 1;

for (i = 0; i < minusone; i++) {
	currentnumber = i;
	currentcount = getResult("Count", currentnumber);
	totalpixelcount = currentcount + initialpixelcount + previouspixelcount;
	previouspixelcount = totalpixelcount;
	
}

selectWindow("Peak Storage");
Table.setColumn("FibrousPixels");
Table.set("FibrousPixels", 0, totalpixelcount);

one = 1;
toScaled(one);
Table.setColumn("Scale");
Table.set("Scale", 0, one);

scale = Table.get("Scale", 0);
FibrousArea = totalpixelcount*scale*scale;
Table.setColumn("FibrousArea");
Table.set("FibrousArea", 0, FibrousArea);

//We need an analytic area setup up top.

//Table.set("Analytic Area", 0, AnalyticArea);
//FibrousFraction = FibrousArea / Table.get("Analytic Area", 0);
//Table.setColumn("FibrousFraction");
//Table.set("FibrousFraction", 0, FibrousFraction);

for (i = 0; i < minusone; i++) {
	weightedavginput = getResult("Value", i) * getResult("Count", i) / Table.get("FibrousPixels", 0);
	Table.set("WeightedAvgInput", i, weightedavginput);
}

prevweightedavg = 0;

for (i=0; i < minusone; i++) {
	currentweightedavg = parseFloat(Table.get("WeightedAvgInput", i)) + prevweightedavg;
	prevweightedavg = currentweightedavg;
}

Table.set("WeightedAverage", 0, currentweightedavg);

Table.deleteColumn("WeightedAvgInput");
selectWindow("Peak Storage");
Table.rename("Peak Storage", "Stats");
Table.deleteRows(1, 253, "Stats");

//if (outcome == 1) {
//	FibrousFraction = parseFloat(Table.get("FibrousArea", 0)) / parseFloat(Table.get("Analytic Area", 0));
//	Table.setColumn("FibrousFraction");
//	selectWindow("Stats");
//	Table.set("FibrousFraction", 0, FibrousFraction);
//}
//
//Table.deleteColumn("Block Thresholds");

selectWindow(rofimage1name);
run("Duplicate...", " ");
rename(rofimage3name);

// We are now trying TopHat for capture purposes.

run("Top Hat...", "radius=TopHat light don't");
run("Multiply...", "value=255.000");

/// *****
//This section prints the histogram, instead of recording to a table, to prevent table issues.

//print("Values");
//valuearray = newArray(nResults);
//for(i=0; i<nResults; i++) {
//	valuearray[i] = getResult("Value", i);
//}
//Array.print(valuearray);

//print(" ");
//print("Counts");

//countarray = newArray(nResults);
//for(i=0; i<nResults; i++) {
//	countarray[i] = getResult("Count", i);
//}
//Array.print(countarray);

/// *****

//Let's try transferring it instead.

valuearray = newArray(nResults);
for(i=0; i<nResults; i++) {
	valuearray[i] = getResult("Value", i);
}
countarray = newArray(nResults);
for(i=0; i<nResults; i++) {
	countarray[i] = getResult("Count", i);
}

run("Clear Results");
roiManager("deselect");
roiManager("delete");

run("Set Measurements...", "area centroid perimeter bounding feret's redirect=None decimal=3");
selectWindow(rofimage3name);
if (tieEnabled)
{
	run("Analyze Particles (TIE)", "size=MinPart-MaxPart circularity=MinCircularity-1.00 exclude add");
	//run("Analyze Particles (TIE)", "size=MinPart-MaxPart circularity=MinCircularity-1.00 roundness=0.00-1.00 exclude add");
}
else
{
	run("Analyze Particles...", "size=MinPart-MaxPart circularity=MinCircularity-1.00 exclude add");
}
// debug("break"); // DEBUG attempt, TODO: get rid of this once debugging is finished
// waitForUser("line 615");

//AdipoROI Saver: new; remove if breaks
roicount = roiManager("count");
if (roicount == 0)
{
	run("Close All");
	//waitForUser("no rois in" + imagename + "!");
	return "no rois";
}
roiarray = Array.getSequence(roicount);
roiManager("select", roiarray);
roiManager("combine"); // This right here is what makes everything into 1 ROI as opposed to multiple ROIs
roiManager("add");
roiManager("select", roicount);

/* 
 * Translate command is only avialable on ImageJ version 1.53s or greater. We therefore have to check the version
 * before we use the command. We need to translate to ensure ROIs are in the correct position relative to their cells.
 */
ijVersion = parseFloat(substring(getVersion(), 6, 10)); // Gets version number without the letter as a float, eg. 1.53s => 1.53
ijSubVersion = charCodeAt(getVersion, 10); // Gets subversion as unicode value. Eg: s --> 115.
// In case debugging needs to be done on the version code, use this remnant: print(getVersion() + " " + substring(getVersion(), 0, 4) + ijVersion + " " + ijSubVersion); 
if (!(ijVersion > 1.53 || (ijVersion == 1.53 && ijSubVersion >= 115))) // If imagej version is not 1.53s or greater...
{
	Dialog.createNonBlocking("WARNING");
	Dialog.addMessage("You are running ImageJ version " + getVersion() + ", which appears to be earlier than ImageJ 1.53s. Please advised that ATAT *may* malfunction on versions earlier than 1.53s.");
	
	/* 
	 * This commented out code is all obsolete and can be ignored. I'm leaving it in purely for future reference for myself - Alex
	 *
	 
	//RoiManager.translate(xmove, ymove);
	//Roi.move(BX, BY);
	//roiManager("update");
	//roiManager("translate", xmove, ymove); // Potentially will fix ROI shift bug; remove if it does not fix.
	//Roi.move(100, 100);
	//setSelectionLocation(200, 200); // set to -1, -1 ((100, 100):(201.240, 201.240), (0,0):(0,0), (200,200):(402.480,402.480), (470.9017, 585.6085):(470.902,585.609)
									// based on this we conclude that offset is given by y = 2.0124x
									// slope is microns/pixels ratio
									// we can get pixels with getWidth or something
	//setSelectionLocation(BX/2.0124, BY/2.0124);
	Roi.move(xROI, yROI);
	//setSelectionLocation(xROI, yROI);
	//Roi.move(xRoiCentroid, yRoiCentroid);
	//print("xRoiCentroid: " + xRoiCentroid + "; " + "yRoiCentroid: " + yRoiCentroid);
	
	print(xmove + " " + ymove + " " + BX + " " + BY);
	//waitForUser("rois should have been moved"); */
}
roiManager("translate", xROI, yROI);
Adiporoisname = AdipoROIsdir + replace(imagename, ".tif", "") + "AdipoROIs.zip";
roiManager("save selected", Adiporoisname);
roiManager("delete");
run("Select None");

//... IS THIS NECESSARY???

//removalcounter = 0;

//rois1 = roiManager('count');
//for (i=0; i<(rois1); i++){
//	n = i;
//	roiManager("select", n);
//	roiManager("Measure");
//	currentarea = getResult("Area", i);
//	toUnscaled(currentarea);
//	if (currentarea > 50000) {
//		m = n - removalcounter;
//		roiManager("select", m);
//		roiManager("delete");
//		removalcounter ++;
//	}
//}

//run("Clear Results");

rois1 = roiManager("count");
for (i=0; i<(rois1); i++){
	n = i;
	roiManager("select", n);
	run("Measure");
}

roiManager("Show All without labels");

PrevAreaCounter = 0;

for (i = 0; i < nResults(); i++) {
	currentarea = getResult("Area", i);
	//toScaled(currentarea);
	CurrentAreaCounter = PrevAreaCounter + currentarea;
	PrevAreaCounter = CurrentAreaCounter;
}

//if (outcome == 1) {
//	FibrousFraction = parseFloat(Table.get("FibrousArea", 0)) / parseFloat(Table.get("Analytic Area", 0));
//	selectWindow("Stats");
//	Table.setColumn("FibrousFraction");
//	Table.set("FibrousFraction", 0, FibrousFraction);
//}

//Table.deleteColumn("Block Thresholds");

MeanArea = CurrentAreaCounter / nResults;

Table.set("Mean Area", 0, MeanArea);
Table.set("Adipocyte Count", 0, nResults);
adipodensity = 1000000 * parseFloat(Table.get("Adipocyte Count", 0)) / parseFloat(Table.get("Analytic Area", 0));
Table.set("Adipocytes per mm^2", 0, adipodensity);

//Or statement???

if (FibrosityCaptureSettings != "Don't Capture") {
	setForegroundColor(0, 255, 0);
	selectWindow(rofimage3name);
	run("Duplicate...", " ");
	rename(rofimage4name);
	rois = roiManager("count");
	allrois = Array.getSequence(rois);
	roiManager("select", allrois);
	roiManager("combine");
	//ImageJ is screwed here. Doesn't allow subtractions greater than 25.
	//Only happens in Macro language.
	for (i = 0; i < 11; i++) {
		run("Subtract...", "value = 25");
	}
	roiManager("deselect")
	run("RGB Color");
	//setForegroundColor(0, 255, 0);
	
	
	
	FeretValues = newArray(nResults);
	for(i=0; i<nResults; i++) {
		FeretValues[i] = getResult("Feret", i);
	}
	
	Array.getStatistics(FeretValues, min, max, mean, stdDev);
	
	toScaled(max);
	
	// Setting length of analytic line.
	
	rmax = max*10;
	
	Table.create("Estimated Thickness for Pericellular Fibrosity");
	
	Table.setColumn("CellCount");
	Table.setColumn("ELine");
	Table.setColumn("SELine");
	Table.setColumn("SLine");
	Table.setColumn("SWLine");
	Table.setColumn("WLine");
	Table.setColumn("NWLine");
	Table.setColumn("NLine");
	Table.setColumn("NELine");
	//Table.setColumn("AverageThicknessPixels");
	Table.setColumn("AverageThickness");
	
	for (j = 0; j < nResults; j++) {
	
		// ELine
		//setForegroundColor(255, 0, 229);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			x1 = x00 + i;
			curint = getValue(x1, y0);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x1, y0);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		Table.set("ELine", j, poscount);
		
		// WLine
		//setForegroundColor(0, 255, 0);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			x1 = x00 - i;
			curint = getValue(x1, y0);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x1, y0);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		Table.set("WLine", j, poscount);
		
		// SLine
		//setForegroundColor(0, 255, 0);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			y1 = y00 + i;
			curint = getValue(x0, y1);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x0, y1);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		Table.set("SLine", j, poscount);
		
		// NLine
		//setForegroundColor(255, 0, 229);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			y1 = y00 - i;
			curint = getValue(x0, y1);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x0, y1);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		Table.set("NLine", j, poscount);
		
		//SELine
		//setForegroundColor(255, 0, 229);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			x1 = x00 + i;
			y1 = y00 + i;
			curint = getValue(x1, y1);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x1, y1);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		c = sqrt(2) * poscount;
		
		Table.set("SELine", j, c);
		
		//NWLine
		//setForegroundColor(0, 255, 0);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			x1 = x00 - i;
			y1 = y00 - i;
			curint = getValue(x1, y1);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x1, y1);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		c = sqrt(2) * poscount;
		
		Table.set("NWLine", j, c);
		
		//SWLine
		//setForegroundColor(0, 255, 0);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			x1 = x00 - i;
			y1 = y00 + i;
			curint = getValue(x1, y1);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x1, y1);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		c = sqrt(2) * poscount;
		
		Table.set("SWLine", j, c);
		
		//NELine
		//setForegroundColor(255, 0, 229);
		poscount = 0;
		for (i = 0; i < rmax; i++) {
			x0 = getResult("X", j);
			y0 = getResult("Y", j);
			toUnscaled(x0);
			toUnscaled(y0);
			x00 = floor(x0);
			y00 = floor(y0);
			x1 = x00 + i;
			y1 = y00 - i;
			curint = getValue(x1, y1);
			if (curint > 0) {
				poscount++;
				if (FibrosityCaptureSettings == "Display") {
					makePoint(x1, y1);
					roiManager("add");
					fill();
					run("Select None");
				}
			}
			if (curint == 0 && poscount > 0 && i > 0) {
				break;
			}
		}
		
		c = sqrt(2) * poscount;
		
		Table.set("NELine", j, c);
		
		for (i = 0; i < nResults; i++) {
			linetotal = parseFloat(Table.get("ELine", j)) + parseFloat(Table.get("SELine", j)) + parseFloat(Table.get("SLine", j)) + parseFloat(Table.get("SWLine", j)) + parseFloat(Table.get("WLine", j)) + parseFloat(Table.get("NWLine", j)) + parseFloat(Table.get("NLine", j)) + parseFloat(Table.get("NELine", j));
			lineaverage = linetotal/8;
			cellcount = j + 1;
			linearray = newArray(parseFloat(Table.get("ELine", j)), parseFloat(Table.get("SELine", j)), parseFloat(Table.get("SLine", j)), parseFloat(Table.get("SWLine", j)), parseFloat(Table.get("WLine", j)), parseFloat(Table.get("NWLine", j)), parseFloat(Table.get("NLine", j)), parseFloat(Table.get("NELine", j)));
			linearraycopy = linearray;
			Array.sort(linearraycopy);
			median = ((linearraycopy[3] + linearraycopy[4])/2) * one;
			Array.getStatistics(linearray, min, max, mean, stdDev);
			longerthickness = max;
			Table.set("CellCount", j, cellcount);

			avgscaledthickness = lineaverage * one;
			Table.set("AverageThickness", j, avgscaledthickness);
			maxscaledthickness = longerthickness * one;
			Table.set("LongestObservedThickness", j, maxscaledthickness);
			Table.set("MedianThickness", j, median);
		}
	
	}

	totalavgthicknessarray = Table.getColumn("AverageThickness");
	totalhighthicknessarray = Table.getColumn("LongestObservedThickness");
	totalmedianthicknessarray = Table.getColumn("MedianThickness");
	Array.getStatistics(totalavgthicknessarray, min, max, mean, stdDev);
	meanavgthickness = mean;
	Array.getStatistics(totalhighthicknessarray, min, max, mean, stdDev);
	meanhighthickness = mean;
	Array.getStatistics(totalmedianthicknessarray, min, max, mean, stdDev);
	meanmedianthickness = mean;
	selectWindow("Stats");
	Table.set("MeanAverageThickness", 0, meanavgthickness);
	Table.set("MeanHighestThickness", 0, meanhighthickness);
	Table.set("MeanMedianThickness", 0, meanmedianthickness);

}

savedmaskpath = technicaldir + replace(imagename, ".tif", "_Mask");
selectWindow(rofimage4name);
saveAs("tiff", savedmaskpath);

selectWindow("Stats");
Table.deleteColumn("Block Thresholds");
Table.deleteColumn("FibrousPixels");


if (outcome == 1) {
	FibrousFraction = parseFloat(Table.get("FibrousArea", 0)) / parseFloat(Table.get("Analytic Area", 0));
	selectWindow("Stats");
	Table.setColumn("FibrousFraction");
	Table.set("FibrousFraction", 0, FibrousFraction);
	Table.update;
}
//Table.deleteColumn("Block Thresholds");
if (FibrosityCaptureSettings != "Don't Capture") {
	selectWindow("Estimated Thickness for Pericellular Fibrosity");
	Table.update;
}

//Displays and results are handled.

// Comment from alex: i have no clue on which parts of this are legacy and which are not so im just gonna leave all of jacob's code here

AdipoResults1 = rawdatadir + imagename + "_AdipocyteData.csv";
AdipoResults = replace(AdipoResults1, ".tif", "");
selectWindow("Results");
rename(AdipoResults);
saveAs("Results", AdipoResults);
selectWindow(AdipoResults);
run("Close");


Table.create("Histogram Values");
Table.setColumn("Value", valuearray);
Table.setColumn("Count", countarray);

if (outcome == 1) {
	selectWindow("Mask");
	close();
}

//if (somesetting == save and display | save only) {
//	selectWindow("somesetting");
//	
//}

FibrosityResults1 = rawdatadir + imagename + "_FibrosityResults.csv";
FibrosityResults = replace(FibrosityResults1, ".tif", "");
fibtablename = replace(imagename, ".tif", "") + "_FibrosityResults.csv";
selectWindow("Estimated Thickness for Pericellular Fibrosity");
Table.rename("Estimated Thickness for Pericellular Fibrosity", fibtablename);
saveAs("Results", FibrosityResults);

selectWindow(fibtablename);
run("Close");
//selectWindow(rofimage4name);
//close();

// Must be coded to "if" statement!
// Comment from alex: what? no? why?

selectWindow("Stats");
StatsResults1 = rawdatadir + imagename + "_Stats.csv";
StatsResults = replace(StatsResults1, ".tif", "");
saveAs("Results", StatsResults);

selectWindow("Histogram Values");
HistoResults1 = rawdatadir + imagename + "_Histogram.csv";
HistoResults = replace(HistoResults1, ".tif", "");
saveAs("Results", HistoResults);

statsname = replace(imagename, ".tif", "") + "_Stats.csv";
selectWindow(statsname);
run("Close");

histoname = replace(imagename, ".tif", "") + "_Histogram.csv";
selectWindow(histoname);
run("Close");

// End "if" statements

//selectWindow(rofimage3name);
//run("Close");

//selectWindow(rofimage1name);
//run("Close");

//selectWindow(rofimage2name);
//run("Close");

//selectWindow(image2name);
//run("Close");

//selectWindow(image1name);
//run("Close");

//selectWindow(imagename);
//run("Close");

run("Close All");

//imagelastname = replace(imagename, ".tif", "-3.tif");
//lastimage = "Result of " + imagelastname;

//selectWindow(lastimage);
//run("Close");

roiManager("deselect");
roiManager("delete");

//selectWindow("ROI Manager");
//run("Close");

selectWindow("Results");
run("Close");
return "success";