// 16-section Image Divider

Table.create("Peak Storage");

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

selectWindow("Peak Storage");
Table.set("Block Thresholds", 0, 0);

roiManager("select", 0);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 0, Threshold);

roiManager("select", 1);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 1, Threshold);

roiManager("select", 2);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 2, Threshold);

roiManager("select", 3);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 3, Threshold);

roiManager("select", 4);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 4, Threshold);

roiManager("select", 5);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 5, Threshold);

roiManager("select", 6);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 6, Threshold);

roiManager("select", 7);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 7, Threshold);

roiManager("select", 8);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 8, Threshold);

roiManager("select", 9);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 9, Threshold);

roiManager("select", 10);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 10, Threshold);

roiManager("select", 11);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 11, Threshold);

roiManager("select", 12);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 12, Threshold);

roiManager("select", 13);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 13, Threshold);

roiManager("select", 14);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 14, Threshold);

roiManager("select", 15);
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 15, Threshold);

roiManager("deselect");
runMacro("032221 right from highest thresh");
Threshold = parseFloat(Table.get("TailValue", 0));
Table.set("Block Thresholds", 16, Threshold);

for (i = 0; i < 16; i++) {
	currentthresh = parseFloat(Table.get("Block Thresholds", i));
	if (toString(currentthresh) == "NaN") {
		currentthresh = parseFloat(Table.get("Block Thresholds", 16));
	}
	if (toString(currentthresh) == "NaN") {
		getStatistics(area, mean, min, max, std, histogram);
		currentthresh = max * 0.9;
	}
	stretchfactor = 255/currentthresh;
	roiManager("Select", i);
	run("Multiply...", "value=stretchfactor");
}

roiManager("Deselect");
roiManager("Delete");
selectWindow("Peak Storage");
run("Close");
run("Clear Results");
run("Select None");

run("Mean...", "radius=1");

