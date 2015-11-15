Class {
	#name : #GTERServerPutHandler,
	#superclass : #Object,
	#instVars : [
		'storage'
	],
	#category : #'GT-EventRecorder-Server-Core'
}

{ #category : #accessing }
GTERServerPutHandler >> storage [
	^ storage
]

{ #category : #accessing }
GTERServerPutHandler >> storage: anObject [
	storage := anObject
]

{ #category : #'as yet unclassified' }
GTERServerPutHandler >> value: aZnRequest value: aZnResponse [
	aZnResponse entity: (ZnStringEntity html: '<h1>hello server</h1>')
]
