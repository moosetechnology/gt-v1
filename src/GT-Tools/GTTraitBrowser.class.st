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
	constructor dynamic presentation: [:a :classOrTrait|
		a accordionArrangement.
		(classOrTrait isKindOf: Class)
			ifTrue: [	a tree
						title: 'hierarchy methods';
						display: [classOrTrait allSuperclasses];
						children: [:superclass | (superclass isKindOf: Class) ifTrue: [superclass selectors sorted]]].
		a list
			title: 'trait methods';
			display: [classOrTrait selectors difference: classOrTrait localSelectors];
			sorted
		]
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
		"passive because otherwise we would display the currently selected method for the newly selected class which is likely to not exist"
		passivelyFrom: #finder port: #selection;
		from: #finder port: #method;
		to: #source;
		andShow: [ :a | self methodSourceIn: a ].
	^ tabulator
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build2Finder [
	| finder |
	finder := GLMFinder new.
	finder fixedSizePanes: 2.
	finder show: [ :a | a title: [:classOrTrait | classOrTrait name]; custom: self build3Stacker].
	
	"Simulates a selection on the default entity displayed on the finder"
	finder transmit fromOutsidePort: #entity; toOutsidePort: #selection.
	^ finder
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build3Stacker [
	| stacker |
	stacker := GLMStacker new.
	stacker panes: #(methods hierarchy traits).
	(stacker transmit)
		to: #methods;
		andShow: [ :a | a title: 'methods'.
				a custom: self build4Methods].
	(stacker transmit)
		to: #hierarchy;
		andShow: [ :a | 	a title: 'hierarchy'. self hierarchyIn: a ].
	(stacker transmit)
		to: #traits;
		andShow: [ :a | a title: 'traits'. self traitsIn: a ].
	(stacker transmit)
		from: #hierarchy;
		toOutsidePort: #selection.
	(stacker transmit)
		from: #traits;
		toOutsidePort: #selection.
	(stacker transmit)
		from: #methods;
		toOutsidePort: #method.
	^ stacker
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build3StackerBis [
	| dynamic |
	dynamic := GLMTabulator new row: #stacker; yourself.
	dynamic transmit to: #stacker; andShow: [:a | 
		a dynamic
			display: [:classOrTrait | |stacker|
				self halt.
				stacker := GLMStacker new.
				stacker aPane: #methods.
				(classOrTrait isKindOf: Class)
					ifTrue: [stacker aPane: #hierarchy.
							(stacker transmit)
								to: #hierarchy;
								andShow: [ :c | self hierarchyIn: c].
							(stacker transmit)
								from: #hierarchy;
								toOutsidePort: #selection].
				(classOrTrait traitComposition notEmpty)
					ifTrue: [stacker aPane: #traits.
							(stacker transmit)
								to: #traits;
								andShow: [ :c | self traitsIn: c].
							stacker transmit
								from: #traits;
								toOutsidePort: #selection].
				(stacker transmit)
					to: #methods;
					andShow: [ :c | 
						c title: 'methods'.
						self localMethodsIn: c.
						self allMethodsIn: c].
				(stacker transmit)
					from: #methods port: #localSelectors;
					toOutsidePort: #method.
				stacker]].
	^ dynamic
]

{ #category : #'building-browsers' }
GTTraitBrowser >> build4Methods [
	|stacker|
	stacker := GLMStacker new.
	stacker panes: #(local all).
	stacker transmit to: #local; andShow: [:a | a title: 'local'. self localMethodsIn: a].
	stacker transmit to: #all; andShow: [:a | a title: 'external'. self allMethodsIn: a].
	stacker transmit from: #local; toOutsidePort: #selection.
	^ stacker
]

{ #category : #'building-presentations' }
GTTraitBrowser >> classOrTraitNameIn: constructor [
	^ constructor label
		display: [:classOrTraitName | classOrTraitName name, ': ', classOrTraitName traitComposition printString]
	
	
	
]

{ #category : #'building-presentations' }
GTTraitBrowser >> hierarchyIn: constructor [
	^ constructor list
		whenKindOf: Class;
		display: [:class | class allSuperclasses]
]

{ #category : #'building-presentations' }
GTTraitBrowser >> localMethodsIn: constructor [
	^ constructor list
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
	^ constructor list
		display: #traits
]
