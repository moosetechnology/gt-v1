"
Core configuration of GTPlayground for integrating with Pharo.

self loadDevelopment
"
Class {
	#name : #ConfigurationOfGTPlaygroundCore,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTPlaygroundCore
}

{ #category : #'development support' }
ConfigurationOfGTPlaygroundCore class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTPlaygroundCore class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTPlaygroundCore class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTPlaygroundCore class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGTPlaygroundCore class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTPlaygroundCore class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTPlaygroundCore class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTPlaygroundCore class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTPlaygroundCore class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTPlaygroundCore class >> validate [
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
ConfigurationOfGTPlaygroundCore >> baseline20: spec [
	<version: '2.0-baseline'>

	spec for: #'common' do: [
	spec blessing: #'baseline'.
	spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
	
	spec package: 'GT-Playground' with: [
			spec requires: #('GTInspectorCore' ). ].
		
	spec project: 'GTInspectorCore' with: [
			spec
				className: #ConfigurationOfGTInspectorCore;
				versionString: #'development';
				repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
	
	spec group: 'default' with: #('GT-Playground' ) ].
]

{ #category : #baselines }
ConfigurationOfGTPlaygroundCore >> baseline21: spec [
	<version: '2.1-baseline'>

	spec for: #'common' do: [
	spec blessing: #'baseline'.
	spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
	
	spec package: 'GT-Playground' with: [
			spec requires: #('GTInspectorCore')].
	spec package: 'GT-Tests-Playground' with: [
			spec requires: #('GT-Playground')].
		
	spec project: 'GTInspectorCore' with: [
			spec
				className: #ConfigurationOfGTInspectorCore;
				versionString: #'development';
				repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
	
	spec group: 'default' with: #('GT-Playground' 'GT-Tests-Playground') ].
]

{ #category : #accessing }
ConfigurationOfGTPlaygroundCore >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTPlaygroundCore >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '2.1-baseline'.
	spec for: #'pharo4.x' version: '2.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTPlaygroundCore >> project [

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
ConfigurationOfGTPlaygroundCore >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.1.7'.
	spec for: #'pharo3.x' version: '2.0.5'.
	spec for: #'pharo4.x' version: '2.1.5'.
	spec for: #'pharo5.x' version: '2.1.7'.

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version200: spec [
	<version: '2.0.0' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/29/2014 16:54'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.48'.
		spec project: 'GTInspectorCore' with: '2.0.0'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version201: spec [
	<version: '2.0.1' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/13/2014 13:54'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.49'.
		spec project: 'GTInspectorCore' with: '2.0.1'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version202: spec [
	<version: '2.0.2' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/14/2014 11:48'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.49'.
		spec project: 'GTInspectorCore' with: '2.0.2'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version203: spec [
	<version: '2.0.3' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/07/2014 13:48'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.52'.
		spec project: 'GTInspectorCore' with: '2.0.3'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version204: spec [
	<version: '2.0.4' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/09/2014 12:08'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.52'.
		spec project: 'GTInspectorCore' with: '2.0.4'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version205: spec [
	<version: '2.0.5' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 13:38'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.53'.
		spec project: 'GTInspectorCore' with: '2.0.5'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version206: spec [
	<version: '2.0.6' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.6'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/24/2014 10:50'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.53'.
		spec project: 'GTInspectorCore' with: '2.0.6'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version207: spec [
	<version: '2.0.7' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/07/2015 17:25'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.54'.
		spec project: 'GTInspectorCore' with: '2.0.8'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version208: spec [
	<version: '2.0.8' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/08/2015 21:43'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.56'.
		spec project: 'GTInspectorCore' with: '2.0.9'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version209: spec [
	<version: '2.0.9' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.9'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/16/2015 19:12'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.59'.
		spec project: 'GTInspectorCore' with: '2.0.10'. ]

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version210: spec [
	<version: '2.1.0' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/08/2015 22:11'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.109'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.11'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version211: spec [
	<version: '2.1.1' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/11/2015 18:03'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.110'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.12'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version212: spec [
	<version: '2.1.2' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/29/2015 11:12'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.110'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.13'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version213: spec [
	<version: '2.1.3' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '05/05/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.110'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.14'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version214: spec [
	<version: '2.1.4' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '5/15/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-TudorGirba.110'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.15'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version215: spec [
	<version: '2.1.5' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.5'.
		spec author: 'CyrilFerlicot'.
		spec timestamp: '6/14/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-CyrilFerlicot.111'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.15'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version216: spec [
	<version: '2.1.6' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.6'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/1/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-CyrilFerlicot.111'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.16'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version217: spec [
	<version: '2.1.7' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/3/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-CyrilFerlicot.111'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.17'. ]
	

]
