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

@Plugin(type = Command.class, menuPath = "Plugins>Analyze")
public class MacroEdgeEnhancer implements PlugIn {

	@Override
	public void run(String arg) {
		Macro_Runner.runMacroFromJar("ATAT macros/Edge Darkening Macro.ijm", "");
	}
}
