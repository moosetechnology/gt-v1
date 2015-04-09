Class {
	#name : #GTSpotterPrintDateAndTime,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Support'
}

{ #category : #api }
GTSpotterPrintDateAndTime class >> yyyyMmDdAndHhMmSs: aDateAndTimeOrZero [
	"Returns YYYY-MM-DD, HH:MM:SS in UTC time."
	aDateAndTimeOrZero = 0 ifTrue: [ ^ 'unknown' ].
	^ String streamContents: [ :aStream |
		aDateAndTimeOrZero asUTC printYMDOn: aStream.
		aStream nextPutAll: ', '.
		aDateAndTimeOrZero asUTC printHMSOn: aStream ] 
]
