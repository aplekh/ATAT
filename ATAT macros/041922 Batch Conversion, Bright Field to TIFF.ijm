inputdir = getDirectory("Choose Source Directory ");
outputdir = getDirectory("Choose output directory");


files = getFileList(inputdir);
//outputdir = replace(inputdir, "Big TIF Images", "Little TIF Images");
//print(outputdir);
//File.makeDirectory(outputdir);

//Table.setColumn("File Names", files);
//Array.print(files);

imagejdir = getDirectory("imagej");

for (z = 0; z < files.length; z++) {
	filename = files[z];
	fullcurrentname = inputdir + filename;
	print(fullcurrentname);
	//run("Bio-Formats Importer", "open=[fullcurrentname] color_mode=Colorized rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_1");
	//run("Bio-Formats Importer", "open=[fullcurrentname] color_mode=Colorized rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT series_2");
	run("Bio-Formats Importer", "open=[fullcurrentname] color_mode=Colorized rois_import=[ROI manager] split_channels view=Hyperstack stack_order=XYCZT");
	c2name = filename + " - C=2";
	selectWindow(c2name);
	run("RGB Color");
	c1name = filename + " - C=1";
	selectWindow(c1name);
	run("RGB Color");
	c0name = filename + " - C=0";
	selectWindow(c0name);
	run("RGB Color");
	imageCalculator("Add", c0name, c1name);
	selectWindow(c1name);
	close();
	imageCalculator("Add", c0name, c2name);
	selectWindow(c2name);
	close();
	selectWindow(c0name);
	/*width = getWidth();
	micronswidth = 2.0124 * width;
	run("Set Scale...", "distance=width known=micronswidth unit=microns");*/
	newname1 = replace(filename, "\\.tif", ""); //+ "_5x";
	newname2 = replace(newname1, "\\.svs", "");
	newname3 = replace(newname2, "\\.vsi", "");
	newname4 = replace(newname3, "\\.btf", "");
	newname5 = replace(newname4, "\\.png", "");
	newname6 = replace(newname5, "\\.jpg", "");
	newname7 = replace(newname6, "\\.jpeg", "");
	//print(newname4);
	outputname = outputdir + newname7 + ".tif";
	//print(outputname);
	saveAs("tiff", outputname);
	close();
	//runcount++;
}
//autoopendir = imagejdir + "PATTI/Batch Tests/4batchimage.tif";
//open(autoopendir);

//selectWindow("Image Files");
//run("Close");