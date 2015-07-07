"
I am the root class for filters that decide what processors can be loaded in a step. I have no conection whatsoever with the GTFilter hierarchy.

Subclasses need to implement #shouldEnableProcessorsCreateBy: to indicate whether or not a given processor should be enabled.
"
Class {
	#name : #GTSpotterProcessorFilter,
	#superclass : #Object,
	#category : #'GT-Spotter-Model'
}

{ #category : #testing }
GTSpotterProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [
	"Return weather or not the processor created by the given method
	should be enabled in Spotter."
	
	self subclassResponsibility
]
