"
ConfigurationOfGlamoroust loadDevelopment
"
Class {
	#name : #ConfigurationOfGlamoroust,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfGlamoroust
}

{ #category : #private }
ConfigurationOfGlamoroust class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) project latestVersion load: #('default') ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGlamoroust class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamoroust class >> loadDefault [
	"this will be deprecated soon"
	self loadDevelopment
]

{ #category : #loading }
ConfigurationOfGlamoroust class >> loadDevelopment [
	(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGlamoroust class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGlamoroust >> baseline01: spec [ 
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
ConfigurationOfGlamoroust >> baseline02: spec [ 
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
ConfigurationOfGlamoroust >> baseline03: spec [ 
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
ConfigurationOfGlamoroust >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.3-baseline'
]

{ #category : #accessing }
ConfigurationOfGlamoroust >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
