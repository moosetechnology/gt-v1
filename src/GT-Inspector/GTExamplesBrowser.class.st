"
A simple browser showing the list of examples for a given class.
"
Class {
	#name : #GTExamplesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTExamplesBrowser >> compose [
	self title: 'E.g.'.
	self when: [ :each | (self examplesFor: each) notEmpty ].
	self list
		display: [ :each | self examplesFor: each ]
]

{ #category : #private }
GTExamplesBrowser >> examplesFor: anObject [
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtExample 
				in: anObject class.
	^ pragmas collect: [ :eachPragma | anObject perform: eachPragma selector ]

]
