"
GTInspectorTagFilterStrategy implements a filtering strategy for presentations based on tags.

A tag is defined as the parameter of the prama <gtInspectorTag:>. A method can have one or more tags.
The filter returns true for a method if that method contains at least a tag selected in the filter. To be taken into account during filtering a tag must be first added to the filter and the selected. Only tags that have been first added can be selected.  

If a method does not define any tags the filter threats that method as having a single tag stored in the #defaultTag instance variable. The default defaultTag is #custom. The #basic tag  groups the Raw and Meta presentations. Inspect 'GTInspectorTagFilterStrategy new allPragmasWithTag' to view all pragmas creating the tags.
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

{ #category : #examples }
GTInspectorTagFilterStrategy class >> exampleBasicInspector [
	"An inspector showing only the basic presentations Raw and Meta for all object."
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorTagFilterStrategy new
		addAndSelectTag: #basic).
	inspector openOn: Morph new.
]

{ #category : #examples }
GTInspectorTagFilterStrategy class >> exampleCustomInspector [
	"An inspector showing only the custom presentations for all object (excluding Raw and Meta)."
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorTagFilterStrategy new
		defaultTag: #custom;
		addAndSelectTag: #custom).
	inspector openOn: Morph new.
]

{ #category : #examples }
GTInspectorTagFilterStrategy class >> exampleExampleBrowser [
	"A browser for viewing examples"
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorTagFilterStrategy new
		addAndSelectTag: #examples).
	inspector openOn: Dictionary.
]

{ #category : #examples }
GTInspectorTagFilterStrategy class >> exampleFullInspector [
	"An inspector showing all the available presentations for all objects."
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorTagFilterStrategy new
		defaultTag: #custom;
		addAndSelectTag: #custom;
		addAndSelectAllTags).
	inspector openOn: Morph new.
]

{ #category : #adding }
GTInspectorTagFilterStrategy >> addAllTags [
	
	self allTags do: [ :aTag | self addTag: allTags ] 
]

{ #category : #adding }
GTInspectorTagFilterStrategy >> addAndSelectAllTags [
	
	self allTags do: [ :aTag | self addAndSelectTag: aTag ] 
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

	^ (self allPragmasWithTag collect: [ :pragma | 
		pragma argumentAt: 1 ]) asSet sorted: [ :a :b | a < b ]
]

{ #category : #accessing }
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

{ #category : #callbacks }
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
