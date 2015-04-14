Class {
	#name : #GTAHorizontalTimelineLayout,
	#superclass : #GTAHorizontalDivingLineLayout,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #hook }
GTAHorizontalTimelineLayout >> doExecute: elements [
	| offset previousElement right left |
	RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :eachEvent | self xFor: eachEvent ] min: 0 max: 500.
	self diveElements: elements.
	previousElement := elements first.
	offset := 0.
	elements allButFirstDo: [ :element |
		right := previousElement encompassingRectangle right.
		left := element encompassingRectangle left.
		self halt.
		right > left
			ifTrue: [ offset := offset + (right - left) rounded ].
		element translateBy: (offset @ 0).
		previousElement := element.
	 ].
]

{ #category : #accessing }
GTAHorizontalTimelineLayout >> xFor: aSpotterEvent [
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
