roicount = roiManager("count");

/*Dialog.create("Information - ROI assisted ATAT");
Dialog.addMessage("Select a source directory for the images you wish to analyse.\n \nThen select any analytic ROIs (one or multiple per image), add \nthem to the ROI manager, and then *run this setup again*.\n \nYour ROIs will be saved and the next image will be opened for \nROI-setting.\n \nThen run AT-AT's analysis normally. It will automatically check \nto see whether the desired analytic ROIs are present.");
Dialog.show();*/
//inputdir = getDirectory("Choose Source Directory ");


//files = getFileList(inputdir);
//Table.setColumn("File Names", files);
//Array.print(files);

//imagejdir = getDirectory("imagej");

//setBatchMode(true);

runcount = 0;

//if (runcount == 0) {
//	filecount = nResults;
//}

//Table.rename("Results", "Image Files");

imagejdir = getDirectory("imagej");
newfullnamerc = imagejdir + "RunCount";
tablestate = File.exists(newfullnamerc);

if (tablestate == 1) { // This will never happen if tablestate is 10. Preserving conditional statement just in case. Originally, this statement was tablestate == 1, not tablestate == 10, but this seems to be legacy code that was causing bugs involving a "RunCount" file. tablestate can only be 0 (false) and 1 (true). 
	Table.open(newfullnamerc);
	inputdir = Table.getString("InputDir", 0);
	currentruncount = parseFloat(Table.get("RunCount", 0)) + 1;
} else { // This case will always happen since tablestate can never be 10.
	Table.create("RunCount");
	Table.set("RunCount", 0, 0);
	//setResult("RunCount", 0, 0);
	//set up the input directory.
	inputdir = getDirectory("Choose Source Directory ");
	Table.set("InputDir", 0, inputdir);
	currentruncount = 0;
}

/*if (File.exists(inputdir + "\\analyticROIs\\"))
{
	File.delete(inputdir + "\\analyticROIs\\");
}*/

/*if (currentruncount == 0)
{
	Dialog.create("Information - ROI assisted ATAT");
	Dialog.addMessage("Select a source directory for the images you wish to analyse.\n \nThen select any analytic ROIs (one or multiple per image), add \nthem to the ROI manager, and then *run this setup again*.\n \nYour ROIs will be saved and the next image will be opened for \nROI-setting.\n \nThen run AT-AT's analysis normally. It will automatically check \nto see whether the desired analytic ROIs are present.");
	Dialog.show();
}*/

if (tablestate == 0) {
	files = getFileList(inputdir);
	Table.setColumn("File Names", files);
	filecount = files.length;
} else {
	filecount = Table.size;
}

for (i = 0; i < filecount; i++) {
	filecheck = Table.getString("File Names", i);
	if (filecheck == "analyticROIs/") {
		Table.deleteRows(i, i);
		//IJ.renameResults("Results","RunCount");
		exit("You have subdirectories in your image input directory!");
		filecount--;
	}
}

if (filecount < currentruncount) {
	previmage = Table.getString("File Names", currentruncount);
} else {
	prevruncountdup = currentruncount - 1;
	previmage = Table.getString("File Names", prevruncountdup);
}

print(previmage);
roidir0 = inputdir + "analyticROIs" + File.separator;
File.makeDirectory(roidir0);
print(roidir0);
roidir1 = roidir0 + previmage;
roidir2 = replace(roidir1, ".tif", "") + "analyticROIs.zip";

if (roicount == 1) {
	roiManager("select", 0);
	roiManager("save selected", roidir2);
	roiManager("deselect");
	roiManager("delete");
	run("Select None");
}

if (roicount > 1) {
	selectionarray = Array.getSequence(roicount);
	roiManager("select", selectionarray);
	roiManager("combine");
	roiManager("add");
	roiManager("Select", roicount);
	roiManager("save selected", roidir2);
	roiManager("deselect");
	roiManager("delete");
	run("Select None");
}

//Moved to Front
//File.makeDirectory(roidir0);
ARslash = "analyticROIs" + File.separator;



filecountmin1 = filecount - 1;

if (currentruncount < filecount) {
	run("Close All");
}

//inputdir1 = Table.get("InputDir", 0);

//currentruncount = parseFloat(Table.get("RunCount", 0)) + 1;

//currentruncount++;

Table.set("RunCount", 0, currentruncount);

//IJ.renameResults("RunCount");

selectWindow("RunCount");
//Table.update;
saveAs("results", newfullnamerc);
//Table.save(newfullnamerc);

//CHANGED TO ACCOMODATE NEW LOOP

if (currentruncount < filecount) {
	selectWindow("RunCount");
	currentimage = Table.getString("File Names", currentruncount);
	open(inputdir + "/" + currentimage);
	prevruncount = currentruncount - 1;
	previmage = Table.getString("File Names", prevruncount);
	roidir1 = roidir0 + previmage;
	roidir2 = replace(roidir1, ".tif", "") + "analyticROIs.zip";
} else {
	selectWindow("RunCount");

	//This is new and sus
	//currentimage = Table.getString("File Names", currentruncount);
	prevruncount = currentruncount - 1;
	previmage = Table.getString("File Names", prevruncount);
	open(inputdir + "/" + previmage);
	roidir1 = roidir0 + previmage;
	roidir2 = replace(roidir1, ".tif", "") + "analyticROIs.zip";
	File.delete(newfullnamerc);
	selectWindow("RunCount");
	Table.update;
	run("Close");
	selectWindow("Log");
	run("Close");
}

// *****  I tried moving this up front!  *****

//if (roicount == 1) {
//	roiManager("select", 0);
//	roiManager("save selected", roidir2);
//	roiManager("deselect");
//	roiManager("delete");
//	run("Select None");
//}

//if (roicount > 1) {
//	selectionarray = Array.getSequence(roicount);
//	roiManager("select", selectionarray);
//	roiManager("combine");
//	roiManager("add");
//	roiManager("Select", roicount);
//	roiManager("save selected", roidir2);
//	roiManager("deselect");
//	roiManager("delete");
//	run("Select None");
//}

//Remove if it breaks!
if (currentruncount == filecount) {
	run("Close All");
	return "true"; // returns this to let the plugin know the end has been reached (sets isEnd in the plugin RoiAssisted class to true)
}