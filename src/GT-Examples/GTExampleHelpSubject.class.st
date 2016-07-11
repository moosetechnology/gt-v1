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
GTExampleHelpSubject >> ensureInitialized [
	self bookName ifNil: [ ^ self ].

	CustomHelp withAllSubclassesDo: [ :class | 
		class asHelpTopic ifNotNil: [ :help |
			(help title = bookName
					and: [ title isNil 
						or: [ help subtopics anySatisfy: [ :subhelp | 
								subhelp title = title ] ] ]) ifTrue: [ 
				topic := help ] ] ]
]

{ #category : #testing }
GTExampleHelpSubject >> exists [
	^ self topic notNil
]

{ #category : #UI }
GTExampleHelpSubject >> forNautilus: aBlock [
	aBlock 
		value: #'Browse subject Help ' ,  self topic gtDisplayString , (self title ifNotNil: [ ' > ', self title ] ifNil: [ '' ])
		value: [ 
			| browser |
			browser := (HelpBrowser openOn: self topic).
			self title ifNotNil: [ browser selectTopicSatisfying: [ :subhelp | subhelp title = self title ] ] ]
]

{ #category : #UI }
GTExampleHelpSubject >> gtDisplayOn: aStream [
	self topic gtDisplayOn: aStream
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
	^ topic
]

{ #category : #accessing }
GTExampleHelpSubject >> topic: anObject [
	topic := anObject
]
