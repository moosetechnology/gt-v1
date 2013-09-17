"
A ConfigurationOfGTMetaceller is a mock configuration as GTMetaceller is part of the GT Toolbox.

It has all kinds of strange constructs, to allow for testing.
"
Class {
	#name : #ConfigurationOfMetaceller,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfMetaceller
}

{ #category : #'development support' }
ConfigurationOfMetaceller class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfMetaceller class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfMetaceller class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfMetaceller class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfMetaceller class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMetaceller class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfMetaceller class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfMetaceller class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfMetaceller class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfMetaceller class >> validate [
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
ConfigurationOfMetaceller >> baseline01: aSpec [
	<version: '0.1-baseline'>
	aSpec for: #common do: [ 
		aSpec blessing: #'baseline'.
		aSpec description: 'The group "gemstone" is just for testing. It should load fine in pharo. It also loads as part of the GT-Tools'.

		aSpec package: 'GT-Metaceller-Model';
			package: 'GT-Metaceller-Glamour' with: [ 
				aSpec requires: #( 'GT-Metaceller-Model' ) ];
			package: 'GT-Metaceller-Tests' with: [ 
				aSpec requires: #( 'GT-Metaceller-Model' ) ].
		aSpec
			group: 'Core' with: #( 'GT-Metaceller-Model' );
			group: 'Tests' with: #( 'GT-Metaceller-Tests' );
			group: 'Glamour' with: #( 'GT-Metaceller-Glamour' );
			group: 'All' with: #( 'Tests' 'Glamour' ) ].
	
	aSpec for: #gemstone do: [ 
		aSpec project: 'GlamourCore' with: [
				aSpec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec package: 'GT-Metaceller-Glamour' with: [ 
			aSpec requires: #( 'GlamourCore' ) ] ].

	aSpec for: #pharo do: [ 
		aSpec project: 'GlamourAll' with: [
				aSpec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Extras' 'Morphic');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec package: 'GT-Metaceller-Glamour' with: [ 
			aSpec requires: #( 'GlamourAll' ) ] ]
]

{ #category : #accessing }
ConfigurationOfMetaceller >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #accessing }
ConfigurationOfMetaceller >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfMetaceller >> version01: aSpec [
	<version: '0.1' imports: #( '0.1-baseline')>
	aSpec for: #'common' do: [ 
		aSpec blessing: #'development' ]
]
