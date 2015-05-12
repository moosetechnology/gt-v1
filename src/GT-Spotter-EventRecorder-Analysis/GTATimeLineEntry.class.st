Class {
	#name : #GTATimeLineEntry,
	#superclass : #RTTimeLineEntry,
	#instVars : [
		'computer',
		'group'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #accessing }
GTATimeLineEntry >> computer [
	^ computer
]

{ #category : #accessing }
GTATimeLineEntry >> computer: anObject [
	computer := anObject
]

{ #category : #accessing }
GTATimeLineEntry >> group [
	^ group
]

{ #category : #accessing }
GTATimeLineEntry >> group: anObject [
	group := anObject
]

{ #category : #printing }
GTATimeLineEntry >> humanReadablePrintString [
	"Return a String with a human readable representation of me"
	^ String streamContents: [ :out | 
		self printHumanReadableOn: out ]
]

{ #category : #printing }
GTATimeLineEntry >> printHumanReadableOn: aStream [
	self group printHumanReadableOn: aStream
]
