Class {
	#name : #GTStonPacking,
	#superclass : #GTEventPacking,
	#category : #'GT-EventRecorder-Core'
}

{ #category : #private }
GTStonPacking >> materialize: anObject [
	^ STON fromString: anObject
]

{ #category : #private }
GTStonPacking >> serialize: anObject [
	^ STON toStringPretty: anObject
]
