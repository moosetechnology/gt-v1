"
I associate a piece of data that should be delivered to a remote server with the url of that remote server.

Instances of me should be sent to a GTEventDelivery.


"
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
