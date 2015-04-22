Class {
	#name : #GTOUser,
	#superclass : #Object,
	#instVars : [
		'name',
		'options'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'as yet unclassified' }
GTOUser class >> named: aString [ 
	^ self new name: aString; yourself
]

{ #category : #'as yet unclassified' }
GTOUser >> isOnline [
	^ self optionAt: #isOnline ifAbsent: [ false ]
]

{ #category : #'as yet unclassified' }
GTOUser >> name: aString [ 
	name := aString
]

{ #category : #'as yet unclassified' }
GTOUser >> onlineSince: aDateAndTime [ 
	self optionAt: #onlineSince put: aDateAndTime
]

{ #category : #'as yet unclassified' }
GTOUser >> optionAt: aSymbol ifAbsent: aBlockClosure [ 
	options ifNil: [ ^ aBlockClosure value ].
	^ options at: aSymbol ifAbsent: aBlockClosure 
]

{ #category : #'as yet unclassified' }
GTOUser >> optionAt: aSymbol put: anObject [ 
	options ifNil: [ options := Dictionary new ].
	^ options at: aSymbol put: anObject
]
