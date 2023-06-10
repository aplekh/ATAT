package atat;

import org.scijava.command.Command;
import org.scijava.plugin.Plugin;

import ij.Macro;
import ij.plugin.Macro_Runner;
import ij.plugin.PlugIn;

/*
 * In-house way to run macros in a java plugin thru other macros in a java plugin
 * 
 * Implemented because the macro runMacro() function can only run from a specified
 * ImageJ directory ("macros" directory by default). Macros inside of this plugin
 * thus have no way to see other macros in this plugin. However, they can see 
 * Java classes in this plugin. This java class serves as a bridge between 2 macros,
 * allowing 1 macro to run another macro when both are a part of one plugin.
 * 
 * Macro command for MacroRunner is:
 * run("MacroRunner", name);
 *    where name is a String of the title of the macro in the plugin
 * 
 * Warning: MacroRunner will look thru EVERY single jar to find the macro, so make
 * sure that names are unique or else you will get collisions
 */

@Plugin(type = Command.class, menuPath = "Plugins>MacroRunner")
public class MacroFromMacroRunner implements PlugIn {
	
	@Override
	public void run(String arg) {
		Macro_Runner.runMacroFromJar("ATAT macros/" + Macro.getOptions().trim(), "");
	}
}

