Class {
	#name : #GTExampleNautilusNotifications,
	#superclass : #Object,
	#classInstVars : [
		'notifying'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleNautilusNotifications class >> changed: anAnnouncement [
	| examples |
	examples := Smalltalk gtExamplesContained select: [ :example | example hasProblems ].
	examples size > 4 ifTrue: [ ^ self notifyExamples: examples ].
	examples do: [ :example | self notifyExample: example ]
]

{ #category : #private }
GTExampleNautilusNotifications class >> example: aGTExample event: anEvent from: anEventSource [
	GTExampleNavigation browse: 'Examples with Problems' examples: { aGTExample }
]

{ #category : #private }
GTExampleNautilusNotifications class >> examples: aCollection event: anEvent from: anEventSource [
	GTExampleNavigation browse: 'Examples with Problems' examples: aCollection
]

{ #category : #private }
GTExampleNautilusNotifications class >> notifyExample: aGTExample [
	UIManager default 
		inform: 'Example ', aGTExample gtDisplayString , ' is invalid' , String cr, ' (click to browse)'
		send: #example:event:from:
		to: self
		withValue: aGTExample
]

{ #category : #private }
GTExampleNautilusNotifications class >> notifyExamples: aCollection [
	UIManager default 
		inform: 'There are ' , aCollection size asString , ' invalid examples' , String cr, ' (click to browse)'
		send: #examples:event:from:
		to: self
		withValue: aCollection
]

{ #category : #private }
GTExampleNautilusNotifications class >> registerInterestToSystemAnnouncement [
	<systemEventRegistration>
	
	self restart
]

{ #category : #actions }
GTExampleNautilusNotifications class >> restart [
	" self restart "
	self stop.
	self start.
]

{ #category : #actions }
GTExampleNautilusNotifications class >> start [
	" self start "
	notifying == true ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		when: GTExamplesModifiedAnnouncement send: #changed: to: self.
	notifying := true
]

{ #category : #actions }
GTExampleNautilusNotifications class >> stop [
	" self stop "
	SystemAnnouncer uniqueInstance unsubscribeThoroughly: self.
	Announcer allSubInstances do: [ :each | each unsubscribeThoroughly: self ].
	notifying := false
]
