"
inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorTagFilterStrategy new
			defaultTag: #custom;
			addAndSelectTag: #custom).
inspector openOn: Morph new.

inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorTagFilterStrategy new
			defaultTag: #custom;
			addTag: #custom;
			addAndSelectTag: #basic).
inspector openOn: Morph new.

inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorTagFilterStrategy new
			defaultTag: #custom;
			addAndSelectTag: #basic;
			addAndSelectTag: #custom).
inspector openOn: Morph new.
"
Class {
	#name : #GTInspectorTagFilterStrategy,
	#superclass : #GTInspectorPresentationFilterStrategy,
	#instVars : [
		'allTags',
		'selectedTags',
		'defaultTag'
	],
	#category : #'GT-Inspector'
}

{ #category : #adding }
GTInspectorTagFilterStrategy >> addAllTags [
	
	self allTags do: [ :aTag | self addTag: allTags ] 
]

{ #category : #adding }
GTInspectorTagFilterStrategy >> addAndSelectAllTags [
	
	self allTags do: [ :aTag | self addAndSelectTag: allTags ] 
]

{ #category : #adding }
GTInspectorTagFilterStrategy >> addAndSelectTag: aSymbol [

	self addTag: aSymbol.
	(selectedTags includes: aSymbol) ifFalse:  [selectedTags add: aSymbol]
]

{ #category : #adding }
GTInspectorTagFilterStrategy >> addTag: aSymbol [

	(allTags includes: aSymbol) ifFalse:  [allTags add: aSymbol].
]

{ #category : #accessing }
GTInspectorTagFilterStrategy >> allPragmasWithTag [

	^ PragmaCollector allSystemPragmas select: [ :pragma | pragma key == self tagPragmaKey ]
]

{ #category : #accessing }
GTInspectorTagFilterStrategy >> allTags [

	^ (self allPragmasWithTag collect: [ :pragma | pragma argumentAt: 1 ]) asSet sorted: [ :a :b | a < b ]
]

{ #category : #'as yet unclassified' }
GTInspectorTagFilterStrategy >> changeFilterRequestFor: aGTInspector [

	self
		openListChooseLabeled: 'All available tags' 
		forInspector: aGTInspector
		with: allTags 
		select: selectedTags 
		format: #printString
		actionSelector: #replaceSelectedTagsWith:in:

]

{ #category : #accessing }
GTInspectorTagFilterStrategy >> defaultTag: aSymbol [

	defaultTag := aSymbol
]

{ #category : #initialization }
GTInspectorTagFilterStrategy >> initialize [
	super initialize.
	
	allTags := OrderedCollection new.
	selectedTags := OrderedCollection new.
	defaultTag := #custom
]

{ #category : #'as yet unclassified' }
GTInspectorTagFilterStrategy >> replaceSelectedTagsWith: aListOfSymbols in: aGTInspector [

	selectedTags := aListOfSymbols.
	aGTInspector update.
]

{ #category : #testing }
GTInspectorTagFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	^ (self tagsFrom: aMethod) includesAny: selectedTags
]

{ #category : #accessing }
GTInspectorTagFilterStrategy >> tagPragmaKey [

	^ #gtInspectorTag:
]

{ #category : #accessing }
GTInspectorTagFilterStrategy >> tagsFrom: aMethod [

	^ (aMethod pragmas select: [ :each | each key == self tagPragmaKey ])
		ifEmpty: [ defaultTag ifNil: [ {} ] ifNotNil: [ {defaultTag} ] ]
		ifNotEmpty: [ :currentPragmas | currentPragmas collect: [ :each | each argumentAt: 1 ] ]
]
