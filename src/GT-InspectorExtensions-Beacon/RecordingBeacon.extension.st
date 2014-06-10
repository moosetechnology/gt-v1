Extension { #name : #RecordingBeacon }

{ #category : #'*GT-InspectorExtensions-Beacon' }
RecordingBeacon classSide >> gtExampleInstanceUsage [
	<gtExample>
	^ RecordingBeacon new 
		runDuring: [ 
			MessageSignal log: 'This is a message'.
			MessageSignal log: 'This is another message'. ]	
]

{ #category : #'*GT-InspectorExtensions-Beacon' }
RecordingBeacon >> gtInspectorRecordingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Recordings';
		display: [ self recordings reverse ];
		format: #gtDisplayString;
		showOnly: 50;
		updateOn: Announcement from: [ self announcer ]
]
