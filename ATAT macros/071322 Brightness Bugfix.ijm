run("Median...", "radius=1");
run("Automated Block Thresholding...", "block=1 mean=0 tophat=0");
runMacro("050222 Watershed Circles.ijm");

run("Invert");

run("Analyze Particles...", "size=1-1000 circularity=0.40-1.00 exclude add");
roiManager("Show All without labels");