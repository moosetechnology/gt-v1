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
	self activateWithoutSaving.
	Smalltalk snapshot: true andQuit: true
]

{ #category : #activation }
GTImageSetupCommandLineHandler >> activateWithoutSaving [
	self cleanupWorld.
	self installGLMWhitespaceTheme.
	self installFonts.
	self installAthens.
	self installGTInspector.
	self installGTDebuggers.
	self installGTPlayground.
	self flushMCCache.
	self setPreferredSettings.
	self disableBreakingCommandPlusOKeybindingsInPharo30
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> cleanupWorld [
	World color: Color white
]

{ #category : #patches }
GTImageSetupCommandLineHandler >> disableBreakingCommandPlusOKeybindingsInPharo30 [
	((KMRepository default globalCategories flatCollect: [ :each | each allEntries keymaps ])
		select: [ :each | each shortcut beginsWith: $o command ]) do: #disable
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> flushMCCache [
	MCFileBasedRepository flushAllCaches 
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installAthens [
	ROPlatform setCurrent: 'athens'
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installDemoFonts [
	self loadFonts.
	StandardFonts 
		setAllStandardFontsTo: (LogicalFont familyName: 'Source Sans Pro' pointSize: 12);
		haloFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 12);
		windowTitleFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 18);
		balloonFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 12);
		codeFont: (LogicalFont familyName: 'Source Code Pro' pointSize: 14)
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installFonts [
	self loadFonts.
	StandardFonts 
		setAllStandardFontsTo: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10);
		haloFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10);
		windowTitleFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 14);
		balloonFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 10);
		codeFont: (LogicalFont familyName: 'Source Code Pro' pointSize: 10)
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installGLMWhitespaceTheme [
	GLMWhitespaceTheme 
		defaultSettings: nil;
		setPreferredWorldBackground;
		beCurrent
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installGTDebuggers [
	
	GTGenericStackDebugger registerToolsOn: Smalltalk tools.
	
	GTGenericStackDebugger registerExtraToolsOn: Smalltalk tools.
	GTGlamourDebugger registerToolsOn: Smalltalk tools.
	#ACGlamourDebugger asClassIfPresent: [ :acdDebugger | acdDebugger register ].
	GTSUnitDebugger registerToolsOn: Smalltalk tools.
	
	GTMoldableDebugger enableDebuggerWindowDistinctColor: true
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installGTInspector [
	GTInspector registerToolsOn: Smalltalk tools 
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> installGTPlayground [
	
	GTPlayground registerToolsOn: Smalltalk tools
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> loadFonts [
	#('SourceCodeProRegular' 'SourceCodeProBold' 'SourceSansProRegular' 'SourceSansProBold') do: [ :each | 
		each asSymbol asClassIfAbsent: [
			Gofer new 
				smalltalkhubUser: 'girba' project: 'FreeFonts';
				package: each;
				load ].
		"(Smalltalk at: each asSymbol) new install"
		FreeTypeFontProvider registerFont: (Smalltalk at: each asSymbol) ].
	FreeTypeSystemSettings loadFt2Library: true.
	FreeTypeFontProvider current updateFromSystem
]

{ #category : #patches }
GTImageSetupCommandLineHandler >> loadOlderAthensPackagesToCorrectTheFontCachingProblem [
	"
	This is a workaround fir the bug described here:
	https://pharo.fogbugz.com/f/cases/12777/Athens-font-cacheing-bug
	"
	Gofer new 
		smalltalkhubUser: 'Pharo' project: 'Pharo30';
		package: 'Athens-Cairo' constraint: [ :version |
			version author = 'MarcusDenker' and: [ version versionNumber = 51 ] ];
		package: 'Athens-Core' constraint: [ :version | 
			version author = 'MarcusDenker' and: [ version versionNumber = 34 ] ];
		load
		
]

{ #category : #utilities }
GTImageSetupCommandLineHandler >> setPreferredSettings [
	NECPreferences popupShowAutomatic: false.
	GTGenericStackDebugger enableStackColoring: true.
]
