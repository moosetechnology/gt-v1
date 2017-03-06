"
self loadDevelopment
"
Class {
	#name : #ConfigurationOfGTDebugger,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTDebugger
}

{ #category : #'development support' }
ConfigurationOfGTDebugger class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTDebugger class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTDebugger class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTDebugger class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGTDebugger class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTDebugger class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTDebugger class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTDebugger class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTDebugger class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTDebugger class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfGTDebugger >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec package: 'GT-Debugger' with: [ spec requires: #( 'GTInspector' 'NewDebugger' )].
		spec group: 'default' with: #('GT-Debugger').
		
		spec project: 'GTInspector' with: [
				spec
					className: 'ConfigurationOfGToolkit';
					file: 'ConfigurationOfGToolkit';
					version: #development;
					loads: #('GT-Inspector');
					repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main' ].
				
		spec project: 'NewDebugger' with: [
				spec
					versionString: #'development';
					className: 'ConfigurationOfNewDebugger';
					loads: #( 'Core' 'DebuggerExtensions');
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ] ].

]

{ #category : #baselines }
ConfigurationOfGTDebugger >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec package: 'GT-Debugger' with: [ spec requires: #( 'GTInspector' 'NewDebugger' )].
		spec group: 'default' with: #('GT-Debugger').
		
		spec project: 'GTInspector' with: [
				spec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
				
		spec project: 'NewDebugger' with: [
				spec
					versionString: #'development';
					className: 'ConfigurationOfNewDebugger';
					loads: #( 'Core' 'DebuggerExtensions');
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ] ].

]

{ #category : #baselines }
ConfigurationOfGTDebugger >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec description: 'Added GT-Tests-Debugger'.
		spec package: 'GT-Debugger' with: [ spec requires: #( 'GTInspector' 'NewDebugger' )].
		spec package: 'GT-Tests-Debugger' with: [ spec requires: #( 'GT-Debugger' )].
		spec group: 'Tests' with: #('GT-Tests-Debugger').
		spec group: 'default' with: #('GT-Debugger' 'Tests').
		
		spec project: 'GTInspector' with: [
				spec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
				
		spec project: 'NewDebugger' with: [
				spec
					versionString: #'development';
					className: 'ConfigurationOfNewDebugger';
					loads: #( 'Core' 'DebuggerExtensions');
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ] ].

]

{ #category : #baselines }
ConfigurationOfGTDebugger >> baseline04: spec [
	<version: '0.4-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec description: 'Load just DebuggerExtensions from NewDebugger'.
		spec package: 'GT-Debugger' with: [ spec requires: #( 'GTInspector' 'NewDebugger' )].
		spec package: 'GT-Tests-Debugger' with: [ spec requires: #( 'GT-Debugger' )].
		spec group: 'Tests' with: #('GT-Tests-Debugger').
		spec group: 'default' with: #('GT-Debugger' 'Tests').
		
		spec project: 'GTInspector' with: [
				spec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
				
		spec project: 'NewDebugger' with: [
				spec
					versionString: #'development';
					className: 'ConfigurationOfNewDebugger';
					loads: #('DebuggerExtensions');
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ] ].

]

{ #category : #baselines }
ConfigurationOfGTDebugger >> baseline05: spec [
	<version: '0.5-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec author: 'AndreiChis'.
		spec description: 'Baseline for integrating GTDebugger in Pharo 5'.
		
		spec package: 'GT-Debugger' with: [ spec requires: #( 'GTInspectorCore' )].
		spec package: 'GT-BytecodeDebugger' with: [ spec	requires: #( 'GT-Debugger') ].
		spec package: 'GT-SUnitDebugger' with: [ spec requires: #( 'GT-Debugger') ].
		spec package: 'GT-Tests-Debugger' with: [ spec requires: #( 'GT-Debugger' 'GT-BytecodeDebugger' 'GT-SUnitDebugger' )].
		
		spec group: 'default' with: #('GT-Debugger' 'GT-BytecodeDebugger' 'GT-SUnitDebugger' 'GT-Tests-Debugger').
		
		spec project: 'GTInspectorCore' with: [
				spec
					className: #ConfigurationOfGTInspectorCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ] ].

]

{ #category : #accessing }
ConfigurationOfGTDebugger >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTDebugger >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.5-baseline'.

	spec for: #'pharo3.x' version: '0.4-baseline'.

	spec for: #'pharo4.x' version: '0.4-baseline'.

	spec for: #'pharo5.x' version: #'stable'.

	spec for: #'pharo6.x' version: '0.5-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTDebugger >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfGTDebugger >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '3.10'.

	spec for: #'pharo3.x' version: '1.0.0'.

	spec for: #'pharo4.x' version: '1.0.1'.

	spec for: #'pharo5.x' version: '3.0'.

	spec for: #'pharo6.x' version: '3.9'.

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version100: spec [
	<version: '1.0.0' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 14:11'.
		spec 
			project: 'GTInspector' with: #'stable';
			project: 'NewDebugger' with: #'stable'.
		spec 
			package: #'GT-Debugger' with: 'GT-Debugger-AndreiChis.213'].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version101: spec [
	<version: '1.0.1' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '05/05/2014'.
		spec 
			project: 'GTInspector' with: #'stable';
			project: 'NewDebugger' with: #'stable'.
		spec 
			package: #'GT-Debugger' with: 'GT-Debugger-AndreiChis.240'].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version11: spec [
	<version: '1.1' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Load GTDebugger together with the extensions for SUnit and Bytecode.
Bugfixes (17190, 17206, 17336, 17337, 17225)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/7/2016 10:41'.
		spec project: 'GTInspectorCore' with: '2.3'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.264';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.23';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.21';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.4'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version12: spec [
	<version: '1.2' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'This version fixes problems in GTDebugger and updates  Rubric (issues: 17155, 17279, 17152)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/8/2016 19:27'.
		spec project: 'GTInspectorCore' with: '2.4'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.268';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.24';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.21';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.5'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version13: spec [
	<version: '1.3' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Fixes in the debugger, inspector and spotter.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/10/2016 23:53'.
		spec project: 'GTInspectorCore' with: '2.5'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.293';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.28';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.24';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.5'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version14: spec [
	<version: '1.4' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in inspector and debugger'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 18:14'.
		spec project: 'GTInspectorCore' with: '2.7'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.297';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.28';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.24';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version15: spec [
	<version: '1.5' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes and improvements.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/18/2016 13:24'.
		spec project: 'GTInspectorCore' with: '2.8'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.307';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.28';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.24';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TudorGirba.8'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version16: spec [
	<version: '1.6' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.10'.
		spec author: 'AndreiChis'.
		spec timestamp: '02/08/2016 15:54'.
		spec project: 'GTInspectorCore' with: '2.9'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.312';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.32';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.11'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version17: spec [
	<version: '1.7' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bug fix 17602'.
		spec author: 'AndreiChis'.
		spec timestamp: '02/08/2016 15:54'.
		spec project: 'GTInspectorCore' with: '2.9'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-DenisKudryashov.313';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.32';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TheIntegrator.13'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version20: spec [
	<version: '2.0' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools version 3.11'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/18/2016 14:21'.
		spec project: 'GTInspectorCore' with: '3.0'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.322';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.38';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TheIntegrator.13'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version210: spec [
	<version: '2.10' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.23'.
		spec author: 'AndreiChis'.
		spec timestamp: '6/27/2016 12:09'.
		spec project: 'GTInspectorCore' with: '3.15'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.352';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-MarcusDenker.32';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version211: spec [
	<version: '2.11' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Integration for case 18773.

Fixes these issues:
- case 18691
- case 18471
- case 18244
- case 18708

Apart from the issues:
- GT-InspectorExtensions: only show methods for the current class, added basic example for RBCondition
- Uses Pragma>>#methodSelector instead of Pragma>>#selector (case 18665).
- Uses Behavior>>#classLayout instead of Behavior>>#layout (case 16636).
- Uses CompiledMethod>>#sourceCode instead of CompiledMethod>>#getSource (case 18694).
- GT-EventRecorder: Add a basic recorder event'.
		spec author: 'JurajKubelka'.
		spec timestamp: '7/13/2016 10:05'.
		spec project: 'GTInspectorCore' with: '3.15'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.352';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-MarcusDenker.32';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version212: spec [
	<version: '2.12' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Stable version for Pharo 5.0.'.
		spec author: 'JurajKubelka'.
		spec timestamp: '7/14/2016 13:48'.
		spec project: 'GTInspectorCore' with: '3.17'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.350';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version213: spec [
	<version: '2.13' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Prevent infinite loop in GLMScrollListBrick>>#preventOverscrolling
 - in some cases it was moving band to the top and to the bottom.'.
		spec author: 'JurajKubelka'.
		spec timestamp: '7/21/2016 10:05'.
		spec project: 'GTInspectorCore' with: '3.18'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.352';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-MarcusDenker.32';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version21: spec [
	<version: '2.1' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.12'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/20/2016 00:11'.
		spec project: 'GTInspectorCore' with: '3.1'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.328';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TheIntegrator.13'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version22: spec [
	<version: '2.2' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.14'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/28/2016 12:11'.
		spec project: 'GTInspectorCore' with: '3.3'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.328';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TheIntegrator.13'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version23: spec [
	<version: '2.3' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools Version 3.15'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/17/2016 10:50'.
		spec project: 'GTInspectorCore' with: '3.4'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-MarcusDenker.329';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TheIntegrator.13'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version24: spec [
	<version: '2.4' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.16'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/23/2016 14:21'.
		spec project: 'GTInspectorCore' with: '3.5'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-MarcusDenker.329';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-TheIntegrator.13'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version25: spec [
	<version: '2.5' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.17'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/29/2016 23:44'.
		spec project: 'GTInspectorCore' with: '3.6'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.349';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version26: spec [
	<version: '2.6' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.18'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/8/2016 10:36'.
		spec project: 'GTInspectorCore' with: '3.7'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.350';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version27: spec [
	<version: '2.7' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.19'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/14/2016 13:57'.
		spec project: 'GTInspectorCore' with: '3.8'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.350';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version28: spec [
	<version: '2.8' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.20 (case 18022)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/18/2016 22:57'.
		spec project: 'GTInspectorCore' with: '3.9'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.350';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version29: spec [
	<version: '2.9' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.22 (case 17948)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/28/2016 16:25'.
		spec project: 'GTInspectorCore' with: '3.14'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.350';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-TudorGirba.31';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version30: spec [
	<version: '3.0' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Moose 6.0 release'.
		spec author: 'TudorGirba'.
		spec timestamp: '8/14/2016 20:44'.
		spec project: 'GTInspectorCore' with: #'stable'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.352';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-MarcusDenker.32';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version310: spec [
	<version: '3.10' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.36'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/6/2017 14:09'.
		spec project: 'GTInspectorCore' with: '3.28'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.379';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.36';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version31: spec [
	<version: '3.1' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.27'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/25/2016 14:40'.
		spec project: 'GTInspectorCore' with: '3.19'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.352';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-MarcusDenker.32';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version32: spec [
	<version: '3.2' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.28'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/22/2016 23:31'.
		spec project: 'GTInspectorCore' with: '3.20'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-PavelKrivanek.353';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-MarcusDenker.32';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version33: spec [
	<version: '3.3' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.29'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/4/2016 12:00'.
		spec project: 'GTInspectorCore' with: '3.21'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.354';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version34: spec [
	<version: '3.4' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.30'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/1/2016 11:15'.
		spec project: 'GTInspectorCore' with: '3.22'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.356';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version35: spec [
	<version: '3.5' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Glamour version 4.28 includes Glamour <--> Spec integration'.
		spec author: 'JurajKubelka'.
		spec timestamp: '12/27/2016 13:18'.
		spec project: 'GTInspectorCore' with: '3.23'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.360';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version36: spec [
	<version: '3.6' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.32'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/27/2016 21:38'.
		spec project: 'GTInspectorCore' with: '3.24'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AndreiChis.361';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version37: spec [
	<version: '3.7' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.33'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/3/2017 18:29'.
		spec project: 'GTInspectorCore' with: '3.25'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-TheIntegrator.368';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version38: spec [
	<version: '3.8' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.26'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/11/2017 18:13'.
		spec project: 'GTInspectorCore' with: '3.26'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AliakseiSyrel.369';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTDebugger >> version39: spec [
	<version: '3.9' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.35'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/20/2017 16:30'.
		spec project: 'GTInspectorCore' with: '3.27'.
		spec 
			package: 'GT-Debugger' with: 'GT-Debugger-AliakseiSyrel.369';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.33';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-TudorGirba.39';
			package: 'GT-Tests-Debugger' with: 'GT-Tests-Debugger-AndreiChis.14'. ].

]
