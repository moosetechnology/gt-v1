Class {
	#name : #GTMetacellerTestCase,
	#superclass : #TestCase,
	#instVars : [
		'testConfigurationClass'
	],
	#category : #'GT-Metaceller-Tests'
}

{ #category : #setUp }
GTMetacellerTestCase >> createBaseline01 [
	testConfigurationClass
		compile: 'baseline01: aSpec
	<version: ''0.1-baseline''>
	aSpec for: #common do: [ 
		aSpec blessing: #''baseline''.
		aSpec description: ''Just a testDescription''.
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
					file: ''ConfigurationOfGlamour'';
					version: #development;
					loads: #(''Core'');
					repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ].
		aSpec package: ''GT-Metaceller-Glamour'' with: [ 
			aSpec requires: #( ''GlamourCore'' ) ] ].

	aSpec for: #pharo do: [ 
		aSpec project: ''GlamourTools'' with: [
				aSpec
					className: ''ConfigurationOfGToolkit'';
					file: ''ConfigurationOfGToolkit'';
					version: #development;
					loads: #( ''GT-Inspector'' );
					repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ].
		aSpec package: ''GT-Metaceller-Glamour'' with: [ 
			aSpec requires: #( ''GlamourTools'' ) ] ]' classified: 'baselines'.
	testConfigurationClass
		compile: 'development: spec
	<symbolicVersion: #development>
	spec for: #common version: ''0.1-baseline''' classified: 'symbolicVersions'.
	testConfigurationClass
		compile: 'version01: aSpec
	<version: ''0.1'' imports: #( ''0.1-baseline'')>
	aSpec for: #''common'' do: [ 
		aSpec blessing: #''development''.
		aSpec description: ''Just the development branch, so no version specified for now.''.
		aSpec author: ''Diego Lont'' ]' classified: 'versions'
]

{ #category : #setUp }
GTMetacellerTestCase >> createTestConfigurationClass [
	testConfigurationClass := Object
		subclass: #ConfigurationOfTestForMetaceller
		instanceVariableNames: 'project'
		classVariableNames: ''
		poolDictionaries: ''
		category: 'Snapshotcello-Tests'.
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
GTMetacellerTestCase >> setUp [
	self createTestConfigurationClass.
	self createBaseline01.
]

{ #category : #setUp }
GTMetacellerTestCase >> tearDown [
	testConfigurationClass removeFromSystem
]
