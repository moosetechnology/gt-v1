Class {
	#name : #GTATimelineOrthogonalIconBuilder,
	#superclass : #GTATimelineIconBuilder,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #visitor }
GTATimelineOrthogonalIconBuilder >> visitDiveInCategoryEvent: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -3 @ -2. 3 @ -2. 3 @ 5. 2 @ 5. 2 @ 1. 
								-3 @ 1. -3 @ 0. 2 @ 0. 2 @ -1. -3 @ -1 };
				yourself.
	s2 := RTBox new width: 6; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #visitor }
GTATimelineOrthogonalIconBuilder >> visitDiveInElementEvent: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -3 @ -1. 3 @ -1. 3 @ 5. 2 @ 5. 2 @ 0. -3 @ 0 };
				yourself.
	s2 := RTBox new width: 6; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]

{ #category : #visitor }
GTATimelineOrthogonalIconBuilder >> visitDiveOutEvent: aGTSpotterEvent [ 
	| s1 s2 c |
	s1 := RTPolygon new 
				vertices: { -3 @ 1. 3 @ 1. 3 @ -5. 2 @ -5. 2 @ 0. -3 @ 0 };
				yourself.
	s2 := RTBox new width: 6; height: 4; color: Color transparent; yourself.
	c := RTCompositeShape new.
	c add: s2; add: s1; vertical.
	^ c
]
