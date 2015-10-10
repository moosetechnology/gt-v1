Class {
	#name : #GlobalIdentifierMerger,
	#superclass : #Object,
	#instVars : [
		'existing',
		'stored'
	],
	#category : #'GT-EventRecorder-Identifiers'
}

{ #category : #accessing }
GlobalIdentifierMerger >> existing [
	^ existing
]

{ #category : #accessing }
GlobalIdentifierMerger >> existing: anObject [
	existing := anObject
]

{ #category : #actions }
GlobalIdentifierMerger >> merge [
	"If UUIDs are different, it is likely different user and we should use
	localy stored settings. If the UUIDs are same, we keep settings of the image.
	
	It returns true if existing dictionary is changed."
	^ ((existing at: #computerUUID ifAbsent: nil) = (stored at: #computerUUID ifAbsent: nil)
		or: [ (stored includesKey: #computerUUID) not ])
			ifTrue: [ self mergeSameComputer ]
			ifFalse: [ self mergeDifferentComputer ]
]

{ #category : #actions }
GlobalIdentifierMerger >> mergeDifferentComputer [
	"It puts all stored values into existing dictionary."
	stored keysAndValuesDo: [ :eachKey :eachValue |
		existing at: eachKey put: eachValue ].
	^ true
]

{ #category : #actions }
GlobalIdentifierMerger >> mergeSameComputer [
	"It add into existing dictionary items that are included in the stored dictionary,
	but are missing in the existing dictionary. Useful when a new version
	adds new configuration values that should be saved too.
	
	It returns true if existing dictionary is changed."
	| difference |
	difference := stored keys difference: existing keys.
	difference ifEmpty: [ ^ false ].
	difference do: [ :eachKey |
		existing at: eachKey put: (stored at: eachKey) ].
	^ true
]

{ #category : #accessing }
GlobalIdentifierMerger >> stored [
	^ stored
]

{ #category : #accessing }
GlobalIdentifierMerger >> stored: anObject [
	stored := anObject
]
