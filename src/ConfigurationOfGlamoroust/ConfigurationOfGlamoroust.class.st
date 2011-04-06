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
		(Smalltalk at: #ConfigurationOfMetacello) project latestVersion load: #('default' 'UI') ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGlamoroust class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamoroust class >> loadDefault [
	(self project version: 'default') load
]

{ #category : #accessing }
ConfigurationOfGlamoroust class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGlamoroust >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/glamoroust'.
		spec 
			package: 'SystemAnnouncements' with: [
				spec repository: 'http://www.squeaksource.com/PharoTaskForces'];
			package: 'GT-Model' with: [spec requires: #('RPackage')];
			package: 'GT-Tools' with: [ spec requires: #('GT-Model' 'Glamour' 'Mondrian' 'MondrianGraphVizLayout') ];
			package: 'GT-Inspector' with: [ spec requires: #('Glamour')];
			package: 'GT-Debugger' with: [ spec requires: #('Glamour')];
			package: 'GT-Coder' with: [ spec requires: #('Glamour')];
			package: 'GT-Playground' with: [ spec requires: #('Glamour')].			.			.
			
		spec project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: 'default';
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec project: 'RPackage' with: [
				spec
					className: 'ConfigurationOfRPackage';
					file: 'ConfigurationOfRPackage';
					version: 'default';
					repository: 'http://www.squeaksource.com/PharoTaskForces' ].
		spec project: 'Mondrian' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
		spec package: 'MondrianGraphVizLayout' with: [ spec repository: 'http://www.squeaksource.com/Mondrian' ].
		spec package: 'Glamour-Morphic-Theme' with: [ spec repository: 'http://www.squeaksource.com/Glamour' ]
	]
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
