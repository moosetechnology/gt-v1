Class {
	#name : #GTInspectorSelfNode,
	#superclass : #GTInspectorVariableNode,
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTInspectorSelfNode >> key [
	^ 'self'
]

{ #category : #accessing }
GTInspectorSelfNode >> value [
	^ self hostObject
]
