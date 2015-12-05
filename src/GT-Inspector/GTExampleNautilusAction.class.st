Class {
	#name : #GTExampleNautilusAction,
	#superclass : #AbstractMethodIconAction,
	#category : #'GT-Inspector-Examples-UI'
}

{ #category : #private }
GTExampleNautilusAction class >> iconForMethod: aCompiledMethod result: aResult [
	aResult
		ifNil: [ ^ Smalltalk ui icons iconNamed: #testNotRunIcon ].
	aResult isSuccess
		ifTrue: [ ^ Smalltalk ui icons iconNamed: #testGreenIcon ].
	aResult isFailure
		ifTrue: [ ^ Smalltalk ui icons iconNamed: #testYellowIcon ].
	aResult isError
		ifTrue: [ ^ Smalltalk ui icons iconNamed: #testRedIcon ].
	^ Smalltalk ui icons iconNamed: #testNotRunIcon
]

{ #category : #order }
GTExampleNautilusAction >> actionOrder [
	"Return the priority of this action"
	
	^ 0
]

{ #category : #private }
GTExampleNautilusAction >> iconForMethod: aCompiledMethod [
	^ self class iconForMethod: aCompiledMethod result: (self resultForMethod: aCompiledMethod)
]

{ #category : #order }
GTExampleNautilusAction >> isActionHandled [
	^ method pragmas anySatisfy: [ :each | each isGTExamplePragma ]
]

{ #category : #order }
GTExampleNautilusAction >> privateActionIcon [
	"Return the icon for this action"
	^ IconicButton new
		target: self;
		actionSelector: #run:;
		arguments: { method };
		labelGraphic: (self iconForMethod: method);
		color: Color transparent;
		helpText: 'Run';
		extent: 12 @ 12;
		borderWidth: 0
]

{ #category : #private }
GTExampleNautilusAction >> resultForMethod: aCompiledMethod [
	^ aCompiledMethod gtExamples 
		ifNotEmpty: [ :examples | examples first resultCached ]
		ifEmpty: [ nil ]
]

{ #category : #order }
GTExampleNautilusAction >> run: aCompiledMethod [
	aCompiledMethod gtExamples do: [ :example | 
		example run isSuccess ifFalse: [ example debug ] ]
]
