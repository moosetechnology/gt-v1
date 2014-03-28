Class {
	#name : #GTMetacellerTestCase,
	#superclass : #TestCase,
	#instVars : [
		'testConfigurationClass'
	],
	#category : #'GT-Metaceller-Tests'
}

{ #category : #setUp }
GTMetacellerTestCase >> createOnSetup [
	^true
]

{ #category : #setUp }
GTMetacellerTestCase >> createTestConfigurationClass [
	testConfigurationClass := Object
		subclass: #ConfigurationOfTestForMetaceller
		instanceVariableNames: 'project'
		classVariableNames: ''
		poolDictionaries: ''
		category: 'GT-ConfigurationOfMetaceller-Tests'.
	testConfigurationClass class
		compile: 'project
	^self new project' classified: 'metacello'.
	testConfigurationClass class
		compile: 'ensureMetacello
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: ''http://seaside.gemtalksystems.com/ss/metacello/'';
				addPackage: ''ConfigurationOfMetacello'';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]' classified: 'metacello'.
	testConfigurationClass class
		compile: 'isMetacelloConfig	
	^true'.
	testConfigurationClass 
		compile: 'project
	^ project ifNil: [ | constructor |
		self class ensureMetacello.
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project ]' classified: 'metacello'.
		
]

{ #category : #setUp }
GTMetacellerTestCase >> createVersion10 [
	testConfigurationClass
		compile: 'baseline10: aSpec
	<version: ''1.0-baseline''>
	aSpec for: #common do: [ 
		aSpec blessing: #''baseline''.
		aSpec description: ''Just a testDescription for the released version''.
		aSpec author: ''Diego Lont''.
		aSpec repository: ''http://smalltalkhub.com/mc/Moose/GToolkit/main''.

		aSpec package: ''GT-Metaceller-Model'';
			package: ''GT-Metaceller-Glamour'' with: [ 
				aSpec requires: #( ''GT-Metaceller-Model'' ) ];
			package: ''GT-Metaceller-Tests'' with: [ 
				aSpec requires: #( ''GT-Metaceller-Model'' ) ].
		aSpec
			group: ''Core'' with: #( ''GT-Metaceller-Model'' );
			group: ''Tests'' with: #( ''GT-Metaceller-Tests'' );
			group: ''Glamour'' with: #( ''GT-Metaceller-Glamour'' );
			group: ''All'' with: #( ''Tests'' ''Glamour'' ) ].
	
	aSpec for: #gemstone do: [ 
		aSpec project: ''GlamourCore'' with: [
				aSpec
					className: ''ConfigurationOfGlamour'';
					version: #development;
					loads: #(''Core'');
					repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ].
		aSpec package: ''GT-Metaceller-Glamour'' with: [ 
			aSpec requires: #( ''GlamourCore'' ) ] ].

	aSpec for: #pharo do: [ 
		aSpec project: ''GlamourTools'' with: [
				aSpec
					className: ''ConfigurationOfGToolkit'';
					version: #development;
					loads: #( ''GT-Inspector'' );
					repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ].
		aSpec package: ''GT-Metaceller-Glamour'' with: [ 
			aSpec requires: #( ''GlamourTools'' ) ] ]' classified: 'baselines'.
	testConfigurationClass
		compile: 'development: spec
	<symbolicVersion: #development>
	spec for: #common version: ''1.0-baseline''' classified: 'symbolicVersions'.
	testConfigurationClass
		compile: 'stable: spec
	<symbolicVersion: #stable>
	spec for: #common version: ''1.0''' classified: 'symbolicVersions'.
	testConfigurationClass
		compile: 'version10: aSpec
	<version: ''1.0'' imports: #( ''1.0-baseline'')>
	aSpec for: #''common'' do: [ 
		aSpec blessing: #''release''.
		aSpec description: ''This is the released version''.
		aSpec author: ''Diego Lont''.
		
		aSpec package: ''GT-Metaceller-Model'' with: ''GT-Metaceller-Model-DiegoLont.22''.
		aSpec package: ''GT-Metaceller-Glamour'' with: ''GT-Metaceller-Glamour-DiegoLont.15''
	].
	aSpec for: #gemstone do: [ 
		aSpec project: ''GlamourCore'' with: ''2.4'' ]' classified: 'versions'
]

{ #category : #setUp }
GTMetacellerTestCase >> createVersion11 [
	testConfigurationClass
		compile: 'baseline11: aSpec
	<version: ''1.1-baseline''>
	aSpec for: #common do: [ 
		aSpec blessing: #''baseline''.
		aSpec description: ''Just a testDescription for the bleeding edge''.
		aSpec repository: ''http://smalltalkhub.com/mc/Moose/GToolkit/main''.

		aSpec package: ''GT-Metaceller-Model'';
			package: ''GT-Metaceller-Glamour'' with: [ 
				aSpec requires: #( ''GT-Metaceller-Model'' ) ];
			package: ''GT-Metaceller-Tests'' with: [ 
				aSpec requires: #( ''GT-Metaceller-Model'' ) ].
		aSpec
			group: ''Core'' with: #( ''GT-Metaceller-Model'' );
			group: ''Tests'' with: #( ''GT-Metaceller-Tests'' );
			group: ''Glamour'' with: #( ''GT-Metaceller-Glamour'' );
			group: ''All'' with: #( ''Tests'' ''Glamour'' ) ].
	
	aSpec for: #gemstone do: [ 
		aSpec project: ''GlamourCore'' with: [
				aSpec
					className: ''ConfigurationOfGlamour'';
					version: #development;
					loads: #(''Core'');
					repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ].
		aSpec package: ''GT-Metaceller-Glamour'' with: [ 
			aSpec requires: #( ''GlamourCore'' ) ] ].

	" Make a typo in the symbol to check handling is case insensitive "
	aSpec for: #pHaRo do: [ 
		aSpec package: ''GT-Metaceller-Typo'' with: [ 
			aSpec requires: ''GT-Metacelller-Glamour'' ] ].

	aSpec for: #pharo do: [ 
		aSpec project: ''GlamourTools'' with: [
				aSpec
					className: ''ConfigurationOfGToolkit'';
					version: #development;
					loads: #( ''GT-Inspector'' );
					repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ].
		aSpec package: ''GT-Metaceller-Glamour'' with: [ 
			aSpec requires: #( ''GlamourTools'' ) ] ]' classified: 'baselines'.
	testConfigurationClass
		compile: 'bleedingEdge: spec
	<symbolicVersion: #bleedingEdge>
	spec for: #common version: ''baseline-1.1''' classified: 'symbolicVersions'.
	testConfigurationClass
		compile: 'development: spec
	<symbolicVersion: #development>
	spec for: #common version: ''1.1''' classified: 'symbolicVersions'.
	testConfigurationClass
		compile: 'version11: aSpec
	<version: ''1.1'' imports: #( ''1.1-baseline'')>
	aSpec for: #''common'' do: [ 
		aSpec blessing: #''development''.
		aSpec description: ''Just the development branch, so no version specified for now.''.
		aSpec author: ''Diego Lont'' ]' classified: 'versions'
]

{ #category : #setUp }
GTMetacellerTestCase >> setUp [
	super setUp.
	self createOnSetup ifTrue: [
		self createTestConfigurationClass.
		self createVersion10.
		self createVersion11 ]
]

{ #category : #setUp }
GTMetacellerTestCase >> tearDown [
	super tearDown.
	testConfigurationClass ifNotNil: [ testConfigurationClass removeFromSystem ]
	

]
