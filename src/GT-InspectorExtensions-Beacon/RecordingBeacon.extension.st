Extension { #name : #RecordingBeacon }

{ #category : #'*GT-InspectorExtensions-Beacon' }
RecordingBeacon classSide >> gtExampleInstanceUsage [
	<gtExample>
	^ RecordingBeacon new 
		runDuring: [ 
			StringSignal log: 'This is a message'.
			StringSignal log: 'This is another message'. ]	
]

{ #category : #'*GT-InspectorExtensions-Beacon' }
RecordingBeacon >> gtInspectorRecordingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite table 
		title: 'Recordings';
		display: [ self recordings reverse ];
		column: 'Timestamp' evaluated: [ :each | each timestamp asString ];
		column: 'Type' evaluated: [ :each | each class name ];
		column: 'Contents' evaluated: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ];
		showOnly: 50;
		updateOn: Announcement from: [ self announcer ]
]
