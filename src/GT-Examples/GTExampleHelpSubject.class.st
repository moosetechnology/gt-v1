Class {
	#name : #GTExampleHelpSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'bookName',
		'title',
		'topic'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleHelpSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self bookName = anExampleSubject bookName 
			and: [ self title = anExampleSubject title ] ]
]

{ #category : #accessing }
GTExampleHelpSubject >> bookName [
	^ bookName
]

{ #category : #accessing }
GTExampleHelpSubject >> bookName: anObject [
	bookName := anObject
]

{ #category : #private }
GTExampleHelpSubject >> ensure [
	self bookName ifNotNil: [ 
		CustomHelp withAllSubclassesDo: [ :class | 
			class asHelpTopic ifNotNil: [ :help |
				(help title = self bookName
						and: [ self title isNil 
							or: [ help subtopics anySatisfy: [ :subhelp | 
									subhelp title = self title ] ] ]) ifTrue: [ 
					topic := help ] ] ] ]
]

{ #category : #testing }
GTExampleHelpSubject >> exists [
	^ self topic notNil
]

{ #category : #UI }
GTExampleHelpSubject >> forNautilus: aBlock [
	aBlock 
		value: #'Open help ' ,  self topic gtDisplayString , (self title ifNotNil: [ ' > ', self title ] ifNil: [ '' ])
		value: [ 
			| browser |
			browser := (HelpBrowser openOn: self topic).
			self title ifNotNil: [ browser selectTopicSatisfying: [ :subhelp | subhelp title = self title ] ] ]
]

{ #category : #testing }
GTExampleHelpSubject >> hasLiteralThorough: aLiteral [
	^ self topic notNil 
		and: [ self topic contents notNil
			and: [ self topic contents includesSubstring: aLiteral asString caseSensitive: false ] ]
]

{ #category : #testing }
GTExampleHelpSubject >> hash [
	^ (self class hash
		bitXor: self bookName hash)
			bitXor: self title hash
]

{ #category : #accessing }
GTExampleHelpSubject >> title [
	^ title
]

{ #category : #accessing }
GTExampleHelpSubject >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GTExampleHelpSubject >> topic [
	self ensure.
	^ topic
]

{ #category : #accessing }
GTExampleHelpSubject >> topic: anObject [
	topic := anObject
]
