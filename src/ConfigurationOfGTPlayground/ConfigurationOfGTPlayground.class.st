"
Full configuration of GTPlayground for loading into Moose.

self loadDevelopment
"
Class {
	#name : #ConfigurationOfGTPlayground,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTPlayground
}

{ #category : #'development support' }
ConfigurationOfGTPlayground class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTPlayground class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTPlayground class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTPlayground class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGTPlayground class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTPlayground class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTPlayground class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTPlayground class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTPlayground class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTPlayground class >> validate [
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
ConfigurationOfGTPlayground >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec project: 'GTInspector' with: [
				spec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					loads: #('Core' 'Tests' );
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		spec package: 'GT-Playground' with: [
				spec requires: #('GTInspector' ). ].
		spec group: 'default' with: #('GT-Playground' ). ].

]

{ #category : #baselines }
ConfigurationOfGTPlayground >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec project: 'GTInspector' with: [
				spec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					loads: #('Core' 'Tests' );
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		spec package: 'GT-Playground' with: [
				spec requires: #('GTInspector' ). ].
		spec group: 'default' with: #('GT-Playground' ). ].

]

{ #category : #baselines }
ConfigurationOfGTPlayground >> baseline20: spec [
	<version: '2.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec project: 'GTPlaygroundCore' with: [
				spec
					className: #ConfigurationOfGTPlaygroundCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		
		spec project: 'GTInspector' with: [
				spec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		
		spec group: 'default' with: #('GTPlaygroundCore' 'GTInspector' ). ].

]

{ #category : #accessing }
ConfigurationOfGTPlayground >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTPlayground >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '2.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTPlayground >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfGTPlayground >> version101: spec [
	<version: '1.0.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1 bug fixing'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 17:11'.
		spec project: 'GTInspector' with: '1.0.1'.
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.35'. ].

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version102: spec [
	<version: '1.0.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.2 bug fixing'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 20:55'.
		spec project: 'GTInspector' with: '1.0.2'.
		spec package: 'GT-Playground' with: [  
			spec file: 'GT-Playground-AndreiChis.36'.
			spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ] ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version103: spec [
	<version: '1.0.3' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.3 bug fixing'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/01/2014 14:52'.
		spec project: 'GTInspector' with: '1.0.3'.
		spec package: 'GT-Playground' with: [  
			spec file: 'GT-Playground-AndreiChis.36'.
			spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ] ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version104: spec [
	<version: '1.0.4' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.4 bug fixing'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/02/2014 18:16'.
		spec project: 'GTInspector' with: '1.0.4'.
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.36'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version105: spec [
	<version: '1.0.5' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/03/2014 17:06'.
		spec project: 'GTInspector' with: '1.0.5'.
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.37'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version106: spec [
	<version: '1.0.6' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.6'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/06/2014 11:42'.
		spec project: 'GTInspector' with: '1.0.6'.
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.38'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version107: spec [
	<version: '1.0.7' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/12/2014 19:56'.
		spec project: 'GTInspector' with: '1.0.7'.
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.38'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version108: spec [
	<version: '1.0.8' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/28/2014 14:07'.
		spec project: 'GTInspector' with: '1.0.8'.
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.46'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/22/2014 14:45'.
		spec project: 'GTInspector' with: '1.0'.
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.35'. ].

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version200: spec [
	<version: '2.0.0' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/29/2014 16:54'.
		
		spec project: 'GTPlaygroundCore' with: '2.0.0'.
		spec project: 'GTInspector' with: '2.0.0'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version201: spec [
	<version: '2.0.1' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/13/2014 13:54'.
		
		spec project: 'GTPlaygroundCore' with: '2.0.1'.
		spec project: 'GTInspector' with: '2.0.1'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version202: spec [
	<version: '2.0.2' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/14/2014 11:48'.
		
		spec project: 'GTPlaygroundCore' with: '2.0.2'.
		spec project: 'GTInspector' with: '2.0.2'. ]

]

{ #category : #versions }
ConfigurationOfGTPlayground >> version203: spec [
	<version: '2.0.3' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/07/2014 13:58'.
		
		spec project: 'GTPlaygroundCore' with: '2.0.3'.
		spec project: 'GTInspector' with: '2.0.3'. ]

]
