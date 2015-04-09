Class {
	#name : #GTSpotterEventIcons,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Support'
}

{ #category : #icons }
GTSpotterEventIcons class >> actOnIcon [
	^ Smalltalk ui icons glamorousPlay
]

{ #category : #icons }
GTSpotterEventIcons class >> contextChangedIcon [
	^ Smalltalk ui icons glamorousEdit  
]

{ #category : #icons }
GTSpotterEventIcons class >> diveInCategoryIcon [
	^ Smalltalk ui icons glamorousDiveAllRightIcon  
]

{ #category : #icons }
GTSpotterEventIcons class >> diveInElementIcon [
	^ Smalltalk ui icons glamorousDiveRightIcon  
]

{ #category : #icons }
GTSpotterEventIcons class >> diveOutIcon [
	^ Smalltalk ui icons glamorousLeft  
]

{ #category : #icons }
GTSpotterEventIcons class >> exitIcon [
	^ Smalltalk ui icons glamorousClose  
]

{ #category : #icons }
GTSpotterEventIcons class >> hidePreviewIcon [
	^ Smalltalk ui icons glamorousZoomOut
]

{ #category : #icons }
GTSpotterEventIcons class >> noIcon [
	^ Smalltalk ui icons protocolNoneIcon
]

{ #category : #icons }
GTSpotterEventIcons class >> selectedCandidateChangedIcon [
	^ Smalltalk ui icons glamorousGrayCircle  
]

{ #category : #icons }
GTSpotterEventIcons class >> showPreviewIcon [
	^ Smalltalk ui icons glamorousZoomIn
]
