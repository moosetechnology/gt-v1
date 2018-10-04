Class {
	#name : #GTExampleMethodTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #utils }
GTExampleMethodTest >> assert: aGTExampleMethod class: aClass className: aName meta: meta selector: aSelector [ 

	self assert: aGTExampleMethod methodClass == aClass.
	self assert: aGTExampleMethod methodClassName = aName.
	self assert: aGTExampleMethod meta = meta.
	self assert: aGTExampleMethod selector = aSelector.
	
	self assert: aGTExampleMethod exists.
	self assert: aGTExampleMethod isValid.
	
	self shouldnt: [ aGTExampleMethod resetStub ] raise: Exception.
	self assert: (aGTExampleMethod instVarNamed: 'methodClass') isNil.
	
	self assert: aGTExampleMethod methodClass == aClass.
	self assert: aGTExampleMethod methodClassName = aName.
	self assert: aGTExampleMethod meta = meta.
	self assert: aGTExampleMethod selector = aSelector.
	
	self assert: aGTExampleMethod exists.
	self assert: aGTExampleMethod isValid.
]

{ #category : #tests }
GTExampleMethodTest >> testFromClassNamedSelector [
	| exampleMethod |
	exampleMethod := GTExampleMethod fromClassNamed: #GTExampleMethod selector: #isValid.
	self assert: exampleMethod class: GTExampleMethod className: #GTExampleMethod meta: false selector: #isValid.
	
	exampleMethod := GTExampleMethod fromClassNamed: 'GTExampleMethod' selector: #isValid.
	self assert: exampleMethod class: GTExampleMethod className: #GTExampleMethod meta: false selector: #isValid.
	
	exampleMethod := GTExampleMethod fromClassNamed: #GTExampleMethod selector: #isValid.
	self assert: exampleMethod class: GTExampleMethod className: 'GTExampleMethod' meta: false selector: #isValid.
]

{ #category : #tests }
GTExampleMethodTest >> testFromClassSelector [
	| exampleMethod |
	exampleMethod := GTExampleMethod fromClass: GTExampleMethod selector: #hasExample.
	self assert: exampleMethod class: GTExampleMethod className: #GTExampleMethod meta: false selector: #hasExample.
	self assert: exampleMethod class: GTExampleMethod className: 'GTExampleMethod' meta: false selector: #hasExample.
]
