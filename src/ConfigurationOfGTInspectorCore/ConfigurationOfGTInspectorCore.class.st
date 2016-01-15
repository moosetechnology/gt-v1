"
Core configuration of GTInspector for integrating with Pharo.

self loadDevelopment
"
Class {
	#name : #ConfigurationOfGTInspectorCore,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTInspectorCore
}

{ #category : #'development support' }
ConfigurationOfGTInspectorCore class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTInspectorCore class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTInspectorCore class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTInspectorCore class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGTInspectorCore class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTInspectorCore class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTInspectorCore class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTInspectorCore class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTInspectorCore class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTInspectorCore class >> validate [
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
ConfigurationOfGTInspectorCore >> baseline20: spec [
	<version: '2.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'GTInspector Core'.
		spec author: 'AndreiChis'.
		spec timestamp: '2014-10-29'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec 
			package: 'GT-Inspector' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-InspectorExtensions-Core' with: [
				spec requires: #('GT-Inspector' 'GlamourCore' ). ];
			package: 'GT-Tests-Inspector' with: [
				spec requires: #('GT-Inspector' 'GT-InspectorExtensions-Core' ). ].
		
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec 
			group: 'Core' with: #('GT-Inspector' 'GT-InspectorExtensions-Core' );
			group: 'Tests' with: #('GT-Tests-Inspector' );
			group: 'default' with: #('GT-Inspector' 'GT-InspectorExtensions-Core' 'GT-Tests-Inspector' ) ]

]

{ #category : #accessing }
ConfigurationOfGTInspectorCore >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTInspectorCore >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '2.0-baseline'.

	spec for: #'pharo4.x' version: '2.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTInspectorCore >> project [

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
ConfigurationOfGTInspectorCore >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.7'.

	spec for: #'pharo3.x' version: '2.0.6'.

	spec for: #'pharo4.x' version: '2.0.15'.

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version200: spec [
	<version: '2.0.0' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/29/2014 17:01'.
		
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.266';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.74';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. 
		spec 
			project: 'GlamourCore' with: '3.0.0'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2010: spec [
	<version: '2.0.10' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.10'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/16/2015 19:10'.
		spec project: 'GlamourCore' with: '3.0.10'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.284';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.93';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2011: spec [
	<version: '2.0.11' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.11'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/06/2015 22:04'.
		spec project: 'GlamourCore' with: '3.1.0'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.305';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.144';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2012: spec [
	<version: '2.0.12' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.12'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/11/2015 18:02'.
		spec project: 'GlamourCore' with: '3.1.1'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.305';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.144';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2013: spec [
	<version: '2.0.13' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.13'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/29/2015 11:11'.
		spec project: 'GlamourCore' with: '3.1.2'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-SeanDeNigris.306';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TorstenBergmann.145';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2014: spec [
	<version: '2.0.14' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.14'.
		spec author: 'AndreiChis'.
		spec timestamp: '05/05/2015'.
		spec project: 'GlamourCore' with: '3.1.3'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.305';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.147';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2015: spec [
	<version: '2.0.15' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.15'.
		spec author: 'AndreiChis'.
		spec timestamp: '5/15/2015'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.307';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.147';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2016: spec [
	<version: '2.0.16' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.16'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/1/2015'.
		spec project: 'GlamourCore' with: '3.1.7'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.308';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.149';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2017: spec [
	<version: '2.0.17' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.17'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/3/2015'.
		spec project: 'GlamourCore' with: '3.1.8'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.308';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-VincentBlondeau.150';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2018: spec [
	<version: '2.0.18' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.18'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/12/2015'.
		spec project: 'GlamourCore' with: '3.1.9'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-MarcusDenker.309';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TorstenBergmann.159';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.33'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2019: spec [
	<version: '2.0.19' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.19'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/1/2015'.
		spec project: 'GlamourCore' with: '3.1.10'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.310';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TorstenBergmann.159';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.34'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version201: spec [
	<version: '2.0.1' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/13/2014 13:54'.
		
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-BernardoContreras.267';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.76';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. 
		spec 
			project: 'GlamourCore' with: '3.0.1'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2020: spec [
	<version: '2.0.20' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'remove  hard dependency to theme icons (they will be remove, and also it was bad :) )'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10/1/2015 14:30'.
		spec project: 'GlamourCore' with: '3.2.2'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.310';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-EstebanLorenzano.160';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.34'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2021: spec [
	<version: '2.0.21' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'cleanup before remove ThemeIcons'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10/2/2015 16:09'.
		spec project: 'GlamourCore' with: '3.2.3'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.310';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-EstebanLorenzano.161';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.34'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version2022: spec [
	<version: '2.0.22' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfixes and examples'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/15/2015 16:26'.
		spec project: 'GlamourCore' with: '3.2.5'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.344';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.178';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.41'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version202: spec [
	<version: '2.0.2' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/14/2014 11:48'.
		
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-BernardoContreras.267';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.76';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. 
		spec 
			project: 'GlamourCore' with: '3.0.2'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version203: spec [
	<version: '2.0.3' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/07/2014 13:58'.
		
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-EstebanLorenzano.271';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.86';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. 
		spec 
			project: 'GlamourCore' with: '3.0.3'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version204: spec [
	<version: '2.0.4' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/09/2014 12:08'.
		
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-EstebanLorenzano.271';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.86';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. 
		spec 
			project: 'GlamourCore' with: '3.0.4'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version205: spec [
	<version: '2.0.5' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 13:38'.
		
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.275';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.87';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. 
		spec 
			project: 'GlamourCore' with: '3.0.5'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version206: spec [
	<version: '2.0.6' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.6'.
		spec author: 'TudorGirba'.
		spec timestamp: '12/23/2014 14:07'.
		spec project: 'GlamourCore' with: '3.0.6'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.276';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.88';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version207: spec [
	<version: '2.0.7' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/04/2015 14:07'.
		spec project: 'GlamourCore' with: '3.0.7'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.276';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.88';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version208: spec [
	<version: '2.0.8' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/07/2015 17:28'.
		spec project: 'GlamourCore' with: '3.0.8'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.278';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.91';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version209: spec [
	<version: '2.0.9' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.9'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/08/2015 21:41'.
		spec project: 'GlamourCore' with: '3.0.9'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.279';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.92';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.24'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version21: spec [
	<version: '2.1' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Updated GTools: 
  - bug fixes
  - deprecated PluggableTextMorph
  - improved event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/9/2015 14:32'.
		spec project: 'GlamourCore' with: '3.3'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.347';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.185';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.41'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version221: spec [
	<version: '2.2.1' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Changes in the use of #garbageCollect'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/25/2015 18:00'.
		spec project: 'GlamourCore' with: '3.4.1'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.351';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.185';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.49'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version222: spec [
	<version: '2.2.2' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools: small fixes and improvements (issue 17184)'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/4/2015 11:12'.
		spec project: 'GlamourCore' with: '3.4.2'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-StefanReichhart.355';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.186';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.49'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version22: spec [
	<version: '2.2' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools. 
 - bug fixes
 - improvements in the event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/19/2015 20:57'.
		spec project: 'GlamourCore' with: '3.4'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.350';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.185';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-StefanReichhart.48'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version23: spec [
	<version: '2.3' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Load GTDebugger together with the extensions for SUnit and Bytecode.
Bugfixes (17190, 17206, 17336, 17337, 17225)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/7/2016 10:41'.
		spec project: 'GlamourCore' with: '3.5'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.360';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.188';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.50'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version24: spec [
	<version: '2.4' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'This version fixes problems in GTDebugger and updates  Rubric (issues: 17155, 17279, 17152)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/8/2016 19:27'.
		spec project: 'GlamourCore' with: '3.6'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-TudorGirba.360';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.188';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.50'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version25: spec [
	<version: '2.5' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Fixes in the debugger, inspector and spotter.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/10/2016 23:53'.
		spec project: 'GlamourCore' with: '3.7'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-StefanReichhart.367';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.192';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.50'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version26: spec [
	<version: '2.6' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in Spotter and Glamour'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 16:23'.
		spec project: 'GlamourCore' with: '3.8'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.368';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-YuriyTymchuk.193';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.50'. ].

]

{ #category : #versions }
ConfigurationOfGTInspectorCore >> version27: spec [
	<version: '2.7' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in inspector and debugger'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 18:14'.
		spec project: 'GlamourCore' with: '3.9'.
		spec 
			package: 'GT-Inspector' with: 'GT-Inspector-AndreiChis.370';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-YuriyTymchuk.193';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.50'. ].

]
