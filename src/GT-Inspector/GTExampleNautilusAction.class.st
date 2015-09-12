Class {
	#name : #GTExampleNautilusAction,
	#superclass : #AbstractMethodIconAction,
	#category : #'GT-Inspector-Examples-UI'
}

{ #category : #order }
GTExampleNautilusAction >> actionOrder [
	"Return the priority of this action"
	
	^ 0
]

{ #category : #private }
GTExampleNautilusAction >> iconForMethod: aCompiledMethod [
	| result |
	(result := self resultForMethod: aCompiledMethod)
		ifNil: [ ^ Smalltalk ui icons iconNamed: #testNotRunIcon ].
	result isSuccess
		ifTrue: [ ^ Smalltalk ui icons iconNamed: #testGreenIcon ].
	result isFailure
		ifTrue: [ ^ Smalltalk ui icons iconNamed: #testYellowIcon ].
	result isError
		ifTrue: [ ^ Smalltalk ui icons iconNamed: #testRedIcon ].
	^ Smalltalk ui icons iconNamed: #testNotRunIcon
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
		ifNotEmpty: [ :examples | examples first result ]
		ifEmpty: [ nil ]
]

{ #category : #order }
GTExampleNautilusAction >> run: aCompiledMethod [
	(self resultForMethod: aCompiledMethod)
		ifNotNil: [ :result | result run; debug ]
]
