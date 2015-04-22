Class {
	#name : #GTOProxyRegistration,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #cleanup }
GTOProxyRegistration class >> cleanUp [
	self reset
	
]

{ #category : #accessing }
GTOProxyRegistration class >> reset [
	"self reset"
	uniqueInstance := nil
]

{ #category : #'as yet unclassified' }
GTOProxyRegistration class >> subscribe: aGTOChatter on: anAnnouncer [ 
	self uniqueInstance subscribe: aGTOChatter on: anAnnouncer 
]

{ #category : #accessing }
GTOProxyRegistration class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'as yet unclassified' }
GTOProxyRegistration class >> unsubscribe: aGTOChatter on: anAnnouncer [
	self uniqueInstance unsubscribe: aGTOChatter on: anAnnouncer
]

{ #category : #'as yet unclassified' }
GTOProxyRegistration >> subscribe: aGTOChatter on: anAnnouncer [ 
	anAnnouncer 
		when: GTOOnline 
		do: [ :announcement | aGTOChatter handleOnline: announcement ] 
		for: aGTOChatter
]

{ #category : #'as yet unclassified' }
GTOProxyRegistration >> unsubscribe: aGTOChatter on: anAnnouncerOrNil [
	anAnnouncerOrNil ifNil: [ ^ self ].
	anAnnouncerOrNil unsubscribe: aGTOChatter
]
