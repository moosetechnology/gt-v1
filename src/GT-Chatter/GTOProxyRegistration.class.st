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

{ #category : #subscription }
GTOProxyRegistration class >> subscribe: aGTOChatter on: anAnnouncer [ 
	self uniqueInstance subscribe: aGTOChatter on: anAnnouncer 
]

{ #category : #accessing }
GTOProxyRegistration class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #subscription }
GTOProxyRegistration class >> unsubscribe: aGTOChatter on: anAnnouncer [
	self uniqueInstance unsubscribe: aGTOChatter on: anAnnouncer
]

{ #category : #subscription }
GTOProxyRegistration >> subscribe: aGTOChatter on: anAnnouncer [ 
	anAnnouncer 
		when: GTOOnline 
			do: [ :announcement | aGTOChatter handleOnline: announcement ] 
			for: aGTOChatter;
		when: GTOTextMessage
			do: [ :announcement | aGTOChatter handleTextMessage: announcement ] 
			for: aGTOChatter

]

{ #category : #subscription }
GTOProxyRegistration >> unsubscribe: aGTOChatter on: anAnnouncerOrNil [
	anAnnouncerOrNil ifNil: [ ^ self ].
	anAnnouncerOrNil unsubscribe: aGTOChatter
]
