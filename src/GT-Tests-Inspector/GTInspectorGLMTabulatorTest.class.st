Class {
	#name : #GTInspectorGLMTabulatorTest,
	#superclass : #GTInspectorSmokeTest,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorGLMTabulatorTest >> objectToTest [ 
	^ GLMTabulator new 
		with: [ :t |
			t column: #one.
			t transmit to: #one; andShow: [ :a | a text] ];
		startOn: 42
]
