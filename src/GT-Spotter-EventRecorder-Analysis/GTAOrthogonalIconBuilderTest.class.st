Class {
	#name : #GTAOrthogonalIconBuilderTest,
	#superclass : #GTAAbstractIconBuilderTest,
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #running }
GTAOrthogonalIconBuilderTest >> initializeBuilder [	
	builder := GTAOrthogonalSymbolBuilder new
]

{ #category : #running }
GTAOrthogonalIconBuilderTest >> lineWithDownSelectionsFrom: aGTAComputers [
	| selection2 session1 selection1 selection3 |
	selection1 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowDown;
		infoAt: #elementName put: 1;
		yourself.
	selection2 := GTSpotterRecorderSelectedCandidateChangedEvent new
		infoAt: #eventType put: #keyPressedArrowDown;
		infoAt: #elementName put: 1;
		yourself.
	session1 := GTASession with: selection1 with: selection2.
	selection1 previousSelection: selection1.
	selection2 previousSelection: selection1.
	selection1 session: session1.
	selection2 session: session1.
	selection3 := aGTAComputers first second at: 51.
	^ RTGroup 
		with: (self newElementForEvent: selection1)
		with: (self newElementForEvent: selection2)
		with: (self newElementForEvent: selection3)

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
GTAOrthogonalIconBuilderTest >> lineWithUpSelectionsFrom: aGTAComputers [
	| selection2 session1 selection1 selection3 |
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
	selection3 := aGTAComputers first second at: 47.
	^ RTGroup 
		with: (self newElementForEvent: selection1)
		with: (self newElementForEvent: selection2)
		with: (self newElementForEvent: selection3)

]

{ #category : #running }
GTAOrthogonalIconBuilderTest >> testShapesForVissoft2015Paper [
	| view line1 line2 line3 line4 line5 line6 computers line7 |
	view := RTView new.
	computers := GTASessionExamples computersFrom: #lotOfSelectionsDataSample.
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
	line6 := self lineWithUpSelectionsFrom: computers.
	line7 := self lineWithDownSelectionsFrom: computers.
	view
		addAll: line1;
		addAll: line2;
		addAll: line3;
		addAll: line4;
		addAll: line5;
		addAll: line6;
		addAll: line7.
	RTHorizontalLineLayout
		on: line1;
		on: line2;
		on: line3;
		on: line4;
		on: line5;
		on: line6;
		on: line7.
	RTVerticalLineLayout
		on:
			(RTGroup new
				add: line1;
				add: line2;
				add: line3;
				add: line4;
				add: line5;
				add: line6;
				add: line7;
				yourself).
	view elements @ RTDraggable.
	view elements do: [ :eachElement | eachElement trachelShape allVisibleColor: Color black ].
	view inspect
]
