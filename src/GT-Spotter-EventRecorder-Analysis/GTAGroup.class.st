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
GTAGroup >> printHumanReadableOn: aStream [
	aStream 
		print: self size; 
		nextPutAll: ' events from '; 
		print: self start asDate; 
		nextPutAll: ' during '. 
	self duration printHumanReadableOn: aStream
]

{ #category : #accessing }
GTAGroup >> start [
	^ self first start
]

{ #category : #'as yet unclassified' }
GTAGroup >> timelineView2 [
	| builder minTime dataSetBuilder |
	builder := RTTimeLine new.
	minTime := self start asUnixTime.
	dataSetBuilder := GTARoughDataSetBuilder new
		gap: self duration / 48;
		setSessionComparator;
		yourself.
	self reverseWithIndexDo: [ :eachComputer :index | 
		dataSetBuilder objects: eachComputer; build.
		dataSetBuilder groups do: [ :eachGroup | | entry |
			entry := GTATimeLineEntry new.
			entry 
				identifier: index;
				computer: eachComputer;
				group: eachGroup;
				start: eachGroup start asUnixTime - minTime;
				end: eachGroup end asUnixTime - minTime.
			builder addEntry: entry.
		].
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
