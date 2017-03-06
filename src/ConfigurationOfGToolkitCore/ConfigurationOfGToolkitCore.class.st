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

{ #category : #baselines }
ConfigurationOfGToolkitCore >> baseline31: spec [
	<version: '3.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec author: 'AndreiChis'.
		spec description: 'Load GTDebugger'.
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
				
		spec project: 'GTDebugger' with: [
				spec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		
		spec group: 'default' with: #(
			'GTPlaygroundCore' 
			'GTInspectorCore' 
			'GTSpotter' 
			'GTDebugger' ). ].

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

	spec for: #'common' version: '3.1-baseline'.

	spec for: #'pharo3.x' version: '3.0-baseline'.

	spec for: #'pharo4.x' version: '3.0.2'.

	spec for: #'pharo5.x' version: '3.25'.

	spec for: #'pharo6.x' version: '3.1-baseline'.

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

	spec for: #'common' version: '3.36'.

	spec for: #'pharo4.x' version: '3.0.2'.

	spec for: #'pharo5.x' version: '3.25'.

	spec for: #'pharo6.x' version: '3.35'.

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

{ #category : #versions }
ConfigurationOfGToolkitCore >> version302: spec [
	<version: '3.0.2' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/29/2015 11:13'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.2'. 
		spec project: 'GTInspectorCore' with: '2.0.13'.
		spec project: 'GTSpotter' with: '1.2.2'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version303: spec [
	<version: '3.0.3' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/1/2015 14:26'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.6'. 
		spec project: 'GTInspectorCore' with: '2.0.16'.
		spec project: 'GTSpotter' with: '1.2.7'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version304: spec [
	<version: '3.0.4' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/10/2015 17:31'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.7'. 
		spec project: 'GTInspectorCore' with: '2.0.17'.
		spec project: 'GTSpotter' with: '1.2.8'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version305: spec [
	<version: '3.0.5' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/12/2015 15:33'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.8'. 
		spec project: 'GTInspectorCore' with: '2.0.18'.
		spec project: 'GTSpotter' with: '1.2.9'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version306: spec [
	<version: '3.0.6' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.6'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/1/2015 15:33'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.9'. 
		spec project: 'GTInspectorCore' with: '2.0.19'.
		spec project: 'GTSpotter' with: '1.2.10'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version307: spec [
	<version: '3.0.7' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/2/2015 14:37'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.9'. 
		spec project: 'GTInspectorCore' with: '2.0.19'.
		spec project: 'GTSpotter' with: '1.2.11'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version308: spec [
	<version: '3.0.8' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/15/2015 16:24'.
		
		spec project: 'GTPlaygroundCore' with: '2.1.11'. 
		spec project: 'GTInspectorCore' with: '2.0.22'.
		spec project: 'GTSpotter' with: '1.2.15'. ]
	

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version310: spec [
	<version: '3.10' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.10'.
		spec author: 'AndreiChis'.
		spec timestamp: '02/08/2016 15:54'.
		spec 
			project: 'GTPlaygroundCore' with: '2.10';
			project: 'GTInspectorCore' with: '2.9';
			project: 'GTSpotter' with: '1.12';
			project: 'GTDebugger' with: '1.6'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version311: spec [
	<version: '3.11' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools version 3.11'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/18/2016 14:21'.
		spec 
			project: 'GTPlaygroundCore' with: '3.0';
			project: 'GTInspectorCore' with: '3.0';
			project: 'GTSpotter' with: '2.0';
			project: 'GTDebugger' with: '2.0'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version312: spec [
	<version: '3.12' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.12'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/20/2016 00:11'.
		spec 
			project: 'GTPlaygroundCore' with: '3.1';
			project: 'GTInspectorCore' with: '3.1';
			project: 'GTSpotter' with: '2.1';
			project: 'GTDebugger' with: '2.1'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version313: spec [
	<version: '3.13' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools version 3.13'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/23/2016 17:57'.
		spec 
			project: 'GTPlaygroundCore' with: '3.2';
			project: 'GTInspectorCore' with: '3.2';
			project: 'GTSpotter' with: '2.2';
			project: 'GTDebugger' with: '2.1'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version314: spec [
	<version: '3.14' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.14'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/28/2016 12:11'.
		spec 
			project: 'GTPlaygroundCore' with: '3.3';
			project: 'GTInspectorCore' with: '3.3';
			project: 'GTSpotter' with: '2.3';
			project: 'GTDebugger' with: '2.2'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version315: spec [
	<version: '3.15' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GTools Version 3.15'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/17/2016 10:50'.
		spec 
			project: 'GTPlaygroundCore' with: '3.4';
			project: 'GTInspectorCore' with: '3.4';
			project: 'GTSpotter' with: '2.4';
			project: 'GTDebugger' with: '2.3'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version316: spec [
	<version: '3.16' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.16'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/23/2016 14:22'.
		spec 
			project: 'GTPlaygroundCore' with: '3.5';
			project: 'GTInspectorCore' with: '3.5';
			project: 'GTSpotter' with: '2.5';
			project: 'GTDebugger' with: '2.4'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version317: spec [
	<version: '3.17' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.17'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/29/2016 23:44'.
		spec 
			project: 'GTPlaygroundCore' with: '3.6';
			project: 'GTInspectorCore' with: '3.6';
			project: 'GTSpotter' with: '2.6';
			project: 'GTDebugger' with: '2.5'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version318: spec [
	<version: '3.18' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.18'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/8/2016 10:36'.
		spec 
			project: 'GTPlaygroundCore' with: '3.7';
			project: 'GTInspectorCore' with: '3.7';
			project: 'GTSpotter' with: '2.7';
			project: 'GTDebugger' with: '2.6'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version319: spec [
	<version: '3.19' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.19'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/14/2016 13:57'.
		spec 
			project: 'GTPlaygroundCore' with: '3.8';
			project: 'GTInspectorCore' with: '3.8';
			project: 'GTSpotter' with: '2.8';
			project: 'GTDebugger' with: '2.7'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version31: spec [
	<version: '3.1' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Updated GTools: 
  - bug fixes
  - deprecated PluggableTextMorph
  - improved event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/9/2015 14:32'.
		spec 
			project: 'GTPlaygroundCore' with: '2.2';
			project: 'GTInspectorCore' with: '2.1';
			project: 'GTSpotter' with: '1.3'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version320: spec [
	<version: '3.20' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.20 (case 18022)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/18/2016 22:57'.
		spec 
			project: 'GTPlaygroundCore' with: '3.9';
			project: 'GTInspectorCore' with: '3.9';
			project: 'GTSpotter' with: '2.9';
			project: 'GTDebugger' with: '2.8'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version321: spec [
	<version: '3.21' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.21 (case 18112)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/27/2016 19:10'.
		spec 
			project: 'GTPlaygroundCore' with: '3.9';
			project: 'GTInspectorCore' with: '3.12';
			project: 'GTSpotter' with: '2.10';
			project: 'GTDebugger' with: '2.8'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version322: spec [
	<version: '3.22' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.22 (case 17948)'.
		spec author: 'AndreiChis'.
		spec timestamp: '4/28/2016 16:25'.
		spec 
			project: 'GTPlaygroundCore' with: '3.10';
			project: 'GTInspectorCore' with: '3.14';
			project: 'GTSpotter' with: '2.11';
			project: 'GTDebugger' with: '2.9'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version323: spec [
	<version: '3.23' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.23'.
		spec author: 'AndreiChis'.
		spec timestamp: '6/27/2016 12:09'.
		spec 
			project: 'GTPlaygroundCore' with: '3.11';
			project: 'GTInspectorCore' with: '3.15';
			project: 'GTSpotter' with: '2.12';
			project: 'GTDebugger' with: '2.10'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version324: spec [
	<version: '3.24' imports: #('3.1-baseline' )>

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
		spec 
			project: 'GTPlaygroundCore' with: '3.11';
			project: 'GTInspectorCore' with: '3.16';
			project: 'GTSpotter' with: '2.12';
			project: 'GTDebugger' with: '2.10'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version325: spec [
	<version: '3.25' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Stable version for Pharo 5.0.'.
		spec author: 'JurajKubelka'.
		spec timestamp: '7/14/2016 13:48'.
		spec 
			project: 'GTPlaygroundCore' with: '3.13';
			project: 'GTInspectorCore' with: '3.17';
			project: 'GTSpotter' with: '2.14';
			project: 'GTDebugger' with: '2.12'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version326: spec [
	<version: '3.26' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Prevent infinite loop in GLMScrollListBrick>>#preventOverscrolling
 - in some cases it was moving band to the top and to the bottom.'.
		spec author: 'JurajKubelka'.
		spec timestamp: '7/21/2016 18:06'.
		spec 
			project: 'GTPlaygroundCore' with: '3.14';
			project: 'GTInspectorCore' with: '3.18';
			project: 'GTSpotter' with: '2.15';
			project: 'GTDebugger' with: '2.13'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version327: spec [
	<version: '3.27' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.27'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/25/2016 14:40'.
		spec 
			project: 'GTPlaygroundCore' with: '3.15';
			project: 'GTInspectorCore' with: '3.19';
			project: 'GTSpotter' with: '2.16';
			project: 'GTDebugger' with: '3.1'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version328: spec [
	<version: '3.28' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.28'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/22/2016 23:31'.
		spec 
			project: 'GTPlaygroundCore' with: '3.16';
			project: 'GTInspectorCore' with: '3.20';
			project: 'GTSpotter' with: '2.17';
			project: 'GTDebugger' with: '3.2'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version329: spec [
	<version: '3.29' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit Version 3.29'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/4/2016 12:00'.
		spec 
			project: 'GTPlaygroundCore' with: '3.17';
			project: 'GTInspectorCore' with: '3.21';
			project: 'GTSpotter' with: '2.18';
			project: 'GTDebugger' with: '3.3'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version32: spec [
	<version: '3.2' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools. 
 - bug fixes
 - improvements in the event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/19/2015 20:58'.
		spec 
			project: 'GTPlaygroundCore' with: '2.3';
			project: 'GTInspectorCore' with: '2.2';
			project: 'GTSpotter' with: '1.4'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version330: spec [
	<version: '3.30' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.30'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/1/2016 11:15'.
		spec 
			project: 'GTPlaygroundCore' with: '3.18';
			project: 'GTInspectorCore' with: '3.22';
			project: 'GTSpotter' with: '2.20';
			project: 'GTDebugger' with: '3.4'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version331: spec [
	<version: '3.31' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Glamour version 4.28 includes Glamour <--> Spec integration'.
		spec author: 'JurajKubelka'.
		spec timestamp: '12/27/2016 13:19'.
		spec 
			project: 'GTPlaygroundCore' with: '3.19';
			project: 'GTInspectorCore' with: '3.23';
			project: 'GTSpotter' with: '2.21';
			project: 'GTDebugger' with: '3.5'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version332: spec [
	<version: '3.32' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.32'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/27/2016 21:38'.
		spec 
			project: 'GTPlaygroundCore' with: '3.20';
			project: 'GTInspectorCore' with: '3.24';
			project: 'GTSpotter' with: '2.22';
			project: 'GTDebugger' with: '3.6'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version333: spec [
	<version: '3.33' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.33'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/3/2017 18:30'.
		spec 
			project: 'GTPlaygroundCore' with: '3.21';
			project: 'GTInspectorCore' with: '3.25';
			project: 'GTSpotter' with: '2.23';
			project: 'GTDebugger' with: '3.7'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version334: spec [
	<version: '3.34' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.26'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/11/2017 18:13'.
		spec 
			project: 'GTPlaygroundCore' with: '3.22';
			project: 'GTInspectorCore' with: '3.26';
			project: 'GTSpotter' with: '2.24';
			project: 'GTDebugger' with: '3.8'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version335: spec [
	<version: '3.35' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.35'.
		spec author: 'AndreiChis'.
		spec timestamp: '2/20/2017 16:30'.
		spec 
			project: 'GTPlaygroundCore' with: '3.23';
			project: 'GTInspectorCore' with: '3.27';
			project: 'GTSpotter' with: '2.25';
			project: 'GTDebugger' with: '3.9'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version336: spec [
	<version: '3.36' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'GToolkit version 3.36'.
		spec author: 'AndreiChis'.
		spec timestamp: '3/6/2017 14:09'.
		spec 
			project: 'GTPlaygroundCore' with: '3.24';
			project: 'GTInspectorCore' with: '3.28';
			project: 'GTSpotter' with: '2.26';
			project: 'GTDebugger' with: '3.10'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version33: spec [
	<version: '3.3' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Load GTDebugger together with the extensions for SUnit and Bytecode.
Bugfixes (17190, 17206, 17336, 17337, 17225)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/7/2016 10:41'.
		spec 
			project: 'GTPlaygroundCore' with: '2.4';
			project: 'GTInspectorCore' with: '2.3';
			project: 'GTSpotter' with: '1.5';
			project: 'GTDebugger' with: '1.1'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version34: spec [
	<version: '3.4' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.4'.
		spec author: 'JurajKubelka'.
		spec timestamp: '1/7/2016 19:36'.
		spec 
			project: 'GTPlaygroundCore' with: '2.4';
			project: 'GTInspectorCore' with: '2.3';
			project: 'GTSpotter' with: '1.6';
			project: 'GTDebugger' with: '1.1'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version35: spec [
	<version: '3.5' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'This version fixes problems in GTDebugger and updates  Rubric (issues: 17155, 17279, 17152)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/8/2016 19:27'.
		spec 
			project: 'GTPlaygroundCore' with: '2.5';
			project: 'GTInspectorCore' with: '2.4';
			project: 'GTSpotter' with: '1.7';
			project: 'GTDebugger' with: '1.2'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version36: spec [
	<version: '3.6' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Fixes in the debugger, inspector and spotter.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/10/2016 23:53'.
		spec 
			project: 'GTPlaygroundCore' with: '2.6';
			project: 'GTInspectorCore' with: '2.5';
			project: 'GTSpotter' with: '1.8';
			project: 'GTDebugger' with: '1.3'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version37: spec [
	<version: '3.7' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in Spotter and Glamour'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 16:23'.
		spec 
			project: 'GTPlaygroundCore' with: '2.7';
			project: 'GTInspectorCore' with: '2.6';
			project: 'GTSpotter' with: '1.9';
			project: 'GTDebugger' with: '1.3'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version38: spec [
	<version: '3.8' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in inspector and debugger'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 18:15'.
		spec 
			project: 'GTPlaygroundCore' with: '2.8';
			project: 'GTInspectorCore' with: '2.7';
			project: 'GTSpotter' with: '1.10';
			project: 'GTDebugger' with: '1.4'. ].

]

{ #category : #versions }
ConfigurationOfGToolkitCore >> version39: spec [
	<version: '3.9' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes and improvements.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/18/2016 13:24'.
		spec 
			project: 'GTPlaygroundCore' with: '2.9';
			project: 'GTInspectorCore' with: '2.8';
			project: 'GTSpotter' with: '1.11';
			project: 'GTDebugger' with: '1.5'. ].

]
