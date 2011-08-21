Class {
	#name : #GTUnprintableObjectTest,
	#superclass : #GLMMorphicTest,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTUnprintableObjectTest >> testInspectDoesNotCrash [
	window := GTInspector openOn: GTUnprintableObject new 
]
