Class {
	#name : #GTAbstractExampleNautilusActionButton,
	#superclass : #AbstractMethodIconAction,
	#classVars : [
		'CurrentAction'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #accessing }
GTAbstractExampleNautilusActionButton class >> currentAction [
	^ CurrentAction ifNil: [ CurrentAction := GTExampleNautilusActionButton ]
]

{ #category : #accessing }
GTAbstractExampleNautilusActionButton class >> currentAction: anObject [
	MethodWidget methodsIconsCache removeAll.
	CurrentAction := anObject
]

{ #category : #private }
GTAbstractExampleNautilusActionButton class >> iconForMethod: aCompiledMethod result: aResult [
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

{ #category : #testing }
GTAbstractExampleNautilusActionButton class >> isAbstract [
	^ self == GTAbstractExampleNautilusActionButton 
]

{ #category : #testing }
GTAbstractExampleNautilusActionButton class >> isEnabled [
	^ self currentAction == self
]

{ #category : #private }
GTAbstractExampleNautilusActionButton class >> methodUpdated: aCompiledMethod with: aResult [
	self currentAction ifNil: [ ^ self ].
	
	[ self currentAction methodUpdated: aCompiledMethod with: aResult ]
		on: Error
		do: [ " ignore " ].
	
	[ NautilusUI allSubInstances do: #updateCategoryAndMethodList ]
		on: Error 
		do: [ " ignore " ]
]

{ #category : #order }
GTAbstractExampleNautilusActionButton >> actionOrder [
	"Return the priority of this action"
	
	^ 0
]

{ #category : #order }
GTAbstractExampleNautilusActionButton >> isActionHandled [
	^ self class isAbstract not 
		and: [ self class isEnabled
			and: [ method isGTExampleMethod ] ]
]
