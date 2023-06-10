
//TO SOLVE:
//rofimage3 bug... fixed?
//analysis of last image??? Only happens when ROI-assisted --
//probably doesn't remove "analytic ROIs" folder from list of files



// Blur radius variable (in analytic macro) sometimes broken. This does not always occur... why???
//Fixed, it seems. Selecting the table window seemed to fix it.



inputdir = getDirectory("Choose Source Directory ");


files = getFileList(inputdir);
Table.setColumn("File Names", files);

//Array.print(files);

imagejdir = getDirectory("imagej");

//setBatchMode(true);

runcount = 0;

if (runcount == 0) {
	filecount = nResults;
}

for (i = 0; i < filecount; i++) {
	checkname = Table.getString("File Names", i);
	if (checkname == "analyticROIs/") {
		Table.deleteRows(i, i);
		break;
	}

}

filecount = nResults;

roidirname = inputdir + "/analyticROIs/";

roidirstatus = File.exists(roidirname);

//if (roidirstatus == 1) {
	//filecount--;
//}


Table.rename("Results", "Image Files");

for (z = 0; z < filecount; z++) {
	selectWindow("Image Files");
	filename = Table.getString("File Names", z);
	fullcurrentname = inputdir + filename;
	open(fullcurrentname);
	fullcurrentroiname = inputdir + "/analyticROIs/" + replace(filename, ".tif", "") + "analyticROIs.zip";
	roifilestatus = File.exists(fullcurrentroiname);
	if (roifilestatus == 1) {
		roiManager("open", fullcurrentroiname);
	}
	runMacro("032221 Right-from-highest Threshold Calculator");
	save(fullcurrentname);
	runcount++;
}
//autoopendir = imagejdir + "PATTI/Batch Tests/4batchimage.tif";
//open(autoopendir);

selectWindow("Image Files");
run("Close");

run("Close All");