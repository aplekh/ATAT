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
	filename = Table.getString("File Names", z);
	fullcurrentname = inputdir + filename;
	open(fullcurrentname);
	fullcurrentroiname = inputdir + "/analyticROIs/" + replace(filename, ".tif", "") + "analyticROIs.zip";
	roifilestatus = File.exists(fullcurrentroiname);
	if (roifilestatus == 1) {
		roiManager("open", fullcurrentroiname);
	}
	
	runMacro("021822 WAT Darkener");
	
	save(fullcurrentname);
	run("Close");
	runcount++;
}
//autoopendir = imagejdir + "PATTI/Batch Tests/4batchimage.tif";
//open(autoopendir);

selectWindow("Image Files");
run("Close");

run("Close All");








