"
The command that can be triggered to setup a image right after the GToolkit configuration is loaded in a fresh Pharo image.

Example usage in a Jenkins:
./pharo $JOB_NAME.image gtimagesetup
"
Class {
	#name : #GTImageSetupCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'GT-Setup'
}

{ #category : #'as yet unclassified' }
GTImageSetupCommandLineHandler class >> commandName [
	^ 'gtimagesetup'
]

{ #category : #'as yet unclassified' }
GTImageSetupCommandLineHandler class >> description [
	^ 'Sets up the image with GToolkit specific tools and settings'
]

{ #category : #activation }
GTImageSetupCommandLineHandler >> activate [
	"self new activate"
	self cleanupWorld.
	self installGLMWhitespaceTheme.
	self installFonts.
	self installAthens.
	self installGTInspector.
	self installGTDebuggers.
	self installGTPlayground.
	self flushMCCache.
	self setPreferredSettings.
	self disableBreakingCommandPlusOKeybindingsInPharo30.
		
	Smalltalk snapshot: true andQuit: true.

]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> cleanupWorld [
	World color: Color white
]

{ #category : #patches }
GTImageSetupCommandLineHandler >> disableBreakingCommandPlusOKeybindingsInPharo30 [
	((KMRepository default globalCategories flatCollect: [ :each | each allEntries keymaps ])
		select: [ :each | each shortcut beginsWith: $o command ]) do: #disable
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> flushMCCache [
	MCFileBasedRepository flushAllCaches 
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> installAthens [
	ROPlatform setCurrent: 'athens'
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> installFonts [
	self loadFonts.
	StandardFonts 
		setAllStandardFontsTo: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10);
		haloFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10);
		windowTitleFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 14);
		balloonFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10);
		codeFont: (LogicalFont familyName: 'Source Code Pro' pointSize: 10)
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> installGLMWhitespaceTheme [
	GLMWhitespaceTheme 
		defaultSettings: nil;
		setPreferredWorldBackground;
		beCurrent
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> installGTDebuggers [
	
	GTGenericStackDebugger registerToolsOn: Smalltalk tools.
	
	GTGenericStackDebugger registerExtraToolsOn: Smalltalk tools.
	GTGlamourDebugger registerToolsOn: Smalltalk tools.
	ACGlamourDebugger registerToolsOn: Smalltalk tools.
	GTSUnitDebugger registerToolsOn: Smalltalk tools.
	
	GTMoldableDebugger enableDebuggerWindowDistinctColor: true
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> installGTInspector [
	GTInspector registerToolsOn: Smalltalk tools 
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> installGTPlayground [
	
	GTPlayground registerToolsOn: Smalltalk tools
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> loadFonts [
	#('SourceCodeProRegular' 'SourceCodeProBold' 'SourceSansProRegular' 'SourceSansProBold') do: [ :each | 
		each asSymbol asClassIfAbsent: [
			Gofer new 
				smalltalkhubUser: 'girba' project: 'FreeFonts';
				package: each;
				load ].
		(Smalltalk at: each asSymbol) new install ].
	FreeTypeSystemSettings loadFt2Library: true.
	FreeTypeFontProvider current updateFromSystem
]

{ #category : #'moose utilities' }
GTImageSetupCommandLineHandler >> setPreferredSettings [
	NECPreferences popupShowAutomatic: false
]
