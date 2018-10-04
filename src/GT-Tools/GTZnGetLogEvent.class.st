Class {
	#name : #GTZnGetLogEvent,
	#superclass : #ZnLogEvent,
	#instVars : [
		'url',
		'code',
		'dimension',
		'duration'
	],
	#category : #'GT-Tools-Prototypes'
}

{ #category : #accessing }
GTZnGetLogEvent >> code [
	^ code
]

{ #category : #accessing }
GTZnGetLogEvent >> code: anObject [
	code := anObject
]

{ #category : #accessing }
GTZnGetLogEvent >> dimension [
	^ dimension
]

{ #category : #accessing }
GTZnGetLogEvent >> dimension: anObject [
	dimension := anObject
]

{ #category : #accessing }
GTZnGetLogEvent >> duration [
	^ duration
]

{ #category : #accessing }
GTZnGetLogEvent >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
GTZnGetLogEvent >> url [
	^ url
]

{ #category : #accessing }
GTZnGetLogEvent >> url: anObject [
	url := anObject
]
