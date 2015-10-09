Class {
	#name : #GTEventBundle,
	#superclass : #Object,
	#instVars : [
		'url',
		'data'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #accessing }
GTEventBundle >> data [
	^ data
]

{ #category : #accessing }
GTEventBundle >> data: anObject [
	data := anObject
]

{ #category : #accessing }
GTEventBundle >> url [
	^ url
]

{ #category : #accessing }
GTEventBundle >> url: anObject [
	url := anObject
]
