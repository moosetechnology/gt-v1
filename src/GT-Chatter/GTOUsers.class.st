Class {
	#name : #GTOUsers,
	#superclass : #Object,
	#instVars : [
		'users'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #adding }
GTOUsers >> add: aGTOUser [ 
	^ self users add: aGTOUser
]

{ #category : #enumerating }
GTOUsers >> online: aGTOUser since: aDateAndTime [ 
	self 
		user: aGTOUser
		ifFound: [ :aUser | aUser onlineSince: aDateAndTime ]
		ifNone: [ (self add: aGTOUser) onlineSince: aDateAndTime ]
]

{ #category : #enumerating }
GTOUsers >> user: aGTOUser ifFound: presentBlock ifNone: absentBlock [ 
	self users
		detect: [ :eachUser | eachUser = aGTOUser ] 
		ifFound: presentBlock
		ifNone: absentBlock
]

{ #category : #accessing }
GTOUsers >> users [
	"Private. Use it only for test cases."
	^ users ifNil: [ users := OrderedCollection new ]
]
