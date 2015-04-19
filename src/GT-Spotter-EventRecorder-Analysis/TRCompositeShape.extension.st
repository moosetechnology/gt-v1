Extension { #name : #TRCompositeShape }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
TRCompositeShape >> allVisibleColor: aColor [
	self shapes do: [ :aShape | 
		aShape color = Color transparent 
			ifFalse: [ aShape color: aColor ] ]
]
