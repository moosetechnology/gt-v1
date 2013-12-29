Class {
	#name : #GTDebuggerInspector,
	#superclass : #GTInspector,
	#category : #'GT-Debugger'
}

{ #category : #building }
GTDebuggerInspector >> compose [
	self finder with: [:browser | 
		browser fixedSizePanes: self class numberOfInspectorPanes.
		browser show: [ :a :each | 
			a dynamic display: [ :x | 
				GLMCompositePresentation new with: [:d | each gtDebuggerPresentationsIn: d ] ] ] ]
]

{ #category : #'as yet unclassified' }
GTDebuggerInspector >> showFirst: aBlock [

	self first showFirst: aBlock
]
