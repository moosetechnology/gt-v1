Class {
	#name : #GTEventCollector,
	#superclass : #Object,
	#instVars : [
		'recordedData'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #initialization }
GTEventCollector >> initialize [
	super initialize.	
	recordedData := WaitfreeQueue new.

]
