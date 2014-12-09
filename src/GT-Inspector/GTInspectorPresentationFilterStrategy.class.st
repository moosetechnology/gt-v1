Class {
	#name : #GTInspectorPresentationFilterStrategy,
	#superclass : #Object,
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTInspectorPresentationFilterStrategy >> changeFilterRequestFor: aGTInspector [

	self subclassResponsibility
]

{ #category : #testing }
GTInspectorPresentationFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	self subclassResponsibility
]
