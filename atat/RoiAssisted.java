package atat;

import java.awt.Button;
import java.awt.Component;
import java.awt.GraphicsEnvironment;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Panel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

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

import ij.*;
import ij.gui.GenericDialog;
import ij.gui.NonBlockingGenericDialog;
import ij.plugin.Commands;
import ij.plugin.Macro_Runner;
import ij.plugin.PlugIn;
import ij.WindowManager;

import java.io.File;
//import java.util.ArrayList;
//import java.util.List;


@Plugin(type = Command.class, menuPath = "Plugins>ROI Assisted Analysis Setup")
public class RoiAssisted implements PlugIn {

	@Override
	public void run(String arg) {
		//Macro_Runner mr = new Macro_Runner();
		NonBlockingGenericDialog gd = new NonBlockingGenericDialog("Next action");
		Macro_Runner.runMacroFromJar("ATAT macros/030921 Batch ROI Setter which supports multiple rois on final image.ijm", "");
		gd.hideCancelButton();
		gd.setOKLabel("Terminate");
		
		try {
			new Thread(new Runnable() {
				@Override
				public void run()
					{
						boolean terminated = false;
						while (!terminated)
						{
							terminated = gd.wasOKed();
							try {
								Thread.sleep(100);
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
						}
						new File(IJ.getDirectory("imagej") + "/" + "RunCount").delete(); // Need to delete RunCount as it is not deleted in macro unless the macro reaches the very end successfully
						WindowManager.closeAllWindows();
					}
			}).start();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		addButton(gd, "        Analyze (Save)        ", new java.awt.event.ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				Macro_Runner.runMacroFromJar("ATAT macros/030921 Batch ROI Setter which supports multiple rois on final image.ijm", "");
				WindowManager.closeAllWindows();
				new File(IJ.getDirectory("imagej") + "/" + "RunCount").delete(); // Need to delete RunCount as it is not deleted in macro unless the macro reaches the very end
				//Macro_Runner.runMacroFromJar("(Latest finalized) 090822 Adipocyte Capture with Batch and Analytic ROI Fixes.ijm", "");
				Main analysisRunner = new Main();
				analysisRunner.run("");
			}
		});
		addButton(gd, "          Next (Save)           ", new java.awt.event.ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				boolean isEnd = Boolean.parseBoolean(Macro_Runner.runMacroFromJar("ATAT macros/030921 Batch ROI Setter which supports multiple rois on final image.ijm", ""));
				//gd.toFront();
				if (isEnd)
				{
					WindowManager.closeAllWindows();
				}
			}
		});
		
		addButton(gd, "       Save and Close      ", new java.awt.event.ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				Macro_Runner.runMacroFromJar("ATAT macros/030921 Batch ROI Setter which supports multiple rois on final image.ijm", "");
				WindowManager.closeAllWindows();
				new File(IJ.getDirectory("imagej") + "/" + "RunCount").delete(); // Need to delete RunCount as it is not deleted in macro unless the macro reaches the very end
			}
		});
		
		//gd.toFront();
		gd.setAlwaysOnTop(true);
		gd.showDialog();
	}

	
	/*
	 * To be compatible with outdated versions of ImageJ, we must create our own addButton method
	 * This is because GenericDialog.addButton() was only added in ImageJ 1.53k
	 */
	private void addButton(GenericDialog gd, String label, ActionListener listener) {
		if (GraphicsEnvironment.isHeadless())
			return;
		Button button = new Button(label);
		button.addActionListener(listener);
		button.addKeyListener(gd);
		GridBagLayout layout = (GridBagLayout)gd.getLayout();
		Panel panel = new Panel();
		gd.addPanel(panel);
		GridBagConstraints constraints = layout.getConstraints(panel);
		gd.remove(panel);
		layout.setConstraints(button, constraints);
		gd.add(button);
	}
}
