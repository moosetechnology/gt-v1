"
ConfigurationOfGTSpotter loadDevelopment
"
Class {
	#name : #ConfigurationOfGTSpotter,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGTSpotter
}

{ #category : #'development support' }
ConfigurationOfGTSpotter class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGTSpotter class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGTSpotter class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGTSpotter class >> ensureMetacelloBaseConfiguration [

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
ConfigurationOfGTSpotter class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGTSpotter class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGTSpotter class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGTSpotter class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGTSpotter class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGTSpotter class >> validate [
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
ConfigurationOfGTSpotter >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'first shot'.
		spec author: 'TudorGirba'.
		spec timestamp: '2014-11-27'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec 
			package: 'GT-Spotter' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-SpotterExtensions-Core' with: [
				spec requires: #('GT-Spotter' 'GlamourCore' ). ].
		
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec 
			group: 'Core' with: #('GT-Spotter' 'GT-SpotterExtensions-Core' );
			group: 'Tests' with: #('GT-Spotter' );
			group: 'default' with: #('Core') ]
]

{ #category : #baselines }
ConfigurationOfGTSpotter >> baseline11: spec [
	<version: '1.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'GT-Spotter-EventRecorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '2015-02-28'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec 
			package: 'GT-Spotter' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-Spotter-EventRecorder' with: [
				spec requires: #('GT-Spotter' ). ];
			package: 'GT-SpotterExtensions-Core' with: [
				spec requires: #('GT-Spotter' 'GlamourCore' ). ].
		
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec 
			group: 'Core' with: #('GT-Spotter' 'GT-SpotterExtensions-Core' );
			group: 'Tests' with: #('GT-Spotter' );
			group: 'default' with: #('Core' 'GT-Spotter-EventRecorder') ]
]

{ #category : #baselines }
ConfigurationOfGTSpotter >> baseline12: spec [
	<version: '1.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'GT-Tests-Spotter'.
		spec author: 'AndreiChis'.
		spec timestamp: '2015-03-20'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec 
			package: 'GT-Spotter' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-Spotter-EventRecorder' with: [
				spec requires: #('GT-Spotter' ). ];
			package: 'GT-SpotterExtensions-Core' with: [
				spec requires: #('GT-Spotter' 'GlamourCore' ) ];
			package: 'GT-Tests-Spotter' with: [
				spec requires: #('GT-Spotter' 'GT-SpotterExtensions-Core' ) ].
		
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].
		
		spec 
			group: 'Core' with: #('GT-Spotter' 'GT-SpotterExtensions-Core' );
			group: 'Tests' with: #('GT-Spotter' 'GT-Tests-Spotter');
			group: 'default' with: #('Core' 'Tests' 'GT-Spotter-EventRecorder') ]
]

{ #category : #baselines }
ConfigurationOfGTSpotter >> baseline13: spec [
	<version: '1.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'It depends on GT-EventRecorder.'.
		spec author: 'JurajKubelka'.
		spec timestamp: '2015-10-15'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/'.
		
		spec 
			package: 'GT-Spotter' with: [
				spec requires: #('GlamourCore' ). ];
			package: 'GT-Spotter-EventRecorder' with: [
				spec requires: #('GT-Spotter' 'GTEventRecorder' ). ];
			package: 'GT-SpotterExtensions-Core' with: [
				spec requires: #('GT-Spotter' 'GlamourCore' ) ];
			package: 'GT-Tests-Spotter' with: [
				spec requires: #('GT-Spotter' 'GT-SpotterExtensions-Core' ) ].
		
		spec 
			project: 'GlamourCore' with: [
				spec
					className: #ConfigurationOfGlamourCore;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main/' ].

		spec 
			project: 'GTEventRecorder' with: [
				spec
					className: #ConfigurationOfGTEventRecorder;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		
		spec 
			group: 'Core' with: #('GT-Spotter' 'GT-SpotterExtensions-Core' );
			group: 'Tests' with: #('GT-Spotter' 'GT-Tests-Spotter');
			group: 'default' with: #('Core' 'Tests' 'GT-Spotter-EventRecorder') ]
]

{ #category : #accessing }
ConfigurationOfGTSpotter >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGTSpotter >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.2-baseline'.

	spec for: #'pharo3.x' version: '1.0.4'.

	spec for: #'pharo4.x' version: '1.2-baseline'.

	spec for: #'pharo5.x' version: '1.3-baseline'.

]

{ #category : #accessing }
ConfigurationOfGTSpotter >> project [

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
ConfigurationOfGTSpotter >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.2.15'.

	spec for: #'pharo3.x' version: '1.0.4'.

	spec for: #'pharo4.x' version: '1.2.4'.

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version100: spec [
	<version: '1.0.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/07/2014 14:48'.
		
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AliakseiSyrel.61';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.21'.
		spec 
			project: 'GlamourCore' with: '3.0.4'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version101: spec [
	<version: '1.0.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 13:38'.
		
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AliakseiSyrel.64';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-TudorGirba.22'.
		spec 
			project: 'GlamourCore' with: '3.0.5'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version102: spec [
	<version: '1.0.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.2'.
		spec author: 'TudorGirba'.
		spec timestamp: '12/23/2014 14:10'.
		spec project: 'GlamourCore' with: '3.0.6'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-TudorGirba.70';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AliakseiSyrel.30'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version103: spec [
	<version: '1.0.3' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.3'.
		spec author: 'TudorGirba'.
		spec timestamp: '12/28/2014 14:10'.
		spec project: 'GlamourCore' with: '3.0.6'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AliakseiSyrel.75';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AliakseiSyrel.30'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version104: spec [
	<version: '1.0.4' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.4 for Pharo 3.0'.
		spec author: 'TudorGirba'.
		spec timestamp: '1/04/2014 11:10'.
		spec project: 'GlamourCore' with: '3.0.7'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AliakseiSyrel.75';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AliakseiSyrel.30'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version105: spec [
	<version: '1.0.5' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/07/2014 17:49'.
		spec project: 'GlamourCore' with: '3.0.8'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AliakseiSyrel.76';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AliakseiSyrel.30'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version106: spec [
	<version: '1.0.6' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/08/2014 21:45'.
		spec project: 'GlamourCore' with: '3.0.9'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AliakseiSyrel.77';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.34'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version107: spec [
	<version: '1.0.7' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/16/2015 19:13'.
		spec project: 'GlamourCore' with: '3.0.10'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-TudorGirba.86';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.37' ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version120: spec [
	<version: '1.2.0' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/08/2015 21:57'.
		spec project: 'GlamourCore' with: '3.1.0'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-TudorGirba.305';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.85';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.138';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-StefanReichhart.7' ].
]

{ #category : #versions }
ConfigurationOfGTSpotter >> version1210: spec [
	<version: '1.2.10' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.10'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/1/2015 15:31'.
		spec project: 'GlamourCore' with: '3.1.10'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AndreiChis.318';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-YuriyTymchuk.94';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-MarcusDenker.156';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version1211: spec [
	<version: '1.2.11' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.11'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/2/2015 14:36'.
		spec project: 'GlamourCore' with: '3.1.10'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AndreiChis.318';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.96';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-MarcusDenker.156';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version1212: spec [
	<version: '1.2.12' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.12'.
		spec author: 'CyrilFerlicot'.
		spec timestamp: '9/11/2015 20:43'.
		spec project: 'GlamourCore' with: '3.1.10'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-CyrilFerlicot.321';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.96';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-MarcusDenker.156';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version1213: spec [
	<version: '1.2.13' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'cleanup before remove ThemeIcons'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10/2/2015 16:11'.
		spec project: 'GlamourCore' with: '3.2.3'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-CyrilFerlicot.321';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.96';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-EstebanLorenzano.157';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version1214: spec [
	<version: '1.2.14' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfixes'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/8/2015 21:24'.
		spec project: 'GlamourCore' with: '3.2.4'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-CyrilFerlicot.321';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-MarcusDenker.97';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-EstebanLorenzano.157';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version1215: spec [
	<version: '1.2.15' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfixes'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/15/2015 16:22'.
		spec project: 'GlamourCore' with: '3.2.5'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AndreiChis.325';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-MarcusDenker.97';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.166';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version121: spec [
	<version: '1.2.1' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/11/2015 16:55'.
		spec project: 'GlamourCore' with: '3.1.1'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-StefanReichhart.307';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.89';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-TudorGirba.141';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8' ].
]

{ #category : #versions }
ConfigurationOfGTSpotter >> version122: spec [
	<version: '1.2.2' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/29/2015 11:09'.
		spec project: 'GlamourCore' with: '3.1.2'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-StefanReichhart.307';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.89';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-TudorGirba.142';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8' ].
]

{ #category : #versions }
ConfigurationOfGTSpotter >> version123: spec [
	<version: '1.2.3' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Replace Announcer>>#on:send:to:''s senders with Announcer>>#when:send:to: in the following methods

GTSpotterCategoryTitleBrick>>#stepModel: 
GTSpotterMorph>>#initializeListeners'.
		spec author: 'BernardoContreras'.
		spec timestamp: '5/2/2015 18:48'.
		spec project: 'GlamourCore' with: '3.1.2'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-BernardoContreras.308';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.89';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-TudorGirba.142';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version124: spec [
	<version: '1.2.4' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'merged with Pharo + fixed RPackage>>spotterActDefault'.
		spec author: 'AndreiChis'.
		spec timestamp: '5/7/2015 15:29'.
		spec project: 'GlamourCore' with: '3.1.3'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-BernardoContreras.308';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.89';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.146';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version125: spec [
	<version: '1.2.5' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.5'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '6/4/2015 19:49'.
		spec project: 'GlamourCore' with: '3.2-baseline'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-StephaneDucasse.309';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.89';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.146';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version126: spec [
	<version: '1.2.6' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'spotter dive into class from senders/implementors result list'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '6/17/2015 12:04'.
		spec project: 'GlamourCore' with: '3.1.4'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-StephaneDucasse.309';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-JurajKubelka.89';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-NicolaiHess.147';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version127: spec [
	<version: '1.2.7' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/1/2015 14:25'.
		spec project: 'GlamourCore' with: '3.1.7'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-NicolaiHess.310';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-AndreiChis.92';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-NicolaiHess.148';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-TudorGirba.8'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version128: spec [
	<version: '1.2.8' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/3/2015 13:54'.
		spec project: 'GlamourCore' with: '3.1.8'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AndreiChis.315';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-AndreiChis.92';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-AndreiChis.152';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]

{ #category : #versions }
ConfigurationOfGTSpotter >> version129: spec [
	<version: '1.2.9' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2.9'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/12/2015 15:31'.
		spec project: 'GlamourCore' with: '3.1.9'.
		spec 
			package: 'GT-Spotter' with: 'GT-Spotter-AndreiChis.318';
			package: 'GT-Spotter-EventRecorder' with: 'GT-Spotter-EventRecorder-AndreiChis.92';
			package: 'GT-SpotterExtensions-Core' with: 'GT-SpotterExtensions-Core-TorstenBergmann.154';
			package: 'GT-Tests-Spotter' with: 'GT-Tests-Spotter-AndreiChis.9'. ].

]
