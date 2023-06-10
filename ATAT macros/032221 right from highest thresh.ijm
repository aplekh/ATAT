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

currentpixcount = 0;
highestyetpixcount = 0;

for (i = 0; i < 255; i++) {
	currentpixcount = parseFloat(getResult("Count", i));
	if (currentpixcount > highestyetpixcount) {
		highestyetpixcount = currentpixcount;
		highestpeakval = i;
	}
}


//Defining values for use in the loop.
selectWindow("Peak Storage");
PeakValue = highestpeakval;
PeakCount = highestyetpixcount;

//Now that we have the highest peak of the intensity distribution,
//We scan rightwards to find the first available peak of the second derivative of this distribution.
//These columns will store that result.

Table.setColumn("TailValue");
Table.setColumn("Derivative");
Table.set("Derivative", 0, 0);


for (i = 0; i < 255; i++) {
	if (PeakValue < 255) {
		n = parseInt(PeakValue) + i + 1;
	} else {
		n = 254 + i + 1;
	}
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
	if (slopen < 0) {
		if (derivn > derivprev) {
			Table.set("Derivative", 0, derivn);
			Table.set("TailValue", 0, n);
		}
	} else {
		break;
		//end loop command???	
	}
}

Table.set("PeakValue", 0, highestpeakval);
Table.set("PeakCount", 0, highestyetpixcount);

//Reduce maximum i value?
//PeakValue = Table.get("PeakValue", 0);
//newi = 255 - PeakValue -2;
