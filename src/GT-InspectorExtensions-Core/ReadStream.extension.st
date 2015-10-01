Extension { #name : #ReadStream }

{ #category : #'*GT-InspectorExtensions-Core' }
ReadStream class >> gtExampleReadStream [
	<gtExample: 'Stream'>
	^ 'GTInspector' readStream
]

{ #category : #'*GT-InspectorExtensions-Core' }
ReadStream class >> gtExampleReadStreamAtEnd [
	<gtExample: 'Stream at end'>
	^ 'GTInspector' readStream 
		upToEnd;
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
ReadStream class >> gtExampleReadStreamEmpty [
	<gtExample: 'Empty stream'>
	^ '' readStream
]

{ #category : #'*GT-InspectorExtensions-Core' }
ReadStream class >> gtExampleReadStreamWithPosition [
	<gtExample: 'Stream with position'>
	^ 'GTInspector' readStream 
		next; 
		next; 
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
ReadStream >> gtInspectorStreamStateIn: composite [
	<gtInspectorPresentationOrder: 50>
	(composite wrapper with: [ :w | 
		w title: 'Contents'.
		w show: [ :a | 
			a text
				display: [ self contents ];
				initialize: [ :aPresentation | 
					aPresentation selectionInterval: (1 to: self position) ] ] ])
		startOn: self
]
