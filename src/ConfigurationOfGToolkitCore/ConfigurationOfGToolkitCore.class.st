"
ConfigurationOfGToolkitCore loadDevelopment

Instance Variables
	project:		<Object>

project
	- xxxxx

"
Class {
	#name : #ConfigurationOfGToolkitCore,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGToolkitCore
}

{ #category : #'development support' }
ConfigurationOfGToolkitCore class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGToolkitCore class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGToolkitCore class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGToolkitCore class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGToolkitCore class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGToolkitCore class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGToolkitCore class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGToolkitCore class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGToolkitCore class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGToolkitCore class >> validate [
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
ConfigurationOfGToolkitCore >> baseline30: spec [
	<version: '3.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec project: 'GTPlaygroundCore' with: [
				spec
					className: #ConfigurationOfGTPlaygroundCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		
		spec project: 'GTInspectorCore' with: [
				spec
					className: #ConfigurationOfGTInspectorCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		spec project: 'GTSpotter' with: [
				spec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		
		spec group: 'default' with: #('GTPlaygroundCore' 'GTInspectorCore' 'GTSpotter' ). ].

]

{ #category : #accessing }
ConfigurationOfGToolkitCore >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGToolkitCore >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'pharo3.x' version: '3.0-baseline'.
	spec for: #'pharo4.x' version: '3.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfGToolkitCore >> project [

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
ConfigurationOfGToolkitCore >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '3.0.1'.

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version300: spec [
	<version: '3.0.0' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/08/2015 22:11'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.0'. 
		spec project: 'GTInspectorCore' with: '2.0.11'.
		spec project: 'GTSpotter' with: '1.2.0'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version301: spec [
	<version: '3.0.1' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/11/2015 18:05'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.1'. 
		spec project: 'GTInspectorCore' with: '2.0.12'.
		spec project: 'GTSpotter' with: '1.2.1'. ]
	

]
