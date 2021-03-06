Class {
	#name : #GTExampleSubclassesSubject,
	#superclass : #GTExampleClassSubject,
	#category : #'GT-Examples-Subjects'
}

{ #category : #'accessing-dynamic' }
GTExampleSubclassesSubject >> gtExamplesContained [
	| subjects |
	subjects := self theSubclasses collect: [ :each | each asGTExampleSubject ].
	^ Smalltalk gtExamplesContained select: [ :each | 
		(each hasSubject: self)
			or: [ subjects anySatisfy: [ :subject | each hasSubject: subject ] ] ]
]

{ #category : #converting }
GTExampleSubclassesSubject >> gtExamplesSubjects [
	^ super gtExamplesSubjects , (self theSubclasses collect: [ :each | each asGTExampleSubject ])
]

{ #category : #testing }
GTExampleSubclassesSubject >> hasLiteralThorough: aLiteral [
	^ (super hasLiteralThorough: aLiteral)
		or: [ self theSubclasses anySatisfy: [ :class | 
				class asGTExampleSubject hasLiteralThorough: aLiteral ] ]
]

{ #category : #'accessing-dynamic' }
GTExampleSubclassesSubject >> theSubclasses [
	^ self exists 
		ifFalse: [ {  } ]
		ifTrue: [ self theClass allSubclasses ]
]
