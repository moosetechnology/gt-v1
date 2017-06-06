Class {
	#name : #ConfigurationOfGTEventRecorderServer,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTEventRecorderServer
}

{ #category : #'development support' }
ConfigurationOfGTEventRecorderServer class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTEventRecorderServer class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTEventRecorderServer class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTEventRecorderServer class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGTEventRecorderServer class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTEventRecorderServer class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTEventRecorderServer class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTEventRecorderServer class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTEventRecorderServer class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTEventRecorderServer class >> validate [
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
ConfigurationOfGTEventRecorderServer >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec project: 'GTEventRecorder' with: [
				spec
					className: #ConfigurationOfGTEventRecorder;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		spec package: 'GT-EventRecorder-Server' with: [
				spec requires: #('GTEventRecorder' ). ].
		spec 
			group: 'Core' with: #('GT-EventRecorder-Server');
			group: 'default' with: #('Core') ].

]

{ #category : #accessing }
ConfigurationOfGTEventRecorderServer >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTEventRecorderServer >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.1-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTEventRecorderServer >> project [

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
ConfigurationOfGTEventRecorderServer >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.3'.

	spec for: #'pharo4.x' version: '0.1'.

	spec for: #'pharo5.x' version: '0.3'.

]

{ #category : #versions }
ConfigurationOfGTEventRecorderServer >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1'.
		spec author: 'JurajKubelka'.
		spec timestamp: '11/15/2015 19:17'.
		spec project: 'GTEventRecorder' with: '0.2'.
		spec package: 'GT-EventRecorder-Server' with: 'GT-EventRecorder-Server-JurajKubelka.5'. ].

]

{ #category : #versions }
ConfigurationOfGTEventRecorderServer >> version02: spec [
	<version: '0.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Introduce GTEventRecorderZipHandler that allows to compress and download a given category using:
 http://gc.dcc.uchile.cl:8080/gt/zip?category=spotter'.
		spec author: 'JurajKubelka'.
		spec timestamp: '6/5/2017 21:27'.
		spec project: 'GTEventRecorder' with: '1.8'.
		spec package: 'GT-EventRecorder-Server' with: 'GT-EventRecorder-Server-JurajKubelka.7'. ].

]

{ #category : #versions }
ConfigurationOfGTEventRecorderServer >> version03: spec [
	<version: '0.3' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'add more tests and fix configuration for Pharo 4.0. 
the new version depends on Pharo 5.0 because of UFFI'.
		spec author: 'JurajKubelka'.
		spec timestamp: '6/6/2017 03:46'.
		spec project: 'GTEventRecorder' with: '0.16'.
		spec package: 'GT-EventRecorder-Server' with: 'GT-EventRecorder-Server-JurajKubelka.8'. ].

]
