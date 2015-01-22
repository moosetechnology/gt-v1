"
Full configuration of GTInspector for loading into Moose.

self loadDevelopment
"
Class {
	#name : #ConfigurationOfGTInspector,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTInspector
}

{ #category : #'development support' }
ConfigurationOfGTInspector class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTInspector class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTInspector class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTInspector class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGTInspector class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTInspector class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTInspector class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTInspector class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTInspector class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTInspector class >> validate [
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
ConfigurationOfGTInspector >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'Separate configuration for the inspector'.
		spec author: 'AndreiChis'.
		spec timestamp: '2014-08-28'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamour;
					versionString: #'development';
					loads: #('Core' 'Core Tests' 'Morphic' );
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ];
			project: 'GlamourExtras' with: [
				spec
					className: #ConfigurationOfGlamour;
					versionString: #'development';
					loads: #('CoreExtras' 'Roassal' 'Roassal2' );
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ];
			project: 'DeepTraverser' with: [
				spec
					className: #ConfigurationOfDeepTraverser;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ].
		spec 
			package: #'GT-Inspector' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-InspectorExtensions-Core' with: [
				spec requires: #(#'GT-Inspector' 'GlamourCore' ). ];
			package: #'GT-InspectorExtensions-CoreRoassal' with: [
				spec requires: #(#'GT-Inspector' 'GlamourCore' 'GlamourExtras' ). ];
			package: 'GT-Tests-Inspector' with: [
				spec requires: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' ). ].
		spec 
			group: 'Core' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' );
			group: 'Tests' with: #(#'GT-Tests-Inspector' );
			group: 'default' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' #'GT-InspectorExtensions-CoreRoassal' 'GT-Tests-Inspector' 'DeepTraverser' ). ].

]

{ #category : #baselines }
ConfigurationOfGTInspector >> baseline101: spec [
	<version: '1.0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'version 1.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '2014-09-22'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		spec 
			package: #'GT-Inspector' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-InspectorExtensions-Core' with: [
				spec requires: #(#'GT-Inspector' 'GlamourCore' ). ];
			package: 'GT-Tests-Inspector' with: [
				spec requires: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' ). ].
		spec 
			group: 'Core' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' );
			group: 'Tests' with: #(#'GT-Tests-Inspector' );
			group: 'default' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' 'GT-Tests-Inspector'). ].

]

{ #category : #baselines }
ConfigurationOfGTInspector >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'For version 1.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '2014-09-22'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamour;
					versionString: #'development';
					loads: #('Core' 'Core Tests' 'Morphic' );
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		spec 
			package: #'GT-Inspector' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-InspectorExtensions-Core' with: [
				spec requires: #(#'GT-Inspector' 'GlamourCore' ). ];
			package: 'GT-Tests-Inspector' with: [
				spec requires: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' ). ].
		spec 
			group: 'Core' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' );
			group: 'Tests' with: #(#'GT-Tests-Inspector' );
			group: 'default' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' 'GT-Tests-Inspector'). ].

]

{ #category : #baselines }
ConfigurationOfGTInspector >> baseline11: spec [
	<version: '1.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'For version 1.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '2014-09-22'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamour;
					versionString: #'development';
					loads: #('Core' 'Core Tests' 'Morphic' );
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ];
			project: 'GlamourExtras' with: [
				spec
					className: #ConfigurationOfGlamour;
					versionString: #'development';
					loads: #('CoreExtras' 'Roassal2' );
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ];
			project: 'DeepTraverser' with: [
				spec
					className: #ConfigurationOfDeepTraverser;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ].
		spec 
			package: #'GT-Inspector' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-InspectorExtensions-Core' with: [
				spec requires: #(#'GT-Inspector' 'GlamourCore' ). ];
			package: #'GT-InspectorExtensions-CoreRoassal' with: [
				spec requires: #(#'GT-Inspector' 'GlamourCore' 'GlamourExtras' ). ];
			package: 'GT-Tests-Inspector' with: [
				spec requires: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' ). ].
		spec 
			group: 'Core' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' );
			group: 'Tests' with: #(#'GT-Tests-Inspector' );
			group: 'default' with: #(#'GT-Inspector' 'GT-InspectorExtensions-Core' #'GT-InspectorExtensions-CoreRoassal' 'GT-Tests-Inspector' 'DeepTraverser' ). ].

]

{ #category : #baselines }
ConfigurationOfGTInspector >> baseline20: spec [
	<version: '2.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'Use GTInspectorCore'.
		spec author: 'AndreiChis'.
		spec timestamp: '2014-10-29'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: [
				spec requires: #('GTInspectorCore' 'Glamour' ) ].
			
		spec 
			project: 'GTInspectorCore' with: [
				spec
					className: #ConfigurationOfGTInspectorCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'Glamour' with: [
				spec
					className: #ConfigurationOfGlamour;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ];
			project: 'DeepTraverser' with: [
				spec
					className: #ConfigurationOfDeepTraverser;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ].
		
		spec 
			group: 'default' with: #('GT-InspectorExtensions-CoreRoassal' 'DeepTraverser' ) ].

]

{ #category : #accessing }
ConfigurationOfGTInspector >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTInspector >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '2.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTInspector >> project [

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
ConfigurationOfGTInspector >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.0.7'.
	spec for: #'pharo3.x' version: '2.0.5'.

]

{ #category : #versions }
ConfigurationOfGTInspector >> version101: spec [
	<version: '1.0.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 17:11'.
		spec 
			project: 'GlamourCore' with: '2.71'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.239';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.55';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version102: spec [
	<version: '1.0.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 20:55'.
		spec 
			project: 'GlamourCore' with: '2.71'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.239';
			package: 'GT-InspectorExtensions-Core' with: [ 
				spec file: 'GT-InspectorExtensions-Core-AndreiChis.56'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version103: spec [
	<version: '1.0.3' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 14:52'.
		spec 
			project: 'GlamourCore' with: '2.72'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.239';
			package: 'GT-InspectorExtensions-Core' with: [ 
				spec file: 'GT-InspectorExtensions-Core-AndreiChis.56'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version104: spec [
	<version: '1.0.4' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/02/2014 18:16'.
		spec 
			project: 'GlamourCore' with: '2.73'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.239';
			package: 'GT-InspectorExtensions-Core' with: [ 
				spec file: 'GT-InspectorExtensions-Core-AndreiChis.57'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version105: spec [
	<version: '1.0.5' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/03/2014 17:06'.
		spec 
			project: 'GlamourCore' with: '2.74'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.241';
			package: 'GT-InspectorExtensions-Core' with: [ 
				spec file: 'GT-InspectorExtensions-Core-AndreiChis.61'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version106: spec [
	<version: '1.0.6' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.6'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/06/2014 11:42'.
		spec 
			project: 'GlamourCore' with: '2.75'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-AndreiChis.242';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-AndreiChis.63';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version107: spec [
	<version: '1.0.7' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/12/2014 19:56'.
		spec 
			project: 'GlamourCore' with: '2.76'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.249';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-SvenVanCaekenberghe.65';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version108: spec [
	<version: '1.0.8' imports: #('1.0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/28/2014 14:07'.
		spec 
			project: 'GlamourCore' with: '3.0.0'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-AndreiChis.258';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.74';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-AndreiChis.23'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/22/2014 14:38'.
		spec 
			project: 'GlamourCore' with: '2.7'.
		spec 
			package: #'GT-Inspector' with: 'GT-Inspector-TudorGirba.239';
			package: 'GT-InspectorExtensions-Core' with: 'GT-InspectorExtensions-Core-TudorGirba.53';
			package: 'GT-Tests-Inspector' with: 'GT-Tests-Inspector-TudorGirba.22'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version200: spec [
	<version: '2.0.0' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/29/2014 17:01'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.18'.
		spec 
			project: 'GTInspectorCore' with: '2.0.0';
			project: 'Glamour' with: '3.0.0';
			project: 'DeepTraversal' with: '1.0'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version201: spec [
	<version: '2.0.1' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/13/2014 13:54'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.18'.
		spec 
			project: 'GTInspectorCore' with: '2.0.1';
			project: 'Glamour' with: '3.0.1';
			project: 'DeepTraversal' with: '1.0'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version202: spec [
	<version: '2.0.2' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/14/2014 11:48'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.18'.
		spec 
			project: 'GTInspectorCore' with: '2.0.2';
			project: 'Glamour' with: '3.0.2';
			project: 'DeepTraversal' with: '1.0'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version203: spec [
	<version: '2.0.3' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/07/2014 13:58'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.20'.
		spec 
			project: 'GTInspectorCore' with: '2.0.3';
			project: 'Glamour' with: '3.0.3';
			project: 'DeepTraversal' with: '1.0'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version204: spec [
	<version: '2.0.4' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/09/2014 12:08'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.20'.
		spec 
			project: 'GTInspectorCore' with: '2.0.4';
			project: 'Glamour' with: '3.0.4';
			project: 'DeepTraversal' with: '1.0'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version205: spec [
	<version: '2.0.5' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 13:38'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-TudorGirba.20'.
		spec 
			project: 'GTInspectorCore' with: #'stable';
			project: 'Glamour' with: #'stable';
			project: 'DeepTraversal' with: #'stable'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version206: spec [
	<version: '2.0.6' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.6'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/07/2014 15:30'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-AndreiChis.25'.
		spec 
			project: 'GTInspectorCore' with: #'stable';
			project: 'Glamour' with: #'stable';
			project: 'DeepTraversal' with: #'stable'. ].

]

{ #category : #versions }
ConfigurationOfGTInspector >> version207: spec [
	<version: '2.0.7' imports: #('2.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/16/2014 19:11'.
		
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: 'GT-InspectorExtensions-CoreRoassal-AndreiChis.26'.
		spec 
			project: 'GTInspectorCore' with: #'stable';
			project: 'Glamour' with: #'stable';
			project: 'DeepTraversal' with: #'stable'. ].

]
