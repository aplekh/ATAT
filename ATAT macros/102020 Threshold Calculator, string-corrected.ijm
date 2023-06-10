nBins = 256;
row = 0;
run("8-bit");
getHistogram(values, counts, nBins);
for (i=0; i<nBins; i++) {
	setResult("Value", row, values[i]);
	setResult("Count", row, counts[i]);
	row++;
}
updateResults();


//We check if 0 is an intensity distribution peak.


//Averager

m = 0;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/11;
Count = getResult("Count", 0);
Countplus1 = getResult("Count", 1);
Countplus2 = getResult("Count", 2);
if (Count>Countplus1 && Count>Countplus2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 0);
	PeakCount = getResult("Count", 0);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 1 is an intensity distribution peak.

m = 1;
mmin1 = m - 1;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/12;
Count = getResult("Count", 1);
Countplus1 = getResult("Count", 2);
Countplus2 = getResult("Count", 3);
Countmin1 = getResult("Count", 0);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>AvgAdj) {
	PeakValue = getResult("Value", 1);
	PeakCount = getResult("Count", 1);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 2 is an intensity distribution peak.

m = 2;
mmin1 = m - 1;
mmin2 = m - 2;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/13;
Count = getResult("Count", 2);
Countplus1 = getResult("Count", 3);
Countplus2 = getResult("Count", 4);
Countmin1 = getResult("Count", 1);
Countmin2 = getResult("Count", 0);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 2);
	PeakCount = getResult("Count", 2);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 3 is an intensity distribution peak.

m = 3;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/14;
Count = getResult("Count", 3);
Countplus1 = getResult("Count", 4);
Countplus2 = getResult("Count", 5);
Countmin1 = getResult("Count", 2);
Countmin2 = getResult("Count", 1);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 3);
	PeakCount = getResult("Count", 3);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 4 is an intensity distribution peak.

m = 4;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/15;
Count = getResult("Count", 4);
Countplus1 = getResult("Count", 5);
Countplus2 = getResult("Count", 6);
Countmin1 = getResult("Count", 3);
Countmin2 = getResult("Count", 2);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 4);
	PeakCount = getResult("Count", 4);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 5 is an intensity distribution peak.

m = 5;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/16;
Count = getResult("Count", 5);
Countplus1 = getResult("Count", 6);
Countplus2 = getResult("Count", 7);
Countmin1 = getResult("Count", 4);
Countmin2 = getResult("Count", 3);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 5);
	PeakCount = getResult("Count", 5);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 6 is an intensity distribution peak.

m = 6;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/17;
Count = getResult("Count", 6);
Countplus1 = getResult("Count", 7);
Countplus2 = getResult("Count", 8);
Countmin1 = getResult("Count", 5);
Countmin2 = getResult("Count", 4);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 6);
	PeakCount = getResult("Count", 6);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 7 is an intensity distribution peak.

m = 7;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/18;
Count = getResult("Count", 7);
Countplus1 = getResult("Count", 8);
Countplus2 = getResult("Count", 9);
Countmin1 = getResult("Count", 6);
Countmin2 = getResult("Count", 5);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 7);
	PeakCount = getResult("Count", 7);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 8 is an intensity distribution peak.

m = 8;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/19;
Count = getResult("Count", 8);
Countplus1 = getResult("Count", 9);
Countplus2 = getResult("Count", 10);
Countmin1 = getResult("Count", 7);
Countmin2 = getResult("Count", 6);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 8);
	PeakCount = getResult("Count", 8);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 9 is an intensity distribution peak.

m = 9;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
mplus10 = m + 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
Countmplus10 = getResult("Count", mplus10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/20;
Count = getResult("Count", 9);
Countplus1 = getResult("Count", 10);
Countplus2 = getResult("Count", 11);
Countmin1 = getResult("Count", 8);
Countmin2 = getResult("Count", 7);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 9);
	PeakCount = getResult("Count", 9);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if all middle intensities are intensity distribution peaks.

nPeakChecks = nBins - 20;

for (i=0; i<(nPeakChecks); i++){
	n = i + 10;
	//Averager
	m = n;
	mmin1 = m - 1;
	mmin2 = m - 2;
	mmin3 = m - 3;
	mmin4 = m - 4;
	mmin5 = m - 5;
	mmin6 = m - 6;
	mmin7 = m - 7;
	mmin8 = m - 8;
	mmin9 = m - 9;
	mmin10 = m - 10;
	mplus1 = m + 1;
	mplus2 = m + 2;
	mplus3 = m + 3;
	mplus4 = m + 4;
	mplus5 = m + 5;
	mplus6 = m + 6;
	mplus7 = m + 7;
	mplus8 = m + 8;
	mplus9 = m + 9;
	mplus10 = m + 10;
	Countm = getResult("Count", m);
	Countmmin1 = getResult("Count", mmin1);
	Countmmin2 = getResult("Count", mmin2);
	Countmmin3 = getResult("Count", mmin3);
	Countmmin4 = getResult("Count", mmin4);
	Countmmin5 = getResult("Count", mmin5);
	Countmmin6 = getResult("Count", mmin6);
	Countmmin7 = getResult("Count", mmin7);
	Countmmin8 = getResult("Count", mmin8);
	Countmmin9 = getResult("Count", mmin9);
	Countmmin10 = getResult("Count", mmin10);
	Countmplus1 = getResult("Count", mplus1);
	Countmplus2 = getResult("Count", mplus2);
	Countmplus3 = getResult("Count", mplus3);
	Countmplus4 = getResult("Count", mplus4);
	Countmplus5 = getResult("Count", mplus5);
	Countmplus6 = getResult("Count", mplus6);
	Countmplus7 = getResult("Count", mplus7);
	Countmplus8 = getResult("Count", mplus8);
	Countmplus9 = getResult("Count", mplus9);
	Countmplus10 = getResult("Count", mplus10);
	AvgAdj = (Countmmin10 + Countmmin9 + Countmmin8 + Countmmin7 + Countmmin6 + Countmmin5 + Countmmin4 + Countmmin3 + Countmmin2 + Countmmin1 + Countm + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9 + Countmplus10)/21;
	nmin1 = n - 1;
	nmin2 = n - 2;
	nplus1 = n + 1;
	nplus2 = n + 2;
	Count = getResult("Count", n);
	Countmin1 = getResult("Count", nmin1);
	Countmin2 = getResult("Count", nmin2);
	Countplus1 = getResult("Count", nplus1);
	Countplus2 = getResult("Count", nplus2);
	if (Count>Countmin2 && Count>Countmin1 && Count>Countplus1 && Count>Countplus2 && Count>AvgAdj) {
		PeakValue = getResult("Value", n);
		PeakCount = getResult("Count", n);
		selectWindow("Peak Storage");
		Table.set("PeakValue", 0, PeakValue);
		Table.set("PeakCount", 0, PeakCount);
	}
}

//We check if 246 is an intensity distribution peak.

m = 246;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
mplus9 = m + 9;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
Countmplus9 = getResult("Count", mplus9);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8 + Countmplus9)/20;
Count = getResult("Count", 246);
Countplus1 = getResult("Count", 247);
Countplus2 = getResult("Count", 248);
Countmin1 = getResult("Count", 245);
Countmin2 = getResult("Count", 244);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 246);
	PeakCount = getResult("Count", 246);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 247 is an intensity distribution peak.

m = 247;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
mplus8 = m + 8;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
Countmplus8 = getResult("Count", mplus8);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7 + Countmplus8)/19;
Count = getResult("Count", 247);
Countplus1 = getResult("Count", 248);
Countplus2 = getResult("Count", 249);
Countmin1 = getResult("Count", 246);
Countmin2 = getResult("Count", 245);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 247);
	PeakCount = getResult("Count", 247);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 248 is an intensity distribution peak.

m = 248;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
mplus7 = m + 7;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
Countmplus7 = getResult("Count", mplus7);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6 + Countmplus7)/18;
Count = getResult("Count", 248);
Countplus1 = getResult("Count", 249);
Countplus2 = getResult("Count", 250);
Countmin1 = getResult("Count", 247);
Countmin2 = getResult("Count", 246);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 248);
	PeakCount = getResult("Count", 248);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 249 is an intensity distribution peak.

m = 249;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
mplus6 = m + 6;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
Countmplus6 = getResult("Count", mplus6);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5 + Countmplus6)/17;
Count = getResult("Count", 249);
Countplus1 = getResult("Count", 250);
Countplus2 = getResult("Count", 251);
Countmin1 = getResult("Count", 248);
Countmin2 = getResult("Count", 247);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 249);
	PeakCount = getResult("Count", 249);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 250 is an intensity distribution peak.

m = 250;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
mplus5 = m + 5;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
Countmplus5 = getResult("Count", mplus5);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4 + Countmplus5)/16;
Count = getResult("Count", 250);
Countplus1 = getResult("Count", 251);
Countplus2 = getResult("Count", 252);
Countmin1 = getResult("Count", 249);
Countmin2 = getResult("Count", 248);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 250);
	PeakCount = getResult("Count", 250);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 251 is an intensity distribution peak.

m = 251;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
mplus4 = m + 4;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
Countmplus4 = getResult("Count", mplus4);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3 + Countmplus4)/15;
Count = getResult("Count", 251);
Countplus1 = getResult("Count", 252);
Countplus2 = getResult("Count", 253);
Countmin1 = getResult("Count", 250);
Countmin2 = getResult("Count", 249);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 251);
	PeakCount = getResult("Count", 251);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 252 is an intensity distribution peak.

m = 252;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
mplus3 = m + 3;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
Countmplus3 = getResult("Count", mplus3);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2 + Countmplus3)/14;
Count = getResult("Count", 252);
Countplus1 = getResult("Count", 253);
Countplus2 = getResult("Count", 254);
Countmin1 = getResult("Count", 251);
Countmin2 = getResult("Count", 250);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 252);
	PeakCount = getResult("Count", 252);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 253 is an intensity distribution peak.

m = 253;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
mplus2 = m + 2;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
Countmplus2 = getResult("Count", mplus2);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1 + Countmplus2)/13;
Count = getResult("Count", 253);
Countplus1 = getResult("Count", 254);
Countplus2 = getResult("Count", 255);
Countmin1 = getResult("Count", 252);
Countmin2 = getResult("Count", 251);
if (Count>Countplus1 && Count>Countplus2 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 253);
	PeakCount = getResult("Count", 253);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 254 is an intensity distribution peak.

m = 254;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
mplus1 = m + 1;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
Countmplus1 = getResult("Count", mplus1);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10 + Countmplus1)/12;
Count = getResult("Count", 254);
Countplus1 = getResult("Count", 255);
Countmin1 = getResult("Count", 253);
Countmin2 = getResult("Count", 252);
if (Count>Countplus1 && Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 254);
	PeakCount = getResult("Count", 254);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//We check if 255 is an intensity distribution peak.

m = 255;
mmin1 = m - 1;
mmin2 = m - 2;
mmin3 = m - 3;
mmin4 = m - 4;
mmin5 = m - 5;
mmin6 = m - 6;
mmin7 = m - 7;
mmin8 = m - 8;
mmin9 = m - 9;
mmin10 = m - 10;
Countm = getResult("Count", m);
Countmmin1 = getResult("Count", mmin1);
Countmmin2 = getResult("Count", mmin2);
Countmmin3 = getResult("Count", mmin3);
Countmmin4 = getResult("Count", mmin4);
Countmmin5 = getResult("Count", mmin5);
Countmmin6 = getResult("Count", mmin6);
Countmmin7 = getResult("Count", mmin7);
Countmmin8 = getResult("Count", mmin8);
Countmmin9 = getResult("Count", mmin9);
Countmmin10 = getResult("Count", mmin10);
AvgAdj = (Countm + Countmmin1 + Countmmin2 + Countmmin3 + Countmmin4 + Countmmin5 + Countmmin6 + Countmmin7 + Countmmin8 + Countmmin9 + Countmmin10)/11;
Count = getResult("Count", 255);
Countmin1 = getResult("Count", 254);
Countmin2 = getResult("Count", 253);
if (Count>Countmin1 && Count>Countmin2 && Count>AvgAdj) {
	PeakValue = getResult("Value", 255);
	PeakCount = getResult("Count", 255);
	selectWindow("Peak Storage");
	Table.set("PeakValue", 0, PeakValue);
	Table.set("PeakCount", 0, PeakCount);
}

//Defining values for use in the loop.
selectWindow("Peak Storage");
PeakValue = Table.get("PeakValue", 0);
PeakCount = Table.get("PeakCount", 0);

//Now that we have the right-most peak of the intensity distribution,
//We scan leftwards to find the right-most peak of the second derivative of this distribution.
//These columns will store that result.

Table.setColumn("TailValue");
Table.setColumn("Derivative");
Table.set("Derivative", 0, 0);
//Table.setColumn("RightTail");
//Table.setColumn("RightDeriv");
//Table.set("RightDeriv", 0, 0);

for (i = 0; i < 255; i++) {
	n = parseInt(PeakValue) - i - 1;
	if (n > 253) {
		n = 253;
	}
	nmin1 = n - 1;
	nmin2 = n - 2;
	nplus1 = n + 1;
	nplus2 = n + 2;
	Countn = getResult("Count", n);
	Countnmin1 = getResult("Count", nmin1);
	Countnmin2 = getResult("Count", nmin2);
	Countnplus1 = getResult("Count", nplus1);
	Countnplus2 = getResult("Count", nplus2);
	slopen = (Countnplus1-Countnmin1)/2;
	slopenmin1 = (Countn-Countnmin2)/2;
	slopenplus1 = (Countnplus2-Countn)/2;
	derivn = slopenplus1 - slopenmin1;
	derivprev = Table.get("Derivative", 0);
	if (slopen > 0) {
		if (derivn > derivprev) {
			Table.set("Derivative", 0, derivn);
			Table.set("TailValue", 0, n);
		}
	} else {
		break;
		//end loop command???	
	}
}

//Reduce maximum i value?
PeakValue = Table.get("PeakValue", 0);
//newi = 255 - PeakValue -2;

//for (i = 0; i < newi; i++) {
//	n = parseInt(PeakValue) + i + 1;
//	nmin1 = n - 1;
//	nmin2 = n - 2;
//	nplus1 = n + 1;
//	nplus2 = n + 2;
//	Countn = getResult("Count", n);
//	Countnmin1 = getResult("Count", nmin1);
//	Countnmin2 = getResult("Count", nmin2);
//	Countnplus1 = getResult("Count", nplus1);
//	Countnplus2 = getResult("Count", nplus2);
//	slopen = (Countnplus1-Countnmin1)/2;
//	slopenmin1 = (Countn-Countnmin2)/2;
//	slopenplus1 = (Countnplus2-Countn)/2;
//	derivn = slopenplus1 - slopenmin1;
//	derivprev = Table.get("RightDeriv", 0);
//	if (slopen < 0) {
//		if (derivn > derivprev) {
//			Table.set("RightDeriv", 0, derivn);
//			Table.set("RightTail", 0, n);
//		}
//	} else {
//		break;
//		//end loop command???	
//	}
//}

//Threshold = Table.get("TailValue", 0);
//WandThreshold = Table.get("RightTail", 0);

