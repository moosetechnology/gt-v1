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

	spec for: #'common' version: '0.6-baseline'.
	spec for: #'pharo3.x' version: '0.9-baseline'
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

	spec for: #'pharo2.x' version: '0.7-snapshot'.

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
