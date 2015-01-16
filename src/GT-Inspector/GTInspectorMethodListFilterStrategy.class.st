"
inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorMethodListFilterStrategy new
			addAndSelectSignatureFor: Object>>#gtInspectorRawIn:).
inspector openOn: Morph new.

inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorMethodListFilterStrategy new
			addAndSelectSignatureFor: Object>>#gtInspectorMetaIn:).
inspector openOn: Morph new.

inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorMethodListFilterStrategy new
			addAndSelectSignatureFor: Object>>#gtInspectorRawIn:;
			addAndSelectSignatureFor: Object>>#gtInspectorMetaIn:).
inspector openOn: Morph new.

inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorMethodListFilterStrategy new
			addSignatureFor: Object>>#gtInspectorRawIn:;
			addAndSelectSignatureFor: RBProgramNode>>#gtInspectorSourceCodeIn:;
			addAndSelectSignatureFor: CompiledMethod>>#gtInspectorASTIn:).
inspector openOn: Morph>>#initialize.

inspector := GTInspector new.
inspector presentationsFilter: (GTInspectorMethodListFilterStrategy new
			addAndSelectAllSignatures).
inspector openOn: Morph new.
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

{ #category : #'as yet unclassified' }
GTInspectorMethodListFilterStrategy >> printSignature: aSignature [

	^ aSignature first name, '>>', aSignature second asString
]

{ #category : #'as yet unclassified' }
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
