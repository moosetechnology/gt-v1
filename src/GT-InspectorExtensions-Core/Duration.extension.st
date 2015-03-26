Extension { #name : #Duration }

{ #category : #'*GT-InspectorExtensions-Core' }
Duration class >> exampleOneDay [
	<gtExample>
	^ self days: 1
]

{ #category : #'*GT-InspectorExtensions-Core' }
Duration class >> exampleOneHour [
	<gtExample>
	^ self hours: 1
]

{ #category : #'*GT-InspectorExtensions-Core' }
Duration class >> exampleOneMinute [
	<gtExample>
	^ self minutes: 1
]

{ #category : #'*GT-InspectorExtensions-Core' }
Duration >> gtInspectorDetailsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite table
		title: [ 'Details' ];
		display: [ 
					{'days' -> self days.
					'hours' -> self hours.
					'minutes' -> self minutes.
					'seconds' -> self seconds .
					'nanoseconds' -> self nanoSeconds } ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]
