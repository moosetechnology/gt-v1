Class {
	#name : #GTExampleNautilusAction,
	#superclass : #AbstractMethodIconAction,
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleNautilusAction class >> iconForMethod: aCompiledMethod [
	^ MethodWidget methodsIconsCache 
		at: aCompiledMethod 
		ifAbsent: [ self iconForMethod: aCompiledMethod result: nil ]
]

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

{ #category : #private }
GTExampleNautilusAction class >> methodUpdated: aCompiledMethod with: aResult [
	[	MethodWidget methodsIconsCache 
			at: aCompiledMethod 
			put: (self iconForMethod: aCompiledMethod result: aResult). 
		NautilusUI allSubInstances do: #updateCategoryAndMethodList ]
			on: Error
			do: [ " ignore and continue " ]
]

{ #category : #order }
GTExampleNautilusAction >> actionOrder [
	"Return the priority of this action"
	
	^ 0
]

{ #category : #order }
GTExampleNautilusAction >> isActionHandled [
	^ method isGTExampleMethod
]

{ #category : #order }
GTExampleNautilusAction >> privateActionIcon [
	"Return the icon for this action"
	^ IconicButton new
		target: self;
		actionSelector: #run:;
		arguments: { method };
		labelGraphic: (self class iconForMethod: method);
		color: Color transparent;
		helpText: 'Run';
		extent: 12 @ 12;
		borderWidth: 0
]

{ #category : #order }
GTExampleNautilusAction >> run: aCompiledMethod [
	aCompiledMethod gtExample ifNotNil: [ :example | 
		example run isSuccess ifFalse: [ example debug ] ]
]
