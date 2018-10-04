Class {
	#name : #GTExampleHelpSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'bookName',
		'title',
		'topic'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleHelpSubject class >> fromBook: aString [
	^ self fromBook: aString title: nil
]

{ #category : #'instance creation' }
GTExampleHelpSubject class >> fromBook: aString1 title: aString2 [
	^ self new 
		bookName: aString1;
		title: aString2;
		yourself
]

{ #category : #'instance creation' }
GTExampleHelpSubject class >> fromTopic: aHelpTopic [
	^ self fromBook: aHelpTopic title title: (aHelpTopic subtopics 
		ifNotEmpty: [ :topics | topics first title ]
		ifEmpty: [ nil ])
]

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

{ #category : #testing }
GTExampleHelpSubject >> exists [
	^ self topic notNil
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

{ #category : #private }
GTExampleHelpSubject >> resetStub [
	topic := nil.
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
	topic ifNil: [ 
		CustomHelp withAllSubclassesDo: [ :class | 
			class asHelpTopic ifNotNil: [ :help |
				(help title = bookName
						and: [ title isNil 
							or: [ help subtopics anySatisfy: [ :subhelp | 
									subhelp title = title ] ] ]) ifTrue: [ 
					topic := help ] ] ] ].
	^ topic
]

{ #category : #accessing }
GTExampleHelpSubject >> topic: anObject [
	topic := anObject
]
