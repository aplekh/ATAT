package atat;

import org.scijava.command.Command;
import org.scijava.plugin.Plugin;
import ij.plugin.Macro_Runner;
import ij.plugin.PlugIn;

@Plugin(type = Command.class, menuPath = "Plugins>Batch set scale")
public class BatchSetScale implements PlugIn {

	@Override
	public void run(String arg) {
		Macro_Runner.runMacroFromJar("ATAT macros/Batch Scale Setter.ijm", "");
	}
}
