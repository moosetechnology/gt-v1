Class {
	#name : #RTExampleFactory,
	#superclass : #GTExampleFactory,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-defaults' }
RTExampleFactory >> defaultExampleClass [
	^ RTExampleSelection
]

{ #category : #testing }
RTExampleFactory >> isExampleMethod: aCompiledMethod [
	^ (super isExampleMethod: aCompiledMethod)
		or: [ self isOldStyleRTExampleMethod: aCompiledMethod ]
]

{ #category : #testing }
RTExampleFactory >> isOldStyleRTExampleMethod: aCompiledMethod [
	^ (aCompiledMethod selector beginsWith: 'example')
		and: [ (aCompiledMethod selector endsWith: 'Icon') not ]
]
