package atat;

//import net.imagej.Dataset;
//import net.imagej.ImageJ;
//import net.imagej.ops.OpService;
//import net.imglib2.RandomAccessibleInterval;
//import net.imglib2.img.Img;
//import net.imglib2.type.numeric.RealType;
import org.scijava.command.Command;
//import org.scijava.plugin.Parameter;
import org.scijava.plugin.Plugin;
//import org.scijava.ui.UIService;

import ij.plugin.Macro_Runner;
import ij.plugin.PlugIn;

//import java.io.File;
//import java.util.ArrayList;
//import java.util.List;

@Plugin(type = Command.class, menuPath = "Plugins>Batch TIF converter")
public class TifConverter implements PlugIn {

	@Override
	public void run(String arg) {
		// final Img<T> image = (Img<T>)currentData.getImgPlus();
		Macro_Runner.runMacroFromJar("ATAT macros/041922 Batch Conversion, Bright Field to TIFF.ijm", "");

		// public static void main(String[] args) {
		// Macro_Runner mr = new Macro_Runner();
		// mr.runMacroFromJar("102020 Threshold Calculator, string-corrected.ijm");
		// }

	}
}
