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

@Plugin(type = Command.class, menuPath = "Plugins>Settings")
public class SettingsSetter implements PlugIn {

	@Override
	public void run(String arg) {
		Macro_Runner.runMacroFromJar("ATAT macros/040522 Setting Setter, 3rd design with Darken Sensitivity.ijm", "");
		/*
		 * TODO: update above settings setter. above one is outdated, but newer version currently has the
		 * PATTI bug where it doesnt save the settings to the same place they are read from
		 */
	}
}
