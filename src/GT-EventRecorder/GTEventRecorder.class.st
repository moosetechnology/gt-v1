Class {
	#name : #GTEventRecorder,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'process',
		'deliveryDelay',
		'deliveryQueue',
		'shouldDeliver'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #initialization }
GTEventRecorder >> initialize [
	super initialize.
	deliveryQueue := WaitfreeQueue new.
	mutex := Mutex new.
]
