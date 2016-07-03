Class {
	#name : #RTExampleFactory,
	#superclass : #GTAbstractExampleFactory,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-defaults' }
RTExampleFactory >> defaultExampleClass [
	^ RTExampleSelection
]

{ #category : #testing }
RTExampleFactory >> isExampleMethod: aCompiledMethod [
	^ (self isGTExampleMethod: aCompiledMethod)
		or: [ self isOldStyleRTExampleMethod: aCompiledMethod ]
]

{ #category : #testing }
RTExampleFactory >> isOldStyleRTExampleMethod: aCompiledMethod [
	^ (aCompiledMethod selector beginsWith: 'example')
		and: [ (aCompiledMethod selector endsWith: 'Icon') not ]
]
