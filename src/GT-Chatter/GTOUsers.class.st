Class {
	#name : #GTOUsers,
	#superclass : #Object,
	#instVars : [
		'users',
		'chatter'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #adding }
GTOUsers >> add: aGTOUser [ 
	^ self users add: aGTOUser
]

{ #category : #accessing }
GTOUsers >> chatter [
	^ chatter
]

{ #category : #accessing }
GTOUsers >> chatter: anObject [
	chatter := anObject
]

{ #category : #'as yet unclassified' }
GTOUsers >> first [
	^ self users first
]

{ #category : #'as yet unclassified' }
GTOUsers >> isNotEmpty [
	^ self users isNotEmpty
]

{ #category : #enumerating }
GTOUsers >> online: aGTOUserSign since: aDateAndTime [ 
	self 
		user: aGTOUserSign
		ifFound: [ :aUser | aUser onlineSince: aDateAndTime ]
		ifNone: [ (self add: (GTORemoteUser named: aGTOUserSign)) 
							chatter: self chatter;
							onlineSince: aDateAndTime ]
]

{ #category : #enumerating }
GTOUsers >> user: aGTOUserSign ifFound: presentBlock ifNone: absentBlock [ 
	self users
		detect: [ :eachUser | eachUser sign = aGTOUserSign ] 
		ifFound: presentBlock
		ifNone: absentBlock
]

{ #category : #accessing }
GTOUsers >> users [
	"Private. Use it only for test cases."
	^ users ifNil: [ users := OrderedCollection new ]
]
