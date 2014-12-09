Class {
	#name : #GTInspectorPragmaFilterStrategy,
	#superclass : #GTInspectorPresentationFilterStrategy,
	#instVars : [
		'defaultPragmaKey',
		'allPragmaKeys',
		'selectedPragmaKeys'
	],
	#category : #'GT-Inspector'
}

{ #category : #adding }
GTInspectorPragmaFilterStrategy >> addPragmaKey: aSymbol [

	allPragmaKeys add: aSymbol.
	selectedPragmaKeys add: aSymbol.
]

{ #category : #'as yet unclassified' }
GTInspectorPragmaFilterStrategy >> changeFilterRequestFor: aGTInspector [
	|treeModel|
	
	treeModel := MorphTreeModel new.
	treeModel
		 beCheckList;
		 rootItems: allPragmaKeys;
		 wrapBlockOrSelector: #printString;
		 autoMultiSelection: true;
		 headerLabel: 'Tags';
		 selectItems: selectedPragmaKeys.
	 (treeModel openDialogWindowIn: World title: 'All available tags' selectedtems: selectedPragmaKeys) ifNotNil: [ :selection | 
		selectedPragmaKeys := selection.
		aGTInspector update ]
]

{ #category : #accessing }
GTInspectorPragmaFilterStrategy >> defaultInspectorPragmaKey: aSymbol [

	defaultPragmaKey := aSymbol
]

{ #category : #initialization }
GTInspectorPragmaFilterStrategy >> initialize [
	super initialize.
	
	allPragmaKeys := OrderedCollection new.
	selectedPragmaKeys := OrderedCollection new.
	defaultPragmaKey := #gtInspectorTagDefault
]

{ #category : #accessing }
GTInspectorPragmaFilterStrategy >> inspectorPragmasFrom: aMethod [

	^ (aMethod pragmas select: [ :each | each key beginsWith: #gtInspectorTag ]) 
		ifEmpty: [ defaultPragmaKey ifNil: [ {  } ] ifNotNil: [ { defaultPragmaKey } ] ]
		ifNotEmpty: [ :currentPragmas | currentPragmas collect: [ :each | each key ] ]
]

{ #category : #testing }
GTInspectorPragmaFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	^ (self inspectorPragmasFrom: aMethod) includesAny: selectedPragmaKeys
]
