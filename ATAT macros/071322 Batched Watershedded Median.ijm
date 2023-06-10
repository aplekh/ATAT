
//TO SOLVE:
//rofimage3 bug... fixed?
//analysis of last image??? Only happens when ROI-assisted --
//probably doesn't remove "analytic ROIs" folder from list of files



// Blur radius variable (in analytic macro) sometimes broken. This does not always occur... why???
//Fixed, it seems. Selecting the table window seemed to fix it.

inputdir = getDirectory("Choose Source Directory ");
inputdirname = File.getName(inputdir);
OutputDir = getDirectory("Choose Output Directory");

imagejdir = getDirectory("imagej");
foldername = "PATTI/";
filename1 = "PATTI Capture Settings.csv";
finaldir1 = imagejdir + foldername + filename1;

SettingsStatus = File.exists(finaldir1);

if (SettingsStatus == 0) {
	Table.create("Settings");
	
	Table.set("Adipocyte Results", 0, "Display and Save Results");
	Table.set("Fibrosity Capture Settings", 0, "Capture Only");
	
	Table.set("Blur Radius", 0, 3);
	Table.set("Minimum Circularity", 0, 0.4);
	Table.set("Minimum Particle Size", 0, 300);
	Table.set("Maximum Particle Size", 0, 30000);

	Table.set("HistoBuddy", 0, "No"); 
	Table.set("Adipocyte Bin Size", 0, 500);
	Table.set("Average Fibrosity Bin Size", 0, 1);
	Table.set("Highest Observed Fibrosity Bin Size", 0, 5);

	Table.set("OutputDir", 0, OutputDir);
	
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
	
} else {
	open(finaldir1);
	Table.set("OutputDir", 0, OutputDir);
	saveAs("Results", finaldir1);
}

//OutputDir = Table.getString("OutputDir", 0);

HistoBuddySetting = Table.getString("HistoBuddy", 0);
AdipoBinSize = parseFloat(Table.get("Adipocyte Bin Size", 0));
AvgFibBinSize = parseFloat(Table.get("Average Fibrosity Bin Size", 0));
MaxFibBinSize = parseFloat(Table.get("Highest Observed Fibrosity Bin Size", 0));

IJ.renameResults("PATTI Capture Settings.csv", "Results");
run("Clear Results");

//inputdir = getDirectory("Choose Source Directory ");
//inputdirname = File.getName(inputdir);
//OutputDir = getDirectory("Choose Output Directory");


rawdatadir = OutputDir + "Data/";
AdipoROIsdir = OutputDir + "AdipoROIs/";
technicaldir = OutputDir + "Technical Files/";
File.makeDirectory(rawdatadir);
File.makeDirectory(AdipoROIsdir);
File.makeDirectory(technicaldir);

files = getFileList(inputdir);
//Table.setColumn("File Names", files);
//Table.update;

files = Array.deleteValue(files, "analyticROIs/");
samplenames = newArray(files.length);

for (i = 0; i < files.length; i++) {
	samplenames[i] = replace(files[i], ".tif", "");
}




//samplenames = Array.deleteValue(files, "analyticROIs/");

for (i = 0; i < samplenames.length; i++) {
	currentname = replace(samplenames[i], ".tif", "");
	samplenames[i] = currentname;
}

imagejdir = getDirectory("imagej");

filecount = files.length;

roidirname = inputdir + "/analyticROIs/";

roidirstatus = File.exists(roidirname);

//Table.rename("Results", "Image Files");
//setBatchMode("true");

roiManager("deselect");

for (z = 0; z < filecount; z++) {
	setBatchMode(true);
	filename = files[z];
	fullcurrentname = inputdir + filename;
	open(fullcurrentname);
	//Fixing imagename issues.
	imagename = replace(getTitle(), ".Tif", ".tif");
	rename(imagename);
	//
	fullcurrentroiname = inputdir + "/analyticROIs/" + replace(filename, ".tif", "") + "analyticROIs.zip";
	roifilestatus = File.exists(fullcurrentroiname);
	if (roifilestatus == 1) {
		roiManager("open", fullcurrentroiname);
	}
	runMacro("071322 Adipocyte Capture with Watershedding and Median Blur.ijm");
}

currentsamplename = newArray(filecount);
currentpeakval = newArray(filecount);
currentpeakcount = newArray(filecount);
currentredstatus = newArray(filecount);
currentbluestatus = newArray(filecount);
currentgreenstatus = newArray(filecount);
currentanalyticarea = newArray(filecount);
currenttailvalue = newArray(filecount);
currentderivative = newArray(filecount);
currentscale = newArray(filecount);
currentfibrousarea = newArray(filecount);
currentweightedaverage = newArray(filecount);
currentmeanarea = newArray(filecount);
currentadipocount = newArray(filecount);
currentadipodensity = newArray(filecount);
currentmeanavgthickness = newArray(filecount);
currentmeanhighthickness = newArray(filecount);
currentmeanmedianthickness = newArray(filecount);
currentfibrousfraction = newArray(filecount);

for (i = 0; i < filecount; i++) {
	currentfile = samplenames[i];
	currentfilestatsnameprime = rawdatadir + currentfile + "_Stats.csv";
	currentfilestatsname = replace(currentfilestatsnameprime, ".Tif", "");
	Table.open(currentfilestatsname);
	currentsamplename[i] = currentfile;
	currentpeakval[i] = Table.get("PeakValue", 0);
	currentpeakcount[i] = Table.get("PeakCount", 0);
	currentredstatus[i] = Table.get("Red", 0);
	currentbluestatus[i] = Table.get("Blue", 0);
	currentgreenstatus[i] = Table.get("Green", 0);
	currentanalyticarea[i] = Table.get("Analytic Area", 0);
	currenttailvalue[i] = Table.get("TailValue", 0);
	currentderivative[i] = Table.get("Derivative", 0);
	currentscale[i] = Table.get("Scale", 0);
	currentfibrousarea[i] = Table.get("FibrousArea", 0);
	currentweightedaverage[i] = Table.get("WeightedAverage", 0);
	currentmeanarea[i] = Table.get("Mean Area", 0);
	currentadipocount[i] = Table.get("Adipocyte Count", 0);
	currentadipodensity[i] = Table.get("Adipocytes per mm^2", 0);
	currentmeanavgthickness[i] = Table.get("MeanAverageThickness", 0);
	currentmeanhighthickness[i] = Table.get("MeanHighestThickness", 0);
	currentmeanmedianthickness[i] = Table.get("MeanMedianThickness", 0);
	currentfibrousfraction[i] = Table.get("FibrousFraction", 0);
	currentstatsnameprime = currentfile + "_Stats.csv";
	currentstatsname = replace(currentstatsnameprime, ".Tif", "");
	IJ.renameResults(currentstatsname, "Results");
	run("Clear Results");
}

firstfilename = files[0];
firstfiletiffcheck = endsWith(firstfilename, ".tif");
if (firstfiletiffcheck == 1) {
	timegiverpath = rawdatadir + replace(firstfilename, ".tif", "_Stats.csv");
	analysistime = File.dateLastModified(timegiverpath);
	lasttablename = inputdirname + replace(analysistime, ":", "_") + "_SummarizedResults";
} else {
	secondfilename = files[1];
	timegiverpath = rawdatadir + replace(secondfilename, ".tif", "_Stats.csv");
	analysistime = File.dateLastModified(timegiverpath);
	lasttablename = inputdirname + replace(analysistime, ":", "_") + "_SummarizedResults";
}

Table.create(lasttablename);

Table.setColumn("Sample ID", currentsamplename);
Table.setColumn("PeakValue", currentpeakval);
Table.setColumn("PeakCount", currentpeakcount);
Table.setColumn("Red", currentredstatus);
Table.setColumn("Blue", currentbluestatus);
Table.setColumn("Green", currentgreenstatus);
Table.setColumn("Analytic Area", currentanalyticarea);
Table.setColumn("TailValue", currenttailvalue);
Table.setColumn("Derivative", currentderivative);
Table.setColumn("Scale", currentscale);
Table.setColumn("FibrousArea", currentfibrousarea);
Table.setColumn("WeightedAverage", currentweightedaverage);
Table.setColumn("Mean Area", currentmeanarea);
Table.setColumn("Adipocyte Count", currentadipocount);
Table.setColumn("Adipocytes per mm^2", currentadipodensity);
Table.setColumn("MeanAverageThickness", currentmeanavgthickness);
Table.setColumn("MeanHighestThickness", currentmeanhighthickness);
Table.setColumn("MeanMedianThickness", currentmeanmedianthickness);
Table.setColumn("FibrousFraction", currentfibrousfraction);

selectWindow(lasttablename);
lasttablecsv = lasttablename + ".csv";
concatresultsfulldir = rawdatadir + lasttablecsv;
saveAs("Results", concatresultsfulldir);
IJ.renameResults(lasttablecsv, "Results");
run("Clear Results");
selectWindow("Results");
run("Close");


concatadiponame = inputdirname + replace(analysistime, ":", "_") + "_FullAdipocytes.csv";
Table.create("FullAdipocytes");


for (i = 0; i < filecount; i++) {
	currentfile = replace(samplenames[i], ".Tif", "");
	currentadipofilename = currentfile + "_AdipocyteData.csv";
	currentadipodir = rawdatadir + currentadipofilename;
	Table.open(currentadipodir);
	selectWindow(currentadipofilename);
	currentadipoarray = Table.getColumn("Area");
	selectWindow("FullAdipocytes");
	currentadiposamplename = currentfile;
	Table.setColumn(currentadiposamplename, currentadipoarray);
	
	IJ.renameResults(currentadipofilename, "Results");
	run("Clear Results");
}


selectWindow("FullAdipocytes");
adipocsv = concatadiponame + ".csv";
concatadipofulldir = rawdatadir + adipocsv;
saveAs("Results", concatadipofulldir);
IJ.renameResults(adipocsv, "Results");
run("Clear Results");
selectWindow("Results");
run("Close");

concatmeanfibname = inputdirname + replace(analysistime, ":", "_") + "_FullMeanFibrosity.csv";
Table.create("FullMeanFibrosity");

for (i = 0; i < filecount; i++) {
	currentfile = replace(samplenames[i], ".Tif", "");
	currentmeanfibfilename = currentfile + "_FibrosityResults.csv";
	currentmeanfibdir = rawdatadir + currentmeanfibfilename;
	Table.open(currentmeanfibdir);
	selectWindow(currentmeanfibfilename);
	currentmeanfibarray = Table.getColumn("AverageThickness");
	selectWindow("FullMeanFibrosity");
	currentmeanfibsamplename = currentfile;
	Table.setColumn(currentmeanfibsamplename, currentmeanfibarray);
	
	IJ.renameResults(currentmeanfibfilename, "Results");
	run("Clear Results");
}

selectWindow("FullMeanFibrosity");
meanfibcsv = concatmeanfibname + ".csv";
concatmeanfibfulldir = rawdatadir + meanfibcsv;
saveAs("Results", concatmeanfibfulldir);
IJ.renameResults(meanfibcsv, "Results");
run("Clear Results");
selectWindow("Results");
run("Close");

//Kill all past here if it breaks

concatMedianfibname = inputdirname + replace(analysistime, ":", "_") + "_FullMedianFibrosity";
Table.create("FullMedianFibrosity");

for (i = 0; i < filecount; i++) {
	currentfile = replace(samplenames[i], ".Tif", "");
	currentMedianfibfilename = currentfile + "_FibrosityResults.csv";
	currentMedianfibdir = rawdatadir + currentMedianfibfilename;
	Table.open(currentMedianfibdir);
	selectWindow(currentMedianfibfilename);
	currentMedianfibarray = Table.getColumn("MedianThickness");
	selectWindow("FullMedianFibrosity");
	currentMedianfibsamplename = currentfile;
	Table.setColumn(currentMedianfibsamplename, currentMedianfibarray);
	
	IJ.renameResults(currentMedianfibfilename, "Results");
	run("Clear Results");
}

selectWindow("FullMedianFibrosity");
Medianfibcsv = concatMedianfibname + ".csv";
concatMedianfibfulldir = rawdatadir + Medianfibcsv;
saveAs("Results", concatMedianfibfulldir);
IJ.renameResults(Medianfibcsv, "Results");
run("Clear Results");
selectWindow("Results");
run("Close");

concatLongestObservedfibname = inputdirname + replace(analysistime, ":", "_") + "_FullLongestObservedFibrosity";
Table.create("FullLongestObservedFibrosity");

for (i = 0; i < filecount; i++) {
	currentfile = replace(samplenames[i], ".Tif", "");
	currentLongestObservedfibfilename = currentfile + "_FibrosityResults.csv";
	currentLongestObservedfibdir = rawdatadir + currentLongestObservedfibfilename;
	Table.open(currentLongestObservedfibdir);
	selectWindow(currentLongestObservedfibfilename);
	currentLongestObservedfibarray = Table.getColumn("LongestObservedThickness");
	selectWindow("FullLongestObservedFibrosity");
	currentLongestObservedfibsamplename = currentfile;
	Table.setColumn(currentLongestObservedfibsamplename, currentLongestObservedfibarray);
	
	IJ.renameResults(currentLongestObservedfibfilename, "Results");
	run("Clear Results");
}

selectWindow("FullLongestObservedFibrosity");
LongestObservedfibcsv = concatLongestObservedfibname + ".csv";
concatLongestObservedfibfulldir = rawdatadir + LongestObservedfibcsv;
saveAs("Results", concatLongestObservedfibfulldir);
IJ.renameResults(LongestObservedfibcsv, "Results");
run("Clear Results");
selectWindow("Results");
run("Close");

if (HistoBuddySetting == "Yes") {

	//Getting the MaxFib bin count.
	Table.open(concatLongestObservedfibfulldir);
	for (i = 0; i < filecount; i++) {
		currentsample = replace(samplenames[i], ".Tif", "");
		currentarray = Table.getColumn(currentsample);
			
		if (i == 0) {
		totalmaxarray = currentarray;
		} else {
			totalmaxarray = Array.concat(totalmaxarray,currentarray);
		}

	}
	Table.rename(LongestObservedfibcsv, "Results");
	run("Clear Results");
	run("Close");

	Array.getStatistics(totalmaxarray, min, max, mean, stdDev);
	maxval = max;
	MaxFibBinCount = floor(maxval/MaxFibBinSize) + 1;

	//Getting the MedianFib bin count.
	Table.open(concatMedianfibfulldir);
	for (i = 0; i < filecount; i++) {
		currentsample = replace(samplenames[i], ".Tif", "");
		currentarray = Table.getColumn(currentsample);
			
		if (i == 0) {
		totalmedianarray = currentarray;
		} else {
		totalmedianarray = Array.concat(totalmedianarray,currentarray);
		}
	}
	Table.rename(Medianfibcsv, "Results");
	run("Clear Results");
	run("Close");
	Array.getStatistics(totalmedianarray, min, max, mean, stdDev);
	maxval = max;
	MedianFibBinCount = floor(maxval/AvgFibBinSize) + 1;

	//Getting the MeanFib bin count.
	Table.open(concatmeanfibfulldir);
	for (i = 0; i < filecount; i++) {
		currentsample = replace(samplenames[i], ".Tif", "");
		currentarray = Table.getColumn(currentsample);
		
		if (i == 0) {
		totalmeanarray = currentarray;
		} else {
		totalmeanarray = Array.concat(totalmeanarray,currentarray);
		}
	}
	Table.rename(meanfibcsv, "Results");
	run("Clear Results");
	run("Close");
	Array.getStatistics(totalmeanarray, min, max, mean, stdDev);
	maxval = max;
	MeanFibBinCount = floor(maxval/AvgFibBinSize) + 1;


	// Using the larger of the two averages' bin counts for both.
	if (MeanFibBinCount > MedianFibBinCount) {
		AvgFibBinCount = MeanFibBinCount;
	} else {
		AvgFibBinCount = MedianFibBinCount;
	}

	//Creating arrays that list the bins.
	MaxFibBinArray = newArray(MaxFibBinCount);
	AvgFibBinArray = newArray(AvgFibBinCount);
	
	for (i = 0; i < MaxFibBinCount; i++) {
		lowerthresh = MaxFibBinSize * i;
		MaxFibBinArray[i] = lowerthresh;
	}

	for (i = 0; i < AvgFibBinCount; i++) {
		lowerthresh = AvgFibBinSize * i;
		AvgFibBinArray[i] = lowerthresh;
	}

	//Let's bin out the total max fibrosity first.
	//Assigning bins to each cell.

	cellcount = totalmeanarray.length;

	MaxFibBinCounter = newArray(cellcount);

	for (i = 0; i < cellcount; i++) {
		currentval = totalmaxarray[i];
		currentbin = floor(currentval/MaxFibBinSize);
		MaxFibBinCounter[i] = currentbin;
	}

	//Calculating concentrations of cell size across bins.

	maxfibbinnedarray = newArray(MaxFibBinCount);

	for (i = 0; i < MaxFibBinCount; i++) {
		currentbincount = 0;
		for (v = 0; v < cellcount; v++) {	
			if (MaxFibBinCounter[v] == i) {
				currentbincount++;
			}
		maxfibbinnedarray[i] = currentbincount;
		}
	}

	// Now we do MaxFib file by file. Hopefully all in this j loop.

	Table.create("Longest Observed Fibrosity Binned Results");
	Table.setColumn("Bins", MaxFibBinArray);

	proportionarray = newArray();

	for (j = 0; j < samplenames.length; j++) {
		//Creating an array into which our binning data will be temporarily stored.
		currentmaxfibbincounter = newArray();
		//Pulling raw data.
		currentsample = replace(samplenames[j], ".Tif", "");
		currentsampletablename = currentsample + "_FibrosityResults.csv";
		currentsamplefulldir = rawdatadir + currentsample + "_FibrosityResults.csv";
		Table.open(currentsamplefulldir);
		currentrawdataarray = Table.getColumn("LongestObservedThickness");
		IJ.renameResults(currentsampletablename, "Results");
		run("Clear Results");
		selectWindow("Results");
		run("Close");
		//Assigning bins to each cell.
		for (i = 0; i < currentrawdataarray.length; i++) {
			currentval = currentrawdataarray[i];
			currentbin = floor(currentval/MaxFibBinSize);
			currentmaxfibbincounter[i] = currentbin;
		}
	
		
		
		for (i = 0; i < MaxFibBinCount; i++) {
			currentbincount = 0;
			for (v = 0; v < currentrawdataarray.length; v++) {	
				if (currentmaxfibbincounter[v] == i) {
					currentbincount++;
				}
			proportionarray[i] = currentbincount;
			}
		}
		selectWindow("Longest Observed Fibrosity Binned Results");
		Table.update;
		Table.setColumn(currentsample, proportionarray);
	}

	Table.setColumn("Total", maxfibbinnedarray);

	//Place this before a table has closed. It only alters the table -- no external variables needed!

	for (j = 0; j < samplenames.length; j++) {
		currentarray = Table.getColumn(samplenames[j]);
		currentarraytotal = 0;
		for (i = 0; i < currentarray.length; i++) {
			currentarraytotal = currentarraytotal + currentarray[i];
		}

		dividedarray = newArray(currentarray.length);
		dividedarrayname = samplenames[j] + "Proportions";
		for (i = 0; i < currentarray.length; i++) {
			dividedarray[i] = currentarray[i] / currentarraytotal;
		}
		Table.setColumn(dividedarrayname, dividedarray);
	
	}

	totalarray = Table.getColumn("Total");
	totaldividedarray = newArray(totalarray.length);
	totalarraytotal = 0;
	for (j = 0; j < totalarray.length; j++) {
		totalarraytotal = totalarraytotal + totalarray[j];
	}

	
	for (j = 0; j < totalarray.length; j++) {
		totaldividedarray[j] = totalarray[j]/totalarraytotal;
	}
	Table.setColumn("Total Proportions", totaldividedarray);

	//The table can be saved and closed now.

	selectWindow("Longest Observed Fibrosity Binned Results");
	LOFBRname = rawdatadir + inputdirname + replace(analysistime, ":", "_") + "_Longest Observed Fibrosity Binned Results" + ".csv";
	LOFBRtablename = inputdirname + replace(analysistime, ":", "_") + "_Longest Observed Fibrosity Binned Results" + ".csv";
	saveAs("results", LOFBRname);
	IJ.renameResults(LOFBRtablename, "Results");
	run("Clear Results");
	run("Close");

	//MaxFib is done. I will try to repeat this with Mean, Median, and Adipo.

	//Median!

	cellcount = totalmeanarray.length;

	MedianFibBinCounter = newArray(cellcount);

	for (i = 0; i < cellcount; i++) {
		currentval = totalmedianarray[i];
		currentbin = floor(currentval/ AvgFibBinSize);
		MedianFibBinCounter[i] = currentbin;
	}

	//Calculating concentrations of cell size across bins.

	medianfibbinnedarray = newArray(AvgFibBinCount);

	for (i = 0; i < AvgFibBinCount; i++) {
		currentbincount = 0;
		for (v = 0; v < cellcount; v++) {	
			if (MedianFibBinCounter[v] == i) {
				currentbincount++;
			}
		medianfibbinnedarray[i] = currentbincount;
		}
	}

	// Now we do MedianFib file by file. Hopefully all in this j loop.

	Table.create("Median Fibrosity Binned Results");
	Table.setColumn("Bins", AvgFibBinArray);

	proportionarray = newArray();

	for (j = 0; j < samplenames.length; j++) {
		//Creating an array into which our binning data will be temporarily stored.
		currentmedianfibbincounter = newArray();
		//Pulling raw data.
		currentsample = replace(samplenames[j], ".Tif", "");
		currentsampletablename = currentsample + "_FibrosityResults.csv";
		currentsamplefulldir = rawdatadir + currentsample + "_FibrosityResults.csv";
		Table.open(currentsamplefulldir);
		currentrawdataarray = Table.getColumn("MedianThickness");
		IJ.renameResults(currentsampletablename, "Results");
		run("Clear Results");
		selectWindow("Results");
		run("Close");
		//Assigning bins to each cell.
		for (i = 0; i < currentrawdataarray.length; i++) {
			currentval = currentrawdataarray[i];
			currentbin = floor(currentval/AvgFibBinSize);
			currentmedianfibbincounter[i] = currentbin;
		}
	
		
		
		for (i = 0; i < AvgFibBinCount; i++) {
			currentbincount = 0;
			for (v = 0; v < currentrawdataarray.length; v++) {	
				if (currentmedianfibbincounter[v] == i) {
					currentbincount++;
				}
			proportionarray[i] = currentbincount;
			}
		}
		selectWindow("Median Fibrosity Binned Results");
		Table.update;
		Table.setColumn(currentsample, proportionarray);
	}

	Table.setColumn("Total", medianfibbinnedarray);

	//Place this before a table has closed. It only alters the table -- no external variables needed!

	for (j = 0; j < samplenames.length; j++) {
		currentarray = Table.getColumn(samplenames[j]);
		currentarraytotal = 0;
		for (i = 0; i < currentarray.length; i++) {
			currentarraytotal = currentarraytotal + currentarray[i];
		}

		dividedarray = newArray(currentarray.length);
		dividedarrayname = samplenames[j] + "Proportions";
		for (i = 0; i < currentarray.length; i++) {
			dividedarray[i] = currentarray[i] / currentarraytotal;
		}
		Table.setColumn(dividedarrayname, dividedarray);
	
	}

	totalarray = Table.getColumn("Total");
	totaldividedarray = newArray(totalarray.length);
	totalarraytotal = 0;
	for (j = 0; j < totalarray.length; j++) {
		totalarraytotal = totalarraytotal + totalarray[j];
	}

	
	for (j = 0; j < totalarray.length; j++) {
		totaldividedarray[j] = totalarray[j]/totalarraytotal;
	}
	Table.setColumn("Total Proportions", totaldividedarray);

	//The table can be saved and closed now.

	selectWindow("Median Fibrosity Binned Results");
	MedFibBRname = rawdatadir + inputdirname + replace(analysistime, ":", "_") + "_Median Fibrosity Binned Results" + ".csv";
	MedFibBRtablename = inputdirname + replace(analysistime, ":", "_") + "_Median Fibrosity Binned Results" + ".csv";
	saveAs("results", MedFibBRname);
	IJ.renameResults(MedFibBRtablename, "Results");
	run("Clear Results");
	selectWindow("Results");
	run("Close");

	// Let's get MEAN!

	cellcount = totalmeanarray.length;

	MeanFibBinCounter = newArray(cellcount);

	for (i = 0; i < cellcount; i++) {
		currentval = totalmeanarray[i];
		currentbin = floor(currentval/ AvgFibBinSize);
		MeanFibBinCounter[i] = currentbin;
	}

	//Calculating concentrations of cell size across bins.

	meanfibbinnedarray = newArray(AvgFibBinCount);

	for (i = 0; i < AvgFibBinCount; i++) {
		currentbincount = 0;
		for (v = 0; v < cellcount; v++) {	
			if (MeanFibBinCounter[v] == i) {
				currentbincount++;
			}
		meanfibbinnedarray[i] = currentbincount;
		}
	}

	// Now we do MeanFib file by file. Hopefully all in this j loop.

	Table.create("Mean Fibrosity Binned Results");
	Table.setColumn("Bins", AvgFibBinArray);

	proportionarray = newArray();

	for (j = 0; j < samplenames.length; j++) {
		//Creating an array into which our binning data will be temporarily stored.
		currentmeanfibbincounter = newArray();
		//Pulling raw data.
		currentsample = replace(samplenames[j], ".Tif", "");
		currentsampletablename = currentsample + "_FibrosityResults.csv";
		currentsamplefulldir = rawdatadir + currentsample + "_FibrosityResults.csv";
		Table.open(currentsamplefulldir);
		currentrawdataarray = Table.getColumn("AverageThickness");
		IJ.renameResults(currentsampletablename, "Results");
		run("Clear Results");
		selectWindow("Results");
		run("Close");
		//Assigning bins to each cell.
		for (i = 0; i < currentrawdataarray.length; i++) {
			currentval = currentrawdataarray[i];
			currentbin = floor(currentval/AvgFibBinSize);
			currentmeanfibbincounter[i] = currentbin;
		}
	
		
		
		for (i = 0; i < AvgFibBinCount; i++) {
			currentbincount = 0;
			for (v = 0; v < currentrawdataarray.length; v++) {	
				if (currentmeanfibbincounter[v] == i) {
					currentbincount++;
				}
			proportionarray[i] = currentbincount;
			}
		}
		selectWindow("Mean Fibrosity Binned Results");
		Table.update;
		Table.setColumn(currentsample, proportionarray);
	}

	Table.setColumn("Total", meanfibbinnedarray);

	//Place this before a table has closed. It only alters the table -- no external variables needed!

	for (j = 0; j < samplenames.length; j++) {
		currentarray = Table.getColumn(samplenames[j]);
		currentarraytotal = 0;
		for (i = 0; i < currentarray.length; i++) {
			currentarraytotal = currentarraytotal + currentarray[i];
		}

		dividedarray = newArray(currentarray.length);
		dividedarrayname = samplenames[j] + "Proportions";
		for (i = 0; i < currentarray.length; i++) {
			dividedarray[i] = currentarray[i] / currentarraytotal;
		}
		Table.setColumn(dividedarrayname, dividedarray);
	
	}

	totalarray = Table.getColumn("Total");
	totaldividedarray = newArray(totalarray.length);
	totalarraytotal = 0;
	for (j = 0; j < totalarray.length; j++) {
		totalarraytotal = totalarraytotal + totalarray[j];
	}

	
	for (j = 0; j < totalarray.length; j++) {
		totaldividedarray[j] = totalarray[j]/totalarraytotal;
	}
	Table.setColumn("Total Proportions", totaldividedarray);

	//The table can be saved and closed now.

	selectWindow("Mean Fibrosity Binned Results");
	MeanFibBRname = rawdatadir + inputdirname + replace(analysistime, ":", "_") + "_Mean Fibrosity Binned Results" + ".csv";
	MeanFibBRtablename = inputdirname + replace(analysistime, ":", "_") + "_Mean Fibrosity Binned Results" + ".csv";
	saveAs("results", MeanFibBRname);
	IJ.renameResults(MeanFibBRtablename, "Results");
	run("Clear Results");
	run("Close");

	//Let’s get FAT!

	//Getting the Adipocyte bin count.
	Table.open(concatadipofulldir);
	for (i = 0; i < filecount; i++) {
		currentsample = replace(samplenames[i], ".Tif", "");
		currentarray = Table.getColumn(currentsample);
		
		if (i == 0) {
		totaladipoarray = currentarray;
		} else {
		totaladipoarray = Array.concat(totaladipoarray,currentarray);
		}
	}
	Table.rename(adipocsv, "Results");
	run("Clear Results");
	run("Close");
	Array.getStatistics(totaladipoarray, min, max, mean, stdDev);
	maxval = max;
	AdipoBinCount = floor(maxval/ AdipoBinSize) + 1;


	// Create an array that lists adipo-bins

	AdipoBinArray = newArray(AdipoBinCount);
	for (i=0; i < AdipoBinArray.length; i++) {
		AdipoBinArray[i] = AdipoBinSize * i;
	}

	cellcount = totalmeanarray.length;

	AdipoBinCounter = newArray(cellcount);

	for (i = 0; i < cellcount; i++) {
		currentval = totaladipoarray [i];
		currentbin = floor(currentval/ AdipoBinSize);
		AdipoBinCounter[i] = currentbin;
	}

	//Calculating concentrations of cell size across bins.

	adipobinnedarray = newArray(AdipoBinCount);

	for (i = 0; i < AdipoBinCount; i++) {
		currentbincount = 0;
		for (v = 0; v < cellcount; v++) {	
			if (AdipoBinCounter[v] == i) {
				currentbincount++;
			}
		adipobinnedarray[i] = currentbincount;
		}
	}

	// Now we do Adipo file by file. Hopefully all in this j loop.

	Table.create("Adipocyte Area Binned Results");
	Table.setColumn("Bins", AdipoBinArray);

	proportionarray = newArray();
	currentadipobincounter = newArray();

	for (j = 0; j < samplenames.length; j++) {
		//Creating an array into which our binning data will be temporarily stored.
		adipobincounter = newArray();
		//Pulling raw data.
		currentsample = replace(samplenames[j], ".Tif", "");
		currentsampletablename = currentsample + "_AdipocyteData.csv";
		currentsamplefulldir = rawdatadir + currentsample + "_AdipocyteData.csv";
		Table.open(currentsamplefulldir);
		currentrawdataarray = Table.getColumn("Area");
		IJ.renameResults(currentsampletablename, "Results");
		run("Clear Results");
		selectWindow("Results");
		run("Close");
		//Assigning bins to each cell.
		for (i = 0; i < currentrawdataarray.length; i++) {
			currentval = currentrawdataarray[i];
			currentbin = floor(currentval/AdipoBinSize);
			currentadipobincounter[i] = currentbin;
		}
	
		
		
		for (i = 0; i < AdipoBinCount; i++) {
			currentbincount = 0;
			for (v = 0; v < currentrawdataarray.length; v++) {	
				if (currentadipobincounter[v] == i) {
					currentbincount++;
				}
			proportionarray[i] = currentbincount;
			}
		}
		selectWindow("Adipocyte Area Binned Results");
		Table.update;
		Table.setColumn(currentsample, proportionarray);
	}

	Table.setColumn("Total", adipobinnedarray);

	//Place this before a table has closed. It only alters the table -- no external variables needed!

	for (j = 0; j < samplenames.length; j++) {
		currentarray = Table.getColumn(samplenames[j]);
		currentarraytotal = 0;
		for (i = 0; i < currentarray.length; i++) {
			currentarraytotal = currentarraytotal + currentarray[i];
		}

		dividedarray = newArray(currentarray.length);
		dividedarrayname = samplenames[j] + "Proportions";
		for (i = 0; i < currentarray.length; i++) {
			dividedarray[i] = currentarray[i] / currentarraytotal;
		}
		Table.setColumn(dividedarrayname, dividedarray);
	
	}

	totalarray = Table.getColumn("Total");
	totaldividedarray = newArray(totalarray.length);
	totalarraytotal = 0;
	for (j = 0; j < totalarray.length; j++) {
		totalarraytotal = totalarraytotal + totalarray[j];
	}

	
	for (j = 0; j < totalarray.length; j++) {
		totaldividedarray[j] = totalarray[j]/totalarraytotal;
	}
	Table.setColumn("Total Proportions", totaldividedarray);

	//The table can be saved and closed now.

	selectWindow("Adipocyte Area Binned Results");
	AdipoBRname = rawdatadir + inputdirname + replace(analysistime, ":", "_") + "_Adipocyte Area Binned Results" + ".csv";
	AdipoBRtablename = inputdirname + replace(analysistime, ":", "_") + "_Adipocyte Area Binned Results" + ".csv";
	saveAs("results", AdipoBRname);
	IJ.renameResults(AdipoBRtablename, "Results");
	run("Clear Results");
	run("Close");
}

open(finaldir1);
settingsrecordname = replace(analysistime, ":", "_") + "CaptureSettings.csv";
Table.rename("PATTI Capture Settings.csv" + settingsrecordname);
settingsrecordpath = technicaldir + settingsrecordname;
saveAs("results", settingsrecordpath);
selectWindow(settingsrecordname);
run("Close");