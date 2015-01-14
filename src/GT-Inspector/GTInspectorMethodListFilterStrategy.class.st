"
GTInspectorMethodListFilterStrategy implements a filtering strategy for presentations based on method signatures (method selector and class).

The filter returns true for a method if the signature of that method is selected in the filter. To be taken into account during filtering a signature must be first added to the filter and the selected. Only signatures that have been first added can be selected. 
"
Class {
	#name : #GTInspectorMethodListFilterStrategy,
	#superclass : #GTInspectorPresentationFilterStrategy,
	#instVars : [
		'allMethodSignatures',
		'selectedMethodSignatures'
	],
	#category : #'GT-Inspector'
}

{ #category : #examples }
GTInspectorMethodListFilterStrategy class >> exampleASTBrowser [
	"An inspector showing a browser for navigating through AST nodes."
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorMethodListFilterStrategy new
		addAndSelectSignatureFor: CompiledMethod>>#gtInspectorASTIn:;
		addAndSelectSignatureFor: RBProgramNode>>#gtInspectorSourceCodeIn:).
	inspector openOn: Morph>>#initialize.
]

{ #category : #examples }
GTInspectorMethodListFilterStrategy class >> exampleCodeBrowser [
	"An inspector showing only the Meta presentation for all objects"
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorMethodListFilterStrategy new
		addAndSelectSignatureFor: Object>>#gtInspectorMetaIn:).
	inspector openOn: Morph new.
]

{ #category : #examples }
GTInspectorMethodListFilterStrategy class >> exampleFileBrowser [
	"An inspector for browsing directories and files."
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorMethodListFilterStrategy new
		addAndSelectSignatureFor: FileReference>>#gtInspectorStScriptIn:;
		addAndSelectSignatureFor: FileReference>>#gtInspectorPngIn:;
		addAndSelectSignatureFor: FileReference>>#gtInspectorJpegIn:;
		addAndSelectSignatureFor: FileReference>>#gtInspectorItemsIn:;
		addAndSelectSignatureFor: FileReference>>#gtInspectorGifIn:;
		addAndSelectSignatureFor: FileReference>>#gtInspectorContentsIn:;
		addAndSelectSignatureFor: FileReference>>#gtInspectorFuelIn:).
	inspector openOn: FileSystem workingDirectory.
]

{ #category : #examples }
GTInspectorMethodListFilterStrategy class >> exampleFullInspector [
	"An inspector showing all presentations for all objects"
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorMethodListFilterStrategy new
		addAndSelectAllSignatures).
	inspector openOn: Morph new.
]

{ #category : #examples }
GTInspectorMethodListFilterStrategy class >> exampleRawInspector [
	"An inspector showing only the Raw presentation for all objects"
	|inspector|
	
	inspector := GTInspector new.
	inspector presentationFilter: (GTInspectorMethodListFilterStrategy new
		addAndSelectSignatureFor: Object>>#gtInspectorRawIn:).
	inspector openOn: Morph new.
]

{ #category : #adding }
GTInspectorMethodListFilterStrategy >> addAllSignatures [
	
	self allPresentationMethods do: [ :aMethod | self addSignatureFor: aMethod ] 
]

{ #category : #adding }
GTInspectorMethodListFilterStrategy >> addAndSelectAllSignatures [
	
	self allPresentationMethods do: [ :aMethod | self addAndSelectSignatureFor: aMethod ] 
]

{ #category : #adding }
GTInspectorMethodListFilterStrategy >> addAndSelectSignatureFor: aMethod [
	|signature|
	
	signature := self signatureFor: aMethod.
	(allMethodSignatures includes: signature) ifFalse: [ allMethodSignatures add: signature ].
	(selectedMethodSignatures includes: signature) ifFalse: [ selectedMethodSignatures add: signature ].
	
]

{ #category : #adding }
GTInspectorMethodListFilterStrategy >> addSignatureFor: aMethod [
	|signature|
	
	signature := self signatureFor: aMethod.
	(allMethodSignatures includes: signature) ifFalse: [ allMethodSignatures add: signature ].
]

{ #category : #accessing }
GTInspectorMethodListFilterStrategy >> allPresentationMethods [

	^ (PragmaCollector allSystemPragmas select: [ :pragma | 
		pragma key == self inspectorPragmaKey ]) collect: [ :aPragma | aPragma method ]
]

{ #category : #accessing }
GTInspectorMethodListFilterStrategy >> changeFilterRequestFor: aGTInspector [

	self
		openListChooseLabeled: 'All available presentations' 
		forInspector: aGTInspector
		with: allMethodSignatures 
		select: selectedMethodSignatures 
		format: [ :aSignature | self printSignature: aSignature ]
		actionSelector: #replaceSelectedSignaturesWith:in:
]

{ #category : #initialization }
GTInspectorMethodListFilterStrategy >> initialize [
	super initialize.
	allMethodSignatures := OrderedCollection new.
	selectedMethodSignatures := OrderedCollection new.
]

{ #category : #accessing }
GTInspectorMethodListFilterStrategy >> inspectorPragmaKey [

	^ #gtInspectorPresentationOrder:
]

{ #category : #printing }
GTInspectorMethodListFilterStrategy >> printSignature: aSignature [

	^ aSignature first name, '>>', aSignature second asString
]

{ #category : #callbacks }
GTInspectorMethodListFilterStrategy >> replaceSelectedSignaturesWith: aList in: aGTInspector [

	selectedMethodSignatures := aList.
	aGTInspector update
]

{ #category : #testing }
GTInspectorMethodListFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	^ selectedMethodSignatures anySatisfy: [ :aSignature | 
		aSignature first = aMethod methodClass and: [ aSignature second = aMethod selector ] ]
]

{ #category : #accessing }
GTInspectorMethodListFilterStrategy >> signatureFor: aMethod [

	^ {aMethod methodClass . aMethod selector}
]
