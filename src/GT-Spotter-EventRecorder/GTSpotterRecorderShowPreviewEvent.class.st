"
A GTSpotterRecorderShowPreviewEvent models the action of explicitly closing the preview of an object.

"
Class {
	#name : #GTSpotterRecorderShowPreviewEvent,
	#superclass : #GTSpotterRecorderEvent,
	#category : #'GT-Spotter-EventRecorder-Events'
}

{ #category : #testing }
GTSpotterRecorderShowPreviewEvent >> isShowPreview [
	^ true
]

{ #category : #visitor }
GTSpotterRecorderShowPreviewEvent >> visit: aVisitor [
	^ aVisitor acceptShowPreviewEvent: self
]
