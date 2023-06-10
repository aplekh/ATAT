package atat;

import java.awt.Dialog;

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

import ij.WindowManager;
import ij.gui.GenericDialog;
import ij.gui.NonBlockingGenericDialog;
import ij.plugin.Macro_Runner;
import ij.plugin.PlugIn;

//import java.io.File;
//import java.util.ArrayList;
//import java.util.List;

@Plugin(type = Command.class, menuPath = "Plugins>Analyze")
public class Main implements PlugIn {
	
	@Override
	public void run(String arg) {
		//Macro_Runner.runMacroFromJar("(Latest finalized) 090822 Adipocyte Capture with Batch and Analytic ROI Fixes.ijm", "");
		/*
		 * Temporary generic dialog - to serve as placeholder for progressbar until it gets added
		 */
		
		NonBlockingGenericDialog gd1 = new NonBlockingGenericDialog("Analysis in progress...");
		gd1.addMessage("ATAT analysis is in progress...");
		gd1.addMessage("Unless prompted, please do not interact with any windows or applications while the analysis is running");
		gd1.setAlwaysOnTop(true);
		gd1.hideCancelButton();
		gd1.setOKLabel("Cancel analysis");
		gd1.setModalExclusionType(Dialog.ModalExclusionType.TOOLKIT_EXCLUDE); // So it doesnt cover up any modal ImageJ errors that pop up
		// We need multithreading here because showDialog stops the thread until the dialog is closed
		try {
			new Thread(new Runnable() {
				@Override
				public void run() {
					gd1.showDialog();
				}
			}).start();
			// Check if analysis was cancelled - if so, close everything
			new Thread(new Runnable() {
				@Override
				public void run() {
					boolean cancelled = false;
					while (!cancelled)
					{
						cancelled = gd1.wasOKed();
						try {
							Thread.sleep(100);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
					WindowManager.closeAllWindows();
				}
			}).start();
		}
		catch (Exception e) {}

		String end = Macro_Runner.runMacroFromJar("ATAT macros/(Latest finalized) 090822 Adipocyte Capture with Batch and Analytic ROI Fixes.ijm", "");
		if (end.equals("end"))
		{
			gd1.setVisible(false);
			GenericDialog gd2 = new GenericDialog("Analysis finished!");
			gd2.addMessage("ATAT analysis successful!");
			gd2.addMessage("You may now close any unnecessary windows");
			gd2.hideCancelButton();
			gd2.showDialog();
		}
		else
		{
			gd1.setVisible(false);
			GenericDialog gd2 = new GenericDialog("Analysis finished!");
			gd2.addMessage("ATAT analysis complete!");
			gd2.addMessage("WARNING: " + end + " image(s) could not be analyzed! (No cells found)");
			gd2.addMessage("Please see the '...SummarizedResults.csv' file for more info");
			gd2.addMessage("You may now close any unnecessary windows");
			gd2.hideCancelButton();
			gd2.showDialog();
		}
	}
}
