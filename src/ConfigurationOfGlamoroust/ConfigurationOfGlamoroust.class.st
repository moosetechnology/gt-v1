Class {
	#name : #ConfigurationOfGlamoroust,
	#superclass : #Object,
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

{ #category : #baselines }
ConfigurationOfGlamoroust >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/glamoroust'.
		spec 
			package: 'GT-Model';
			package: 'GT-Tools' with: [ spec requires: #('GT-Model') ].
		spec project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: 'default';
					repository: 'http://www.squeaksource.com/Glamour' ].
	]
]
