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

	spec for: #'common' version: '3.13'.

	spec for: #'pharo3.x' version: '2.0.5'.

	spec for: #'pharo4.x' version: '2.1.5'.

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
	<version: '2.10' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.10'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/23/2016 15:53'.
		spec project: 'GTInspectorCore' with: '2.9'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-TudorGirba.119';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version2110: spec [
	<version: '2.1.10' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'remove  hard dependency to theme icons (they will be remove, and also it was bad :) )'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10/1/2015 14:30'.
		spec project: 'GTInspectorCore' with: '2.0.20'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-EstebanLorenzano.113';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version2111: spec [
	<version: '2.1.11' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfixes'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/15/2015 16:28'.
		spec project: 'GTInspectorCore' with: '2.0.22'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.115';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

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

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version218: spec [
	<version: '2.1.8' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/12/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.112'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.18'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version219: spec [
	<version: '2.1.9' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1.9'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/1/2015'.
		
		spec package: 'GT-Playground' with: 'GT-Playground-AndreiChis.112'.
		spec package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'.
		spec project: 'GTInspectorCore' with: '2.0.19'. ]
	

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version22: spec [
	<version: '2.2' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Updated GTools: 
  - bug fixes
  - deprecated PluggableTextMorph
  - improved event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/9/2015 14:32'.
		spec project: 'GTInspectorCore' with: '2.1'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.116';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version231: spec [
	<version: '2.3.1' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Changes in the use of #garbageCollect'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/25/2015 18:00'.
		spec project: 'GTInspectorCore' with: '2.2.1'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.117';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version232: spec [
	<version: '2.3.2' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools: small fixes and improvements (issue 17184)'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/4/2015 11:12'.
		spec project: 'GTInspectorCore' with: '2.2.2'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.117';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version23: spec [
	<version: '2.3' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools. 
 - bug fixes
 - improvements in the event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/19/2015 20:58'.
		spec project: 'GTInspectorCore' with: '2.2'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.117';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version24: spec [
	<version: '2.4' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Load GTDebugger together with the extensions for SUnit and Bytecode.
Bugfixes (17190, 17206, 17336, 17337, 17225)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/7/2016 10:41'.
		spec project: 'GTInspectorCore' with: '2.3'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.117';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version25: spec [
	<version: '2.5' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'This version fixes problems in GTDebugger and updates  Rubric (issues: 17155, 17279, 17152)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/8/2016 19:27'.
		spec project: 'GTInspectorCore' with: '2.4'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.117';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version26: spec [
	<version: '2.6' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Fixes in the debugger, inspector and spotter.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/10/2016 23:53'.
		spec project: 'GTInspectorCore' with: '2.5'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.117';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version27: spec [
	<version: '2.7' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in Spotter and Glamour'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 16:23'.
		spec project: 'GTInspectorCore' with: '2.6'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.118';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version28: spec [
	<version: '2.8' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in inspector and debugger'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 18:14'.
		spec project: 'GTInspectorCore' with: '2.7'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.118';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version29: spec [
	<version: '2.9' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes and improvements.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/18/2016 13:24'.
		spec project: 'GTInspectorCore' with: '2.8'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.118';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version30: spec [
	<version: '3.0' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools version 3.11'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/18/2016 14:21'.
		spec project: 'GTInspectorCore' with: '3.0'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-TudorGirba.119';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version310: spec [
	<version: '3.10' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.22 (case 17948)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/28/2016 16:25'.
		spec project: 'GTInspectorCore' with: '3.14'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-DenisKudryashov.124';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version311: spec [
	<version: '3.11' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.23'.
		spec author: 'AndreiChis'.
		spec timestamp: '6/27/2016 12:09'.
		spec project: 'GTInspectorCore' with: '3.15'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AndreiChis.127';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version312: spec [
	<version: '3.12' imports: #('2.1-baseline' )>

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
		spec timestamp: '7/13/2016 10:06'.
		spec project: 'GTInspectorCore' with: '3.15'.
		spec 
			package: 'GT-Playground' with: 'a MCLazyVersionInfo(GT-Playground-TheIntegrator.130)';
			package: 'GT-Tests-Playground' with: 'a MCLazyVersionInfo(GT-Tests-Playground-StefanReichhart.4)'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version313: spec [
	<version: '3.13' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Stable version for Pharo 5.0.'.
		spec author: 'JurajKubelka'.
		spec timestamp: '7/14/2016 13:48'.
		spec project: 'GTInspectorCore' with: '3.17'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-DenisKudryashov.124';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version31: spec [
	<version: '3.1' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.12'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/20/2016 00:11'.
		spec project: 'GTInspectorCore' with: '3.1'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-TudorGirba.119';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version32: spec [
	<version: '3.2' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools version 3.13'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/23/2016 17:57'.
		spec project: 'GTInspectorCore' with: '3.2'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-TudorGirba.119';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version33: spec [
	<version: '3.3' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.14'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/28/2016 12:11'.
		spec project: 'GTInspectorCore' with: '3.3'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AliakseiSyrel.122';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version34: spec [
	<version: '3.4' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools Version 3.15'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/17/2016 10:49'.
		spec project: 'GTInspectorCore' with: '3.4'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AliakseiSyrel.122';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version35: spec [
	<version: '3.5' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.16'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/23/2016 14:21'.
		spec project: 'GTInspectorCore' with: '3.5'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AliakseiSyrel.122';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version36: spec [
	<version: '3.6' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.17'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/29/2016 23:44'.
		spec project: 'GTInspectorCore' with: '3.6'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AliakseiSyrel.123';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version37: spec [
	<version: '3.7' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.18'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/8/2016 10:36'.
		spec project: 'GTInspectorCore' with: '3.7'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-AliakseiSyrel.123';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version38: spec [
	<version: '3.8' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.19'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/14/2016 13:57'.
		spec project: 'GTInspectorCore' with: '3.8'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-DenisKudryashov.124';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]

{ #category : #versions }
ConfigurationOfGTPlaygroundCore >> version39: spec [
	<version: '3.9' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.20 (case 18022)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/18/2016 22:57'.
		spec project: 'GTInspectorCore' with: '3.9'.
		spec 
			package: 'GT-Playground' with: 'GT-Playground-DenisKudryashov.124';
			package: 'GT-Tests-Playground' with: 'GT-Tests-Playground-StefanReichhart.4'. ].

]
