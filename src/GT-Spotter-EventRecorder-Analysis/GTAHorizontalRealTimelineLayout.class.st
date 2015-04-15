Class {
	#name : #GTAHorizontalRealTimelineLayout,
	#superclass : #GTAHorizontalDivingLineLayout,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #hook }
GTAHorizontalRealTimelineLayout >> doExecute: elements [
	| offset previousElement right left min |
	min := elements detectMin: [ :each | each position x ].
	elements do: [ :each | each translateTo: (min position x) @ (each position y) ].
	RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :eachEvent | self xFor: eachEvent ] min: 0 max: 500.
	self diveElements: elements.
	previousElement := elements first.
	offset := 0.
	elements allButFirstDo: [ :element |
		right := previousElement encompassingRectangle right.
		left := element encompassingRectangle left.
		right > left
			ifTrue: [ offset := (right - left) rounded + 3 ]
			"ifFalse: [ offset := 0 ]".
		element translateBy: (offset @ 0).
		previousElement := element.
	 ].
]

{ #category : #accessing }
GTAHorizontalRealTimelineLayout >> xFor: aSpotterEvent [
	| currentTimeStamp index events nextTimestamp duration relIndex relDuration xPosition |
	aSpotterEvent relativeXPosition ifNotNil: [ :value | ^ value ].
	currentTimeStamp := aSpotterEvent dateAndTimeWithFixedTimeZone.
	index := aSpotterEvent myPositionAmongSameTimeEvents - 1.
	events := aSpotterEvent sameTimeEvents size.
	events < 2 ifTrue: [ 
		aSpotterEvent relativeXPosition: currentTimeStamp. 
		^ currentTimeStamp ].
	relIndex := index / events.
	nextTimestamp := aSpotterEvent followingDifferentTime.
	duration := nextTimestamp - currentTimeStamp / 2.
	relDuration := duration * relIndex.
	xPosition := currentTimeStamp + relDuration.
	aSpotterEvent relativeXPosition: xPosition.
	^ xPosition
]
