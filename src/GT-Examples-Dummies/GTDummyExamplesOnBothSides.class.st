Class {
	#name : #GTDummyExamplesOnBothSides,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-4'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides class >> classSideA [
	<gtExample>
	^ 2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides class >> classSideB: a [
	<gtExample>
	<depends: #classSideA>
	self assert: a = 2.
	^ a + 2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides class >> classSideC: a classSideC: b [
	<gtExample>
	<depends: #classSideA>
	<dependsMetaClass: #GTDummyExamplesOnBothSides selector: #classSideB:>
	self assert: a = 2.
	self assert: b = 4.
	^ a + b - 3
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides class >> classSideD: instanceSideC [
	<gtExample>
	<dependsClass: #GTDummyExamplesOnBothSides selector: #c:c:>
	self assert: instanceSideC = 9.
	^ instanceSideC
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides >> a [
	<gtExample>
	^ 1
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides >> b: a [
	<gtExample>
	<depends: #a>
	self assert: a = 1.
	^ a + 1
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides >> c: a c: b [
	<gtExample>
	<depends: #a>
	<dependsClass: #GTDummyExamplesOnBothSides selector: #b:>
	self assert: a = 1.
	self assert: b = 2.
	^ a + b + 6
]

{ #category : #'as yet unclassified' }
GTDummyExamplesOnBothSides >> d: classSideC [
	<gtExample>
	<dependsMetaClass: #GTDummyExamplesOnBothSides selector: #classSideC:classSideC:>
	self assert: classSideC = 3.
	^ classSideC
]
