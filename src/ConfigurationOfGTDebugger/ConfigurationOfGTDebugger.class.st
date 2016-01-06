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

	spec for: #'common' version: '0.4-baseline'.
	spec for: #'pharo4.x' version: '0.4-baseline'.
	spec for: #'pharo5.x' version: '0.5-baseline'.

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

	spec for: #'common' version: '1.0.1'.
	spec for: #'pharo3.x' version: '1.0.0'.
	spec for: #'pharo4.x' version: '1.0.1'.

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
