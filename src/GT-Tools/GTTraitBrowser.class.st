"
self open.
"
Class {
	#name : #GTTraitBrowser,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'GT-Tools-Prototypes'
}

{ #category : #'initialize-release' }
GTTraitBrowser class >> open [
	^ self new
		open;
		yourself
]

{ #category : #'building-presentations' }
GTTraitBrowser >> allMethodsIn: constructor [
	^ constructor list
		title: 'all';
		display: [:classOrTrait | classOrTrait allSelectors];
		tags: [:selector :classOrTrait |
					(classOrTrait includesLocalSelector: selector) 
						ifTrue: [{'local'}] ifFalse: [
					(classOrTrait includesSelector: selector)
								ifTrue: [{'trait'}] ifFalse: [
					{(classOrTrait whichClassIncludesSelector: selector) name}]]];
		sorted
	
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build1Browser [
	| tabulator |
	tabulator := (GLMTabulator new)
		row: #finder;
		row: #traitComposition size: 20;
		row: #source;
		yourself.
	tabulator title: [ :classOrTrait | classOrTrait name ].
	(tabulator transmit)
		to: #finder;
		andShow: [ :a | a custom: self build2Finder ].
	(tabulator transmit)
		from: #finder;
		to: #traitComposition;
		andShow: [ :a | self classOrTraitNameIn: a ].
	(tabulator transmit)
		from: #finder;
		to: #source;
		andShow: [ :a | a text ].
	(tabulator transmit)
		passivelyFrom: #finder port: #selection;
		from: #finder port: #method;
		to: #source;
		andShow: [ :a | self methodSourceIn: a ].
	(tabulator transmit)
		from: #finder;
		to: #source.
	^ tabulator
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build2Finder [
	| finder |
	finder := GLMFinder new.
	finder fixedSizePanes: 2.
	finder show: [ :a | a custom: self build3Stacker ].
	finder transmit fromOutsidePort: #entity; toOutsidePort: #selection.
	^ finder
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build3Stacker [
	| stacker |
	stacker := GLMStacker new.
	stacker
		aPane: #methods;
		aPane: #hierarchy;
		aPane: #traits.
	(stacker transmit)
		to: #methods;
		andShow: [ :a | 
					a title: 'methods'.
					self localMethodsIn: a.
					self allMethodsIn: a ].
	(stacker transmit)
		to: #hierarchy;
		whenKindOf: Class;
		andShow: [ :a | self hierarchyIn: a ].
	(stacker transmit)
		to: #traits;
		when: [:classOrTrait | classOrTrait traitComposition notEmpty];
		andShow: [ :a | self traitsIn: a ].
	(stacker transmit)
		from: #hierarchy;
		toOutsidePort: #selection.
	(stacker transmit)
		from: #traits;
		toOutsidePort: #selection.
	(stacker transmit)
		from: #methods port: #localSelectors;
		toOutsidePort: #method.
	^ stacker
]

{ #category : #'building-presentations' }
GTTraitBrowser >> classOrTraitNameIn: constructor [
	^ constructor label
		display: [:classOrTraitName | classOrTraitName name, ': ', classOrTraitName traitComposition printString]
	
	
	
]

{ #category : #'building-presentations' }
GTTraitBrowser >> hierarchyIn: constructor [
	constructor title: 'hierarchy'.
	^ constructor list
		whenKindOf: Class;
		display: [:class | class allSuperclasses]
]

{ #category : #'building-presentations' }
GTTraitBrowser >> localMethodsIn: constructor [
	^ constructor list
		title: 'local';
		display: [:class | class localSelectors];
		send: #yourself as: #localSelectors;
		sorted
	
]

{ #category : #'building-presentations' }
GTTraitBrowser >> methodSourceIn: constructor [
	^ (constructor text)
		forSmalltalk: [:class | class];
		display: [ :classOrTrait :selector | [classOrTrait sourceCodeAt: selector]
											on: Error
											do: ['Error: ', classOrTrait name, '>>', selector] ]
]

{ #category : #'initialize-release' }
GTTraitBrowser >> open [
	browser := self build1Browser.
	browser openOn: NSCollectionStream 
	
]

{ #category : #'building-presentations' }
GTTraitBrowser >> traitsIn: constructor [
	constructor title: 'traits'.
	^ constructor list
		display: #traits
]
