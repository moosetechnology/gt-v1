Class {
	#name : #GTAOrthogonalIconBuilderTest,
	#superclass : #GTAAbstractIconBuilderTest,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #running }
GTAOrthogonalIconBuilderTest >> initializeBuilder [	
	builder := GTAOrthogonalIconBuilder new
]

{ #category : #running }
GTAOrthogonalIconBuilderTest >> lineWithQueries [
	^ RTGroup
		with:
			(self
				newElementForEvent:
					(GTSpotterRecorderContextChangedEvent new
						currentTextInfoFromString: 'query';
						yourself))
		with:
			(self
				newElementForEvent:
					(GTSpotterRecorderContextChangedEvent new
						currentTextInfoFromString: 'query2 longer-query';
						yourself))
		with:
			(self
				newElementForEvent:
					(GTSpotterRecorderContextChangedEvent new
						currentTextInfoFromString: 'query33 #c';
						yourself))
]

{ #category : #running }
GTAOrthogonalIconBuilderTest >> lineWithUpSelections [
	| selection2 session1 selection1 |
	selection1 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowUp;
		infoAt: #elementName put: 1;
		yourself.
	selection2 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowUp;
		infoAt: #elementName put: 1;
		yourself.
	session1 := GTASession with: selection1 with: selection2.
	selection1 previousSelection: selection1.
	selection2 previousSelection: selection1.
	selection1 session: session1.
	selection2 session: session1.
	^ RTGroup 
		with: (self newElementForEvent: selection1)
		with: (self newElementForEvent: selection2)

]

{ #category : #running }
GTAOrthogonalIconBuilderTest >> testShapesForVissoft2015Paper [
	| view line1 line2 line3 line4 line5 line6 |
	view := RTView new.
	line1 := RTGroup
		with: (self newElementForEventClass: GTSpotterRecorderActOnEvent)
		with: (self newElementForEventClass: GTSpotterRecorderExitAnnouncementEvent).
	line2 := RTGroup
		with: (self newElementForEventClass: GTSpotterRecorderShowPreviewEvent)
		with: (self newElementForEventClass: GTSpotterRecorderHidePreviewEvent).
	line3 := RTGroup
		with: (self newElementForEventClass: GTSpotterRecorderDiveInElementEvent)
		with: (self newElementForEventClass: GTSpotterRecorderDiveInCategoryEvent)
		with: (self newElementForEventClass: GTSpotterRecorderDiveOutEvent).
	line4 := self lineWithQueries.
	line5 := RTGroup with: (self newElementForEventClass: GTSpotterRecorderSearchFinishedEvent).
	line6 := self lineWithUpSelections.
	view
		addAll: line1;
		addAll: line2;
		addAll: line3;
		addAll: line4;
		addAll: line5;
		addAll: line6.
	RTHorizontalLineLayout
		on: line1;
		on: line2;
		on: line3;
		on: line4;
		on: line5;
		on: line6.
	RTVerticalLineLayout
		on:
			(RTGroup
				with: line1
				with: line2
				with: line3
				with: line4
				with: line5
				with: line6).
	view elements @ RTDraggable.
	view elements do: [ :eachElement | eachElement trachelShape allVisibleColor: Color black ].
	view inspect
]
