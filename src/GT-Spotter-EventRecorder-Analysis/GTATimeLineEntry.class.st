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

{ #category : #'gt-inspector-extension' }
GTATimeLineEntry >> gtInspectorTimelineView2In: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Timeline 2';
		initializeView: [ self timelineView2 ]
		
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

{ #category : #accessing }
GTATimeLineEntry >> startUnixTime [
	^ self group start asUnixTime
]

{ #category : #'gt-inspector-extension' }
GTATimeLineEntry >> timelineView2 [
	^ self group timelineView2
]
