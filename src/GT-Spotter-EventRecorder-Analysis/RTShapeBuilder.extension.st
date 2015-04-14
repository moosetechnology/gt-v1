Extension { #name : #RTShapeBuilder }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> event [
	self shape: GTATimelineIconBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> oblique [
	self shape: GTATimelineIconBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> orthogonal [
	self shape: GTATimelineOrthogonalIconBuilder new
]
