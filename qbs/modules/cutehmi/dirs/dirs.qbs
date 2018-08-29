import qbs
import qbs.TextFile

Module {
	additionalProductTypes: ["cutehmi.dirs.hpp"]

	setupRunEnvironment: {
		if (qbs.targetOS.contains("windows"))
			Environment.putEnv("PATH", externalLibDir + qbs.pathListSeparator + Environment.getEnv("PATH"))
		else
			Environment.putEnv("LD_LIBRARY_PATH", externalLibDir + qbs.pathListSeparator + Environment.getEnv("LD_LIBRARY_PATH"))

		Environment.putEnv("QML2_IMPORT_PATH", qbs.installRoot + "/" + qmlExtensionInstallDirname);
	}

	property bool generateHeaderFile: false

	property string moduleInstallDirname: "bin"
	property string toolInstallDirname: "bin"
	property string qmlExtensionInstallDirname: "QML"
	property string qmlPluginInstallDirname: "plugins"
	property string qmlSourceDir: project.sourceDirectory + "/QML"

	property string externalDeployDir: project.sourceDirectory + "/external/deploy"
	property string externalLibDir: externalDeployDir + "/lib"
	property string externalIncludeDir: externalDeployDir + "/include"

	FileTagger {
		patterns: ["*.qbs"]
		fileTags: ["qbs"]
	}

	Rule {
		condition: product.cutehmi.dirs.generateHeaderFile
		multiplex: true
		inputs: ["qbs"]
		inputsFromDependencies: "qbs"

		prepare: {
			var hppCmd = new JavaScriptCommand();
			hppCmd.description = "generating " + product.sourceDirectory + "/cutehmi.dirs.hpp"
			hppCmd.highlight = "codegen";
			hppCmd.sourceCode = function() {
				console.info("Regenerating file " + product.sourceDirectory + "/cutehmi.dirs.hpp")

				var f = new TextFile(product.sourceDirectory + "/cutehmi.dirs.hpp", TextFile.WriteOnly);
				try {
					var prefix = "CUTEHMI_DIRS"

					f.writeLine("#ifndef " + prefix + "_HPP")
					f.writeLine("#define " + prefix + "_HPP")

					f.writeLine("")
					f.writeLine("// This file has been autogenerated by Qbs cutehmi.dirs module.")
					f.writeLine("")

					f.writeLine("#define " + prefix + "_MODULE_INSTALL_DIRNAME \"" + product.cutehmi.dirs.moduleInstallDirname + "\"")
					f.writeLine("#define " + prefix + "_TOOL_INSTALL_DIRNAME \"" + product.cutehmi.dirs.toolInstallDirname + "\"")
					f.writeLine("#define " + prefix + "_QML_EXTENSION_INSTALL_DIRNAME \"" + product.cutehmi.dirs.qmlExtensionInstallDirname + "\"")
					f.writeLine("#define " + prefix + "_QML_PLUGIN_INSTALL_DIRNAME \"" + product.cutehmi.dirs.qmlPluginInstallDirname + "\"")
					f.writeLine("")
					f.writeLine("#endif")
				} finally {
					f.close()
				}
			}

			return [hppCmd]
		}

		Artifact {
			filePath: product.sourceDirectory + "/cutehmi.dirs.hpp"
			fileTags: ["cutehmi.dirs.hpp", "hpp"]
		}
	}
}

//(c)MP: Copyright © 2018, Michal Policht. All rights reserved.
//(c)MP: This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.