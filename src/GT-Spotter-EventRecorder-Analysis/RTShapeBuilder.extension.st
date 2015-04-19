Extension { #name : #RTShapeBuilder }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> event [
	self shape: GTAIconBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> flexibleResultShapes [
	self shape: GTAFlexibleResultIconBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> oblique [
	self shape: GTAIconBuilder new
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
RTShapeBuilder >> orthogonal [
	self shape: GTAOrthogonalIconBuilder new
]
