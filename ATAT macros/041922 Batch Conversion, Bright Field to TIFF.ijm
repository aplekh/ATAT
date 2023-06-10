inputdir = getDirectory("Choose Source Directory ");


files = getFileList(inputdir);
outputdir = replace(inputdir, "Big TIF Images", "Little TIF Images");
//print(outputdir);
File.makeDirectory(outputdir);

//Table.setColumn("File Names", files);
//Array.print(files);

imagejdir = getDirectory("imagej");

//setBatchMode(true);

//runcount = 0;

//if (runcount == 0) {
//	filecount = nResults;
//}

//Table.rename("Results", "Image Files");



for (z = 0; z < files.length; z++) {
	filename = files[z];
	fullcurrentname = inputdir + filename;
	//run("Bio-Formats Importer", "open=[fullcurrentname] color_mode=Colorized rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_1");
	run("Bio-Formats Importer", "open=[fullcurrentname] color_mode=Colorized rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT series_2");
	c2name = filename + " - Series 2 - C=2";
	selectWindow(c2name);
	run("RGB Color");
	c1name = filename + " - Series 2 - C=1";
	selectWindow(c1name);
	run("RGB Color");
	c0name = filename + " - Series 2 - C=0";
	selectWindow(c0name);
	run("RGB Color");
	imageCalculator("Add", c0name, c1name);
	selectWindow(c1name);
	close();
	imageCalculator("Add", c0name, c2name);
	selectWindow(c2name);
	close();
	selectWindow(c0name);
	width = getWidth();
	micronswidth = 2.0124 * width;
	run("Set Scale...", "distance=width known=micronswidth unit=microns");
	newname1 = replace(fullcurrentname, ".tif", "") + "_5x";
	newname2 = replace(newname1, ".svs", "");
	newname3 = replace(newname2, ".vsi", "");
	newname4 = replace(newname3, ".btf", "");
	//print(newname4);
	outputname = replace(newname4, "Big TIF", "Little TIF");
	saveAs("Tiff", outputname);
	close();
	//runcount++;
}
//autoopendir = imagejdir + "PATTI/Batch Tests/4batchimage.tif";
//open(autoopendir);

//selectWindow("Image Files");
//run("Close");