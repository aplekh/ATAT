inputdir = getDirectory("Choose Source Directory ");

Dialog.create("Batch Scale Setter");

Dialog.addNumber("Distance in Pixels:", 1);
Dialog.addNumber("Known Distance:", 1);
Dialog.addString("Unit of Length:", "micron");
Dialog.show();

DistPix = Dialog.getNumber();
KnownDist = Dialog.getNumber();
Unit = Dialog.getString();


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
	if (Unit == "microns") {
		run("Set Scale...", "distance=DistPix known=KnownDist unit=microns");
	} else {
		run("Set Scale...", "distance=DistPix known=KnownDist unit=microns");
		print("In line 65... who made me write this abomination?");
	}
	save(fullcurrentname);
	run("Close");
	runcount++;
}
//autoopendir = imagejdir + "PATTI/Batch Tests/4batchimage.tif";
//open(autoopendir);

selectWindow("Image Files");
run("Close");

run("Close All");








