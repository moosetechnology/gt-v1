"
self loadDevelopment
"
Class {
	#name : #ConfigurationOfGToolkit,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfGToolkit
}

{ #category : #private }
ConfigurationOfGToolkit class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) project latestVersion load: #('default') ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGToolkit class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGToolkit class >> loadDefault [
	"this will be deprecated soon"
	self loadDevelopment
]

{ #category : #loading }
ConfigurationOfGToolkit class >> loadDevelopment [
	(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGToolkit class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline010: aSpec [
	<version: '0.10-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Baseline for Moose 5';
			author: 'DiegoLont';
			timestamp: '2014-04-02';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-Debugger' with: [
				aSpec
					requires: #( 'GT-Inspector' 'NewDebugger') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GT-Debugger') ];
			package: 'GT-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore' 'DeepTraverser') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GT-Inspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GT-Debugger' 'PetitParser') ];
			package: 'GT-Playground' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GT-Debugger') ];
			package: 'GT-Setup';
			package: 'GT-Tests-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'DeepTraverser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfDeepTraverser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
			project: 'GlamourCore' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #( 'Core' 'Core Tests' 'Morphic' 'Roassal' 'Roassal2');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'NewDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfNewDebugger';
					loads: #( 'Core' 'DebuggerExtensions');
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ].
		aSpec
			group: 'ObjectCentricDebugger' with: #( 'GT-ObjectCentricDebugger');
			group: 'Tests' with: #( 'GT-Metaceller-Tests' 'GT-Tests-Inspector');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-Debugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger' 'GT-Inspector');
			group: 'default' with: #( 'GT-Setup' 'GT-Playground' 'GT-Coder' 'GT-Tools' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'GT-Debugger' "'AnnouncerCentricDebugger'" 'GT-PetitParserDebugger' 'GT-Inspector' 'GT-Metaceller-Glamour' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline011: aSpec [
	<version: '0.11-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Baseline for Moose 5';
			author: 'AndreiChis';
			timestamp: '2014-04-03';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore' 'DeepTraverser') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GT-Inspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-Playground' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tests-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'DeepTraverser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfDeepTraverser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
			project: 'GlamourCore' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #( 'Core' 'Core Tests' 'Morphic' 'Roassal' 'Roassal2');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests' 'GT-Tests-Inspector');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-Playground' 'GT-Coder' 'GT-Tools' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-PetitParserDebugger' 'GT-Inspector' 'GT-Metaceller-Glamour' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline012: aSpec [
	<version: '0.12-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'InspectorExtensions';
			author: 'TudorGirba';
			timestamp: '2014-04-25';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore' 'DeepTraverser') ];
			package: 'GT-InspectorExtensions-Core' with: [
				aSpec
					requires: #( 'GT-Inspector') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GT-Inspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-Playground' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tests-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'DeepTraverser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfDeepTraverser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
			project: 'GlamourCore' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #( 'Core' 'Core Tests' 'Morphic' 'Roassal' 'Roassal2');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests' 'GT-Tests-Inspector');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-Playground' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-Inspector' 'GT-InspectorExtensions-Core' 'GT-Metaceller-Glamour' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline013: aSpec [
	<version: '0.13-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'GlamourExtra';
			author: 'AndreiChis';
			timestamp: '2014-08-27';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'GlamourCore' 'GlamourExtras') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore' 'DeepTraverser') ];
			package: 'GT-InspectorExtensions-Core' with: [
				aSpec
					requires: #( 'GT-Inspector' 'GlamourExtras') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GT-Inspector' 'GT-Metaceller-Model' 'GlamourExtras') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-Playground' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tests-Inspector' with: [
				aSpec
					requires: #( 'GlamourCore') ];
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'GlamourCore' 'GlamourExtras') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec group: 'Inspector' with: #(
						'GlamourExtras'
						'GT-Inspector').
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'DeepTraverser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfDeepTraverser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main' ];
			project: 'GlamourCore' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #( 'Core' 'Core Tests' 'Morphic');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'GlamourExtras' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #('CoreExtras' 'Roassal' 'Roassal2');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests' 'GT-Tests-Inspector');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-Playground' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-Inspector' 'GT-InspectorExtensions-Core' 'GT-Metaceller-Glamour' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline014: aSpec [
	<version: '0.14-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'External configurations for GTInspector and GTPlayground';
			author: 'AndreiChis';
			timestamp: '2014-08-28';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GTInspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #( 'Core' 'Core Tests' 'Morphic' 'CoreExtras' 'Roassal' 'Roassal2');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-Metaceller-Glamour' 'GTInspector' 'GTPlayground' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline015: aSpec [
	<version: '0.15-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'External configurations for GTInspector and GTPlayground';
			author: 'AndreiChis';
			timestamp: '2014-08-28';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GTInspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #( 'Core' 'Core Tests' 'Morphic' 'CoreExtras' 'Roassal2');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-Metaceller-Glamour' 'GTInspector' 'GTPlayground' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline016: aSpec [
	<version: '0.16-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Load the nomal glamor configuration';
			author: 'AndreiChis';
			timestamp: '2014-10-29';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GTInspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-Metaceller-Glamour' 'GTInspector' 'GTPlayground' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline017: aSpec [
	<version: '0.17-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Load the Extras group for Glamour';
			author: 'AndreiChis';
			timestamp: '2014-10-29';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GTInspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #('default' 'Extras');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-Metaceller-Glamour' 'GTInspector' 'GTPlayground' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline018: aSpec [
	<version: '0.18-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Fixed GT-PetitParserDebugger';
			author: 'AndreiChis';
			timestamp: '2015-04-02';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Metaceller-Glamour' with: [
				aSpec
					requires: #( 'GTInspector' 'GT-Metaceller-Model') ];
			package: 'GT-Metaceller-Model' with: [
				aSpec
					requires: #( 'GT-Metaceller-Stream') ];
			package: 'GT-Metaceller-Stream';
			package: 'GT-Metaceller-Tests' with: [
				aSpec
					requires: #( 'GT-Metaceller-Model') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					loads: #('default' 'Glamour-Magritte-Presentations');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #( 'GT-Metaceller-Tests');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-PetitParserDebugger' 'GT-Metaceller-Glamour' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests');
			group: 'metaceller' with: #( 'GT-Metaceller-Glamour' 'GT-Metaceller-Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline01: spec [ 
	<version: '0.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/glamoroust'.
		spec 
			package: 'GT-Model' with: [spec requires: #('RPackage')];
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'Glamour') ];
			package: 'GT-Inspector' with: [ spec requires: #('Glamour')];
			package: 'GT-Debugger' with: [ spec requires: #('Glamour')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('Glamour')];
			package: 'GT-Coder' with: [ spec requires: #('Glamour')];
			package: 'GT-Playground' with: [ spec requires: #('Glamour')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('Glamour')].
		spec group: 'Tests' with: #('GT-Tests-Inspector').
		spec project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: 'Core';
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec project: 'RPackage' with: [
				spec
					className: 'ConfigurationOfRPackage';
					file: 'ConfigurationOfRPackage';
					version: #stable;
					repository: 'http://www.squeaksource.com/PharoTaskForces' ].
		spec project: 'RB' with: [
				spec 
					className: 'ConfigurationOfRefactoringBrowser';
					version: #stable;
					file:  'ConfigurationOfRefactoringBrowser';
					repository: 'http://www.squeaksource.com/MetacelloRepository'].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.squeaksource.com/Glamour' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline020: aSpec [
	<version: '0.20-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'removed metaceller';
			author: 'TudorGirba';
			timestamp: '2014-01-05';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #();
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline021: aSpec [
	<version: '0.21-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Added GT-BytecodeDebugger';
			author: 'AndreiChis';
			timestamp: '2015-01-15';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-BytecodeDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #();
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-BytecodeDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-BytecodeDebugger' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline022: aSpec [
	<version: '0.22-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'GT-Tests-Release';
			author: 'AndreiChis';
			timestamp: '2015-03-25';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-BytecodeDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'GT-Tests-Release'.
			
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #('GT-Tests-Release');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-BytecodeDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-BytecodeDebugger' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-PetitParserDebugger' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline023: aSpec [
	<version: '0.23-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Load Roassal';
			author: 'AndreiChis';
			timestamp: '2015-03-25';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'Roassal2') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser') ];
			package: 'GT-BytecodeDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-SUnitDebugger' with: [
				aSpec
					requires: #( 'GTDebugger') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'GT-Tests-Release'.
			
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'Roassal2' with: [
				aSpec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #('GT-Tests-Release');
			group: 'debugger' with: #( 'GT-SUnitDebugger' 'GT-BytecodeDebugger' 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-BytecodeDebugger' 'GT-GlamourDebugger' 'GT-SUnitDebugger' 'AnnouncerCentricDebugger' 'GT-PetitParserDebugger' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests' 'Roassal2') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline024: aSpec [
	<version: '0.24-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Update as GTDebugger is loaded into Pharo 5';
			author: 'AndreiChis';
			timestamp: '2015-12-29';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-DebuggerExtensions' with: [ 
				aSpec
					requires: #(GTDebugger) ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'Roassal2' 'GT-DebuggerExtensions') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser' 'GT-DebuggerExtensions') ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'GT-Tests-Release'.
			
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'Roassal2' with: [
				aSpec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #('GT-Tests-Release');
			group: 'debugger' with: #( 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'AnnouncerCentricDebugger' 'GT-PetitParserDebugger' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests' 'Roassal2') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline025: aSpec [
	<version: '0.25-baseline'>
	aSpec for: #'common' do: [
		aSpec
			blessing: #'baseline';
			description: 'Load the recorder for the debugger';
			author: 'AndreiChis';
			timestamp: '2016-04-03';
			repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		aSpec
			package: 'GT-Coder' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'GT-DebuggerExtensions' with: [ 
				aSpec
					requires: #(GTDebugger) ];
			package: 'GT-GlamourDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'Roassal2' 'GT-DebuggerExtensions') ];
			package: 'GT-PetitParserDebugger' with: [
				aSpec
					requires: #( 'GTDebugger' 'PetitParser' 'GT-DebuggerExtensions') ];
			package: 'GT-Debugger-EventRecorder' with: [ 
				aSpec
					requires: #(GTDebugger GTEventRecorder) ];
			package: 'GT-Setup';
			package: 'GT-Tools' with: [
				aSpec
					requires: #( 'Glamour') ];
			package: 'Glamour-Morphic-Theme' with: [
				aSpec
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			package: 'GT-Tests-Release'.
			
		aSpec
			project: 'AnnouncerCentricDebugger' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					repository: 'http://www.smalltalkhub.com/mc/Moose/AnnouncerCentricDebugger/main' ];
			project: 'Glamour' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfGlamour';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'PetitParser' with: [
				aSpec
					versionString: #'development';
					className: 'ConfigurationOfPetitParser';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			project: 'GTDebugger' with: [
				aSpec
					className: #ConfigurationOfGTDebugger;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTInspector' with: [
				aSpec
					className: #ConfigurationOfGTInspector;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'GTPlayground' with: [
				aSpec
					className: #ConfigurationOfGTPlayground;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];
			project: 'Roassal2' with: [
				aSpec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ];
			project: 'GTSpotter' with: [
				aSpec
					className: #ConfigurationOfGTSpotter;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ]; 
			project: 'GTEventRecorder' with: [
				aSpec
					className: #ConfigurationOfGTEventRecorder;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
			
		aSpec
			group: 'Tests' with: #('GT-Tests-Release');
			group: 'debugger' with: #( 'GT-GlamourDebugger' 'GT-PetitParserDebugger' 'AnnouncerCentricDebugger');
			group: 'default' with: #( 'GT-Setup' 'GT-GlamourDebugger' 'AnnouncerCentricDebugger' 'GT-PetitParserDebugger' 'GT-Debugger-EventRecorder' 'GTInspector' 'GTPlayground' 'GTSpotter' 'Tests' 'Roassal2') ]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline02: spec [ 
	<version: '0.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/glamoroust'.
		spec 
			package: 'GT-Model' with: [spec requires: #('RPackage')];
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore' 'RB')];
			package: 'GT-DebuggerModel';
			package: 'GT-Debugger' with: [ spec requires: #('GlamourCore' 'DebuggerModel' 'GT-Inspector')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Debugger'
			'GT-DebuggerModel'
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic');
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec project: 'RPackage' with: [
				spec
					className: 'ConfigurationOfRPackage';
					file: 'ConfigurationOfRPackage';
					version: #stable;
					repository: 'http://www.squeaksource.com/PharoTaskForces' ].
		spec project: 'RB' with: [
				spec 
					className: 'ConfigurationOfRefactoringBrowser';
					version: #stable;
					file:  'ConfigurationOfRefactoringBrowser';
					repository: 'http://www.squeaksource.com/MetacelloRepository'].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
		spec project: 'DebuggerModel' with: [
			spec
				className: 'ConfigurationOfDebuggerModel';
				version: 'default';
				file: 'ConfigurationOfDebuggerModel';
				repository: 'http://ss3.gemstone.com/ss/DebuggerModel' ].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.squeaksource.com/Glamour' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline03: spec [ 
	<version: '0.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-DebuggerModel';
			package: 'GT-Debugger' with: [ spec requires: #('GlamourCore' 'DebuggerModel' 'GT-Inspector')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Debugger'
			'GT-DebuggerModel'
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
		spec project: 'DebuggerModel' with: [
			spec
				className: 'ConfigurationOfDebuggerModel';
				version: 'default';
				file: 'ConfigurationOfDebuggerModel';
				repository: 'http://ss3.gemstone.com/ss/DebuggerModel' ].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline04: spec [ 
	<version: '0.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Metaceller' with: [ spec requires: #('GT-Inspector')];
			package: 'GT-DebuggerModel';
			package: 'GT-Debugger' with: [ spec requires: #('GlamourCore' 'DebuggerModel' 'GT-Inspector')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Metaceller'
			'GT-Debugger'
			'GT-DebuggerModel'
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
		spec project: 'DebuggerModel' with: [
			spec
				className: 'ConfigurationOfDebuggerModel';
				version: 'default';
				file: 'ConfigurationOfDebuggerModel';
				repository: 'http://ss3.gemstone.com/ss/DebuggerModel' ].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline05: spec [ 
	<version: '0.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Metaceller' with: [ spec requires: #('GT-Inspector')];
			package: 'GT-Debugger' with: [ spec requires: #('GT-Inspector' 'DebuggerActions' 'DebuggerExtensions' 'NewDebugger')];
			package: 'GT-GlamourDebugger' with: [ spec requires: #('GT-Debugger')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Metaceller'
			'GT-Debugger'
			'GT-GlamourDebugger'
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
			'AnnouncerCentricDebugger'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic' 'Roassal');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
		spec project: 'NewDebugger' with: [
				spec
					className: 'ConfigurationOfNewDebugger';
					file: 'ConfigurationOfNewDebugger';
					version: #stable;
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ].
		spec project: 'AnnouncerCentricDebugger' with: [
				spec
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					file: 'ConfigurationOfAnnouncerCentricDebugger';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ].
		spec package: 'DebuggerExtensions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'DebuggerActions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline06: spec [ 
	<version: '0.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Metaceller-Model';
			package: 'GT-Metaceller-Tests' with: [ spec requires: #('GT-Metaceller-Model')];
			package: 'GT-Metaceller-Glamour' with: [ spec requires: #( 'GT-Inspector'  'GT-Metaceller-Model' )];
			package: 'GT-Debugger' with: [ spec requires: #('GT-Inspector' 'DebuggerActions' 'DebuggerExtensions' 'NewDebugger')];
			package: 'GT-GlamourDebugger' with: [ spec requires: #('GT-Debugger')];
			package: 'GT-PetitParserDebugger' with: [ spec requires: #('GT-Debugger' 'PetitParser')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Metaceller-Glamour'
			'GT-Debugger'
			'GT-GlamourDebugger'
			'GT-PetitParserDebugger'
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
			'AnnouncerCentricDebugger'
		).
		spec group: 'metaceller' with: #(
			'GT-Metaceller-Model'
			'GT-Metaceller-Tests' ).
		spec group: 'debugger' with: #(
			'GT-Inspector'
			'GT-Debugger'
			'GT-GlamourDebugger'
			'GT-PetitParserDebugger'
			'AnnouncerCentricDebugger'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector' 'GT-Metaceller-Tests').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic' 'Roassal');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
		spec project: 'NewDebugger' with: [
				spec
					className: 'ConfigurationOfNewDebugger';
					file: 'ConfigurationOfNewDebugger';
					version: #stable;
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Debugger/main' ].
		spec project: 'AnnouncerCentricDebugger' with: [
				spec
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					file: 'ConfigurationOfAnnouncerCentricDebugger';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ].
		spec project: 'PetitParser' with: [
				spec
					className: 'ConfigurationOfPetitParser';
					file: 'ConfigurationOfPetitParser';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ].
		spec package: 'DebuggerExtensions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'DebuggerActions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline07: spec [ 
	<version: '0.7-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Metaceller-Model';
			package: 'GT-Metaceller-Tests' with: [ spec requires: #('GT-Metaceller-Model')];
			package: 'GT-Metaceller-Glamour' with: [ spec requires: #( 'GT-Inspector'  'GT-Metaceller-Model' )];
"			package: 'GT-Debugger' with: [ spec requires: #('GT-Inspector' 'DebuggerActions' 'DebuggerExtensions')];
			package: 'GT-GlamourDebugger' with: [ spec requires: #('GT-Debugger')];
			package: 'GT-PetitParserDebugger' with: [ spec requires: #('GT-Debugger' 'PetitParser')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
"			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Metaceller-Glamour'
"			'GT-Debugger'
			'GT-GlamourDebugger'
			'GT-PetitParserDebugger'"
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
"			'AnnouncerCentricDebugger'"
		).
		spec group: 'metaceller' with: #(
			'GT-Metaceller-Model'
			'GT-Metaceller-Tests' ).
		spec group: 'debugger' with: #(
			'GT-Inspector'
			'GT-Debugger'
			'GT-GlamourDebugger'
			'GT-PetitParserDebugger'
			'AnnouncerCentricDebugger'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector' 'GT-Metaceller-Tests').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic' 'Roassal');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
"		spec project: 'AnnouncerCentricDebugger' with: [
				spec
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					file: 'ConfigurationOfAnnouncerCentricDebugger';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ]."
		spec project: 'PetitParser' with: [
				spec
					className: 'ConfigurationOfPetitParser';
					file: 'ConfigurationOfPetitParser';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ].
"		spec package: 'DebuggerExtensions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'DebuggerActions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main']."
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline08: spec [ 
	<version: '0.8-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Metaceller-Model';
			package: 'GT-Metaceller-Tests' with: [ spec requires: #('GT-Metaceller-Model')];
			package: 'GT-Metaceller-Glamour' with: [ spec requires: #( 'GT-Inspector'  'GT-Metaceller-Model' )];
			package: 'GT-Debugger' with: [ spec requires: #('GT-Inspector' 'DebuggerExtensions')];
			package: 'GT-SUnitDebugger' with: [ spec requires: #('GT-Debugger')];"
			package: 'GT-GlamourDebugger' with: [ spec requires: #('GT-Debugger')];
			package: 'GT-PetitParserDebugger' with: [ spec requires: #('GT-Debugger' 'PetitParser')];
			package: 'GT-ObjectCentricDebugger' with: [ spec requires: #('GT-Debugger' 'Bifrost')];
"			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Metaceller-Glamour'
			'GT-Debugger'
			'GT-SUnitDebugger'
"			'GT-GlamourDebugger'
			'GT-PetitParserDebugger'"
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
"			'AnnouncerCentricDebugger'"
		).
		spec group: 'metaceller' with: #(
			'GT-Metaceller-Model'
			'GT-Metaceller-Tests' ).
		spec group: 'debugger' with: #(
			'GT-Inspector'
			'GT-Debugger'
			'GT-SUnitDebugger'
			'GT-GlamourDebugger'
			'GT-PetitParserDebugger'
			'AnnouncerCentricDebugger'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector' 'GT-Metaceller-Tests').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic' 'Roassal');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'Bifrost' with: [
			spec
				className: 'ConfigurationOfBifrost';
				version: 'default';
				file: 'ConfigurationOfBifrost';
				repository: 'http://www.squeaksource.com/bifrost' ].
"		spec project: 'AnnouncerCentricDebugger' with: [
				spec
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					file: 'ConfigurationOfAnnouncerCentricDebugger';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ]."
		spec project: 'PetitParser' with: [
				spec
					className: 'ConfigurationOfPetitParser';
					file: 'ConfigurationOfPetitParser';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ].
		spec package: 'DebuggerExtensions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGToolkit >> baseline09: spec [ 
	<version: '0.9-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/GToolkit/main'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'GlamourCore') ];
			package: 'GT-Inspector' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Metaceller-Model';
			package: 'GT-Metaceller-Tests' with: [ spec requires: #('GT-Metaceller-Model')];
			package: 'GT-Metaceller-Glamour' with: [ spec requires: #( 'GT-Inspector'  'GT-Metaceller-Model' )];
			package: 'GT-Debugger' with: [ spec requires: #('GT-Inspector' 'DebuggerExtensions')];
			package: 'GT-SUnitDebugger' with: [ spec requires: #('GT-Debugger')];
			package: 'GT-PetitParserDebugger' with: [ spec requires: #('GT-Debugger' 'PetitParser')];
			package: 'GT-GlamourDebugger' with: [ spec requires: #('GT-Debugger')];
			package: 'GT-ClassicCoder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Coder' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Playground' with: [ spec requires: #('GlamourCore')];
			package: 'GT-Tests-Inspector' with: [ spec requires: #('GlamourCore')].
		spec group: 'default' with: #(
			'GT-Model'
			'GT-Tools'
			'GT-Inspector'
			'GT-Metaceller-Glamour'
			'GT-Debugger'
			'GT-SUnitDebugger'
			'GT-PetitParserDebugger'
			'GT-GlamourDebugger'
			'GT-ClassicCoder'
			'GT-Coder'
			'GT-Playground'
			'Tests'
			'AnnouncerCentricDebugger'
		).
		spec group: 'metaceller' with: #(
			'GT-Metaceller-Model'
			'GT-Metaceller-Tests' ).
		spec group: 'debugger' with: #(
			'GT-Inspector'
			'GT-Debugger'
			'GT-SUnitDebugger'
			'GT-PetitParserDebugger'
			'GT-GlamourDebugger'
			'AnnouncerCentricDebugger'
		).
		spec group: 'Tests' with: #('GT-Tests-Inspector' 'GT-Metaceller-Tests').
		spec group: 'ObjectCentricDebugger' with: #(
			'GT-ObjectCentricDebugger').
		spec project: 'GlamourCore' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: #development;
					loads: #('Core' 'Core Tests' 'Morphic' 'Roassal');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ].
		spec project: 'AnnouncerCentricDebugger' with: [
				spec
					className: 'ConfigurationOfAnnouncerCentricDebugger';
					file: 'ConfigurationOfAnnouncerCentricDebugger';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main' ].
		spec project: 'PetitParser' with: [
				spec
					className: 'ConfigurationOfPetitParser';
					file: 'ConfigurationOfPetitParser';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ].
		spec package: 'DebuggerExtensions' with: [ spec repository: 'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main'].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ]
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfGToolkit >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.23-baseline'.

	spec for: #'pharo3.x' version: '0.19'.

	spec for: #'pharo4.x' version: '0.22-baseline'.
	
	spec for: #'pharo5.x' version: '0.25-baseline'.
	
	spec for: #'pharo6.x' version: '0.25-baseline'.

]

{ #category : #snapshots }
ConfigurationOfGToolkit >> populateSpec: aSpec with: list [
	"generated by Snapshotcello
	
	creates a spec object for the package and the version stored in the list"
	
	list do: [:each |
		aSpec package: each third with: [
			aSpec file: (each first  copyUpToLast: $. ).
			aSpec repository: each second ] ]
]

{ #category : #accessing }
ConfigurationOfGToolkit >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]

{ #category : #snapshots }
ConfigurationOfGToolkit >> snapshot1 [
	"generated by Snapshotcello"

	^ #( 
		#('ConfigurationOfGlamour-TudorGirba.117.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'ConfigurationOfGlamour' ) 
		#('ConfigurationOfNewDebugger-AndreiChis.5.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'ConfigurationOfNewDebugger' ) 
		#('ConfigurationOfAnnouncerCentricDebugger-AndreiChis.4.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main/'  'ConfigurationOfAnnouncerCentricDebugger' ) 
		#('ConfigurationOfPetitParser-DiegoLont.40.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'ConfigurationOfPetitParser' ) 
		#('GT-Model-tg.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Model' ) 
		#('ConfigurationOfRoassal-TudorGirba.1186.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'ConfigurationOfRoassal' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.32.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-AndreiChis.256.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-AndreiChis.101.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Tests-Core-AndreiChis.90.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Core' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.68.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-AndreiChis.208.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.78.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tests-Morphic-TudorGirba.108.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Morphic' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.262.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('Glamour-Tests-Resources-AndreiChis.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Resources' ) 
		#('Roassal-AlexandreBergel.668.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.146.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.14.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('GT-Tests-Inspector-TudorGirba.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Tests-Inspector' ) 
		#('GT-Playground-TudorGirba.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Playground' ) 
		#('GT-Coder-TudorGirba.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Coder' ) 
		#('GT-ClassicCoder-TudorGirba.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-ClassicCoder' ) 
		#('GT-Inspector-TudorGirba.85.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Inspector' ) 
		#('GT-Metaceller-DiegoLont.10.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Metaceller' ) 
		#('GT-Tools-TudorGirba.137.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Tools' ) 
		#('DebuggerModel-AndreiChis.22.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'DebuggerModel' ) 
		#('Spec-Debugger-AndreiChis.32.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'Spec-Debugger' ) 
		#('ConfigurationOfNewDebugger-AndreiChis.5.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'ConfigurationOfNewDebugger' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.32.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-AndreiChis.256.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-AndreiChis.101.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Tests-Core-AndreiChis.90.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Core' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.68.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-AndreiChis.208.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.78.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tests-Morphic-TudorGirba.108.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Morphic' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.262.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('Glamour-Tests-Resources-AndreiChis.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Resources' ) 
		#('Roassal-AlexandreBergel.668.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.146.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.14.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('GT-Inspector-TudorGirba.85.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Inspector' ) 
		#('DebuggerModel-AndreiChis.22.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'DebuggerModel' ) 
		#('Spec-Debugger-AndreiChis.32.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'Spec-Debugger' ) 
		#('DebuggerExtensions-AndreiChis.4.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerExtensions' ) 
		#('DebuggerActions-AndreiChis.36.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerActions' ) 
		#('GT-Debugger-AndreiChis.114.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Debugger' ) 
		#('DebuggerModel-AndreiChis.22.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'DebuggerModel' ) 
		#('DebuggerExtensions-AndreiChis.4.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerExtensions' ) 
		#('ACD-Glamour-Interface-AndreiChis.45.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main/'  'ACD-Glamour-Interface' ) 
		#('DebuggerActions-AndreiChis.36.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerActions' ) 
		#('ACD-Model-AndreiChis.32.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main/'  'ACD-Model' ) 
		#('ConfigurationOfGlamour-TudorGirba.117.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'ConfigurationOfGlamour' ) 
		#('PetitParser-YuriyTymchuk.232.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitParser' ) 
		#('PetitTests-AndreHora.47.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitTests' ) 
		#('PetitAnalyzer-DiegoLont.46.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitAnalyzer' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.32.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-AndreiChis.256.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-AndreiChis.101.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.68.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-AndreiChis.208.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.78.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.262.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('Roassal-AlexandreBergel.668.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.146.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.14.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('PetitGui-DiegoLont.125.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitGui' ) 
		#('DebuggerExtensions-AndreiChis.4.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerExtensions' ) 
		#('DebuggerActions-AndreiChis.36.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerActions' ) 
		#('GT-Debugger-AndreiChis.114.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Debugger' ) 
		#('GT-PetitParserDebugger-AndreiChis.33.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-PetitParserDebugger' ) 
		#('GT-GlamourDebugger-AndreiChis.30.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-GlamourDebugger' ) 
	)
]

{ #category : #snapshots }
ConfigurationOfGToolkit >> snapshot2 [
	"generated by Snapshotcello"

	^ #( 
		#('ConfigurationOfGlamour-TudorGirba.123.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'ConfigurationOfGlamour' ) 
		#('ConfigurationOfNewDebugger-AndreiChis.6.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'ConfigurationOfNewDebugger' ) 
		#('ConfigurationOfAnnouncerCentricDebugger-AndreiChis.4.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main/'  'ConfigurationOfAnnouncerCentricDebugger' ) 
		#('ConfigurationOfPetitParser-TudorGirba.43.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'ConfigurationOfPetitParser' ) 
		#('GT-Model-tg.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Model' ) 
		#('GT-Metaceller-Model-DiegoLont.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Metaceller-Model' ) 
		#('GT-Metaceller-Tests-DiegoLont.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Metaceller-Tests' ) 
		#('ConfigurationOfRoassal-TudorGirba.1191.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'ConfigurationOfRoassal' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-TudorGirba.258.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-DiegoLont.103.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Tests-Core-AndreiChis.90.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Core' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.69.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-TudorGirba.211.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.79.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tests-Morphic-TudorGirba.108.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Morphic' ) 
		#('Glamour-Tests-Resources-AndreiChis.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Resources' ) 
		#('Roassal-AlexandreBergel.702.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.165.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('RoassalExtras-RobertoMinelli.26.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalExtras' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.15.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.267.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('GT-Tests-Inspector-TudorGirba.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Tests-Inspector' ) 
		#('GT-Playground-TudorGirba.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Playground' ) 
		#('GT-Coder-TudorGirba.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Coder' ) 
		#('GT-ClassicCoder-TudorGirba.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-ClassicCoder' ) 
		#('GT-Inspector-TudorGirba.88.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Inspector' ) 
		#('GT-Metaceller-Glamour-DiegoLont.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Metaceller-Glamour' ) 
		#('GT-Tools-StephanEggermont.138.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Tools' ) 
		#('DebuggerModel-AndreiChis.22.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'DebuggerModel' ) 
		#('Spec-Debugger-AndreiChis.32.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'Spec-Debugger' ) 
		#('ConfigurationOfNewDebugger-AndreiChis.6.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'ConfigurationOfNewDebugger' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-TudorGirba.258.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-DiegoLont.103.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Tests-Core-AndreiChis.90.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Core' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.69.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-TudorGirba.211.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.79.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tests-Morphic-TudorGirba.108.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Morphic' ) 
		#('Glamour-Tests-Resources-AndreiChis.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Resources' ) 
		#('Roassal-AlexandreBergel.702.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.165.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('RoassalExtras-RobertoMinelli.26.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalExtras' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.15.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.267.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('GT-Inspector-TudorGirba.88.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Inspector' ) 
		#('DebuggerModel-AndreiChis.22.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'DebuggerModel' ) 
		#('Spec-Debugger-AndreiChis.32.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'Spec-Debugger' ) 
		#('DebuggerExtensions-AndreiChis.5.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerExtensions' ) 
		#('DebuggerActions-AndreiChis.39.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerActions' ) 
		#('GT-Debugger-AndreiChis.118.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Debugger' ) 
		#('DebuggerModel-AndreiChis.22.mcz'  'http://www.smalltalkhub.com/mc/Pharo/Debugger/main/'  'DebuggerModel' ) 
		#('DebuggerExtensions-AndreiChis.5.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerExtensions' ) 
		#('ACD-Glamour-Interface-AndreiChis.47.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main/'  'ACD-Glamour-Interface' ) 
		#('DebuggerActions-AndreiChis.39.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerActions' ) 
		#('ACD-Model-AndreiChis.36.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/AnnouncerCentricDebugger/main/'  'ACD-Model' ) 
		#('ConfigurationOfGlamour-TudorGirba.123.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'ConfigurationOfGlamour' ) 
		#('PetitParser-YuriyTymchuk.232.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitParser' ) 
		#('PetitTests-AndreHora.47.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitTests' ) 
		#('PetitAnalyzer-DiegoLont.46.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitAnalyzer' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-TudorGirba.258.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-DiegoLont.103.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.69.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-TudorGirba.211.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.79.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Roassal-AlexandreBergel.702.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.165.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('RoassalExtras-RobertoMinelli.26.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalExtras' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.15.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.267.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('PetitGui-DiegoLont.125.mcz'  'http://www.smalltalkhub.com/mc/Moose/PetitParser/main/'  'PetitGui' ) 
		#('DebuggerExtensions-AndreiChis.5.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerExtensions' ) 
		#('DebuggerActions-AndreiChis.39.mcz'  'http://www.smalltalkhub.com/mc/AndreiChis/Playground/main/'  'DebuggerActions' ) 
		#('GT-Debugger-AndreiChis.118.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-Debugger' ) 
		#('GT-PetitParserDebugger-AndreiChis.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-PetitParserDebugger' ) 
		#('GT-GlamourDebugger-AndreiChis.32.mcz'  'http://www.smalltalkhub.com/mc/Moose/GToolkit/main/'  'GT-GlamourDebugger' ) 
	)
]

{ #category : #'symbolic versions' }
ConfigurationOfGToolkit >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.22'.

	spec for: #'pharo2.x' version: '0.7-snapshot'.

	spec for: #'pharo3.x' version: '0.19'.
	
	spec for: #'pharo4.x' version: '0.22'.

]

{ #category : #versions }
ConfigurationOfGToolkit >> version018: spec [
	<version: '0.18' imports: #('0.18-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 14:11'.
		spec 
			project: 'AnnouncerCentricDebugger' with: #'stable';
			project: 'Glamour' with: #'stable';
			project: 'PetitParser' with: #'stable';
			project: 'GTDebugger' with: #'stable';
			project: 'GTInspector' with: #'stable';
			project: 'GTPlayground' with: #'stable';
			project: 'GTSpotter' with: #'stable'.
		spec 
			package: 'GT-Coder' with: 'GT-Coder-TudorGirba.4';
			package: 'GT-GlamourDebugger' with: 'GT-GlamourDebugger-TudorGirba.41';
			package: 'GT-Metaceller-Glamour' with: 'GT-Metaceller-Glamour-TudorGirba.25';
			package: 'GT-Metaceller-Model' with: 'GT-Metaceller-Model-DiegoLont.47';
			package: 'GT-Metaceller-Stream' with: 'GT-Metaceller-Stream-DiegoLont.7';
			package: 'GT-Metaceller-Tests' with: 'GT-Metaceller-Tests-DiegoLont.20';
			package: 'GT-PetitParserDebugger' with: 'GT-PetitParserDebugger-AndreiChis.44';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.13';
			package: 'GT-Setup' with: 'GT-SUnitDebugger-AndreiChis.13';
			package: 'GT-Tools' with: 'GT-Tools-StephanEggermont.138';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194'].

]

{ #category : #versions }
ConfigurationOfGToolkit >> version019: spec [
	<version: '0.19' imports: #('0.18-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.19'.
		spec author: 'TudorGirba'.
		spec timestamp: '12/23/2014 14:13'.
		spec 
			project: 'AnnouncerCentricDebugger' with: #'stable';
			project: 'Glamour' with: #'stable';
			project: 'PetitParser' with: #'stable';
			project: 'GTDebugger' with: #'stable';
			project: 'GTInspector' with: #'stable';
			project: 'GTPlayground' with: #'stable';
			project: 'GTSpotter' with: #'stable'.
		spec 
			package: 'GT-Coder' with: 'GT-Coder-TudorGirba.4';
			package: 'GT-GlamourDebugger' with: 'GT-GlamourDebugger-TudorGirba.41';
			package: 'GT-Metaceller-Glamour' with: 'GT-Metaceller-Glamour-TudorGirba.25';
			package: 'GT-Metaceller-Model' with: 'GT-Metaceller-Model-DiegoLont.47';
			package: 'GT-Metaceller-Stream' with: 'GT-Metaceller-Stream-DiegoLont.7';
			package: 'GT-Metaceller-Tests' with: 'GT-Metaceller-Tests-DiegoLont.20';
			package: 'GT-PetitParserDebugger' with: 'GT-PetitParserDebugger-AndreiChis.44';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.13';
			package: 'GT-Setup' with: 'GT-Setup-TudorGirba.25';
			package: 'GT-Tools' with: 'GT-Tools-StephanEggermont.138';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194'. ].

]

{ #category : #versions }
ConfigurationOfGToolkit >> version022: spec [
	<version: '0.22' imports: #('0.22-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.22'.
		spec author: 'AndreiChis'.
		spec timestamp: '05/15/2014'.
		spec 
			project: 'AnnouncerCentricDebugger' with: #'stable';
			project: 'Glamour' with: #'stable';
			project: 'PetitParser' with: #'stable';
			project: 'GTDebugger' with: #'stable';
			project: 'GTInspector' with: #'stable';
			project: 'GTPlayground' with: #'stable';
			project: 'GTSpotter' with: #'stable'.
		spec 
			package: 'GT-Coder' with: 'GT-Coder-TudorGirba.4';
			package: 'GT-GlamourDebugger' with: 'GT-GlamourDebugger-AndreiChis.47';
			package: 'GT-PetitParserDebugger' with: 'GT-PetitParserDebugger-AndreiChis.50';
			package: 'GT-BytecodeDebugger' with: 'GT-BytecodeDebugger-AndreiChis.18';
			package: 'GT-SUnitDebugger' with: 'GT-SUnitDebugger-AndreiChis.14';
			package: 'GT-Setup' with: 'GT-Setup-AndreiChis.38';
			package: 'GT-Tools' with: 'GT-Tools-StephanEggermont.138';
			package: 'GT-Tests-Release' with: 'GT-Tests-Release-StefanReichhart.7';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212'. ].

]

{ #category : #'snapshot versions' }
ConfigurationOfGToolkit >> version06snapshot: spec [
	"generated by Snapshotcello"
	<version: '0.6-snapshot'>

	spec for: #common do: [
		self populateSpec: spec with: self snapshot1 ]
]

{ #category : #'snapshot versions' }
ConfigurationOfGToolkit >> version07snapshot: spec [
	"generated by Snapshotcello"
	<version: '0.7-snapshot'>

	spec for: #common do: [
		self populateSpec: spec with: self snapshot2 ]
]
