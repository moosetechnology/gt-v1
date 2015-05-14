Class {
	#name : #GTAGroup,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #accessing }
GTAGroup >> duration [
	^ self end - self start
]

{ #category : #accessing }
GTAGroup >> end [
	^ self last end
]

{ #category : #printing }
GTAGroup >> humanReadablePrintString [
	"Return a String with a human readable representation of me"
	^ String streamContents: [ :out | 
		self printHumanReadableOn: out ]
]

{ #category : #printing }
GTAGroup >> printHumanReadableOn: aStream [
	| duration |
	aStream 
		print: self size; 
		nextPutAll: ' events from '; 
		print: self start asDate; 
		cr;
		nextPutAll: ' during '. 
	duration := self duration.
	self duration > 1 second ifTrue: [ duration := self duration truncateTo: 1 milliseconds ].
	self duration > 1 minute ifTrue: [ duration := self duration truncateTo: 1 second ].
	self duration > 1 hour ifTrue: [ duration := self duration truncateTo: 1 minute ].
	self duration > 1 day ifTrue: [ duration := self duration truncateTo: 1 hour ].
	duration printHumanReadableOn: aStream
]

{ #category : #accessing }
GTAGroup >> start [
	^ self first start
]

{ #category : #'gt-inspector-extension' }
GTAGroup >> timelineView2 [
	| builder minTime |
	builder := RTTimeLine new.
	minTime := self start asUnixTime.
	self reverseWithIndexDo: [ :eachSession :index | | entry |
		entry := GTATimeLineEntry new.
		entry 
			identifier: 1;
			computer: eachSession computer;
			group: eachSession;
			start: eachSession start asUnixTime - minTime;
			end: eachSession end asUnixTime - minTime.
		builder addEntry: entry.
	 ].
	builder axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :unixTime | (DateAndTime fromUnixTime: unixTime + minTime) asDate ].
	builder axisY noLabel.
	builder interaction popup text: #humanReadablePrintString.
	builder shape color: (RTMultiLinearColorForIdentity new 
							command: #identifier; 
							objects: (1 to: self size);
							yourself).
	^ builder 
]
