title1 = getTitle();

setBatchMode(true);

run("Select None");
run("Duplicate...", " ");
rename("title2");
run("8-bit");
//run("Automated Block Thresholding...", "block=1 mean=0 tophat=1");

//run("Duplicate...", " ");
//rename("title3");
run("Maximum...", "radius=1");
run("Median...", "radius=1");
run("Minimum...", "radius=1");
run("Distance Transform Watershed", "distances=[Verwer (12,17,27,38)] output=[32 bits] normalize dynamic=1 connectivity=8");
run("8-bit");
run("Multiply...", "value=255");
run("Invert");
selectWindow("title2");
run("Invert");

imageCalculator("Subtract create", "title2-dist-watershed","title2");
selectWindow("Result of title2-dist-watershed");
run("Maximum...", "radius=1");
imageCalculator("Subtract", title1,"Result of title2-dist-watershed");

selectWindow("title2");
close();
selectWindow("title2-dist-watershed");
close();
selectWindow("Result of title2-dist-watershed");
close();

//setBatchMode(false);

