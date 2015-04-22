Class {
	#name : #GTOUsers,
	#superclass : #Object,
	#instVars : [
		'users'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'as yet unclassified' }
GTOUsers >> add: aGTOUser [ 
	^ self users add: aGTOUser
]

{ #category : #'as yet unclassified' }
GTOUsers >> online: aGTOUser [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
GTOUsers >> online: aGTOUser since: aDateAndTime [ 
	self 
		user: aGTOUser
		ifPresent: [ :aUser | aUser onlineSince: aDateAndTime ]
		ifAbsent: [ (self add: aGTOUser) onlineSince: aDateAndTime ]
]

{ #category : #'as yet unclassified' }
GTOUsers >> user: aGTOUser ifPresent: presentBlock ifAbsent: absentBlock [ 
	self users
		detect: [ :eachUser | eachUser = aGTOUser ] 
		ifFound: presentBlock
		ifNone: absentBlock
]

{ #category : #'as yet unclassified' }
GTOUsers >> users [
	^ users ifNil: [ users := OrderedCollection new ]
]
