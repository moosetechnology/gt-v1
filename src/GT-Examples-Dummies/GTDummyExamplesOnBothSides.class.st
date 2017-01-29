Class {
	#name : #GTDummyExamplesOnBothSides,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #examples }
GTDummyExamplesOnBothSides class >> classSideA [
	<gtExample>
	^ 2
]

{ #category : #examples }
GTDummyExamplesOnBothSides class >> classSideB: a [
	<gtExample>
	<dependsOn: #classSideA>
	self assert: a = 2.
	^ a + 2
]

{ #category : #examples }
GTDummyExamplesOnBothSides class >> classSideC: a classSideC: b [
	<gtExample>
	<dependsOn: #classSideA>
	<dependsOnClass: #'GTDummyExamplesOnBothSides class' selector: #classSideB:>
	self assert: a = 2.
	self assert: b = 4.
	^ a + b - 3
]

{ #category : #examples }
GTDummyExamplesOnBothSides class >> classSideD: instanceSideC [
	<gtExample>
	<dependsOnClass: #GTDummyExamplesOnBothSides selector: #c:c:>
	self assert: instanceSideC = 9.
	^ instanceSideC
]

{ #category : #examples }
GTDummyExamplesOnBothSides >> a [
	<gtExample>
	^ 1
]

{ #category : #examples }
GTDummyExamplesOnBothSides >> b: a [
	<gtExample>
	<dependsOn: #a>
	self assert: a = 1.
	^ a + 1
]

{ #category : #examples }
GTDummyExamplesOnBothSides >> c: a c: b [
	<gtExample>
	<dependsOn: #a>
	<dependsOnClass: #GTDummyExamplesOnBothSides selector: #b:>
	self assert: a = 1.
	self assert: b = 2.
	^ a + b + 6
]

{ #category : #examples }
GTDummyExamplesOnBothSides >> d: classSideC [
	<gtExample>
	<dependsOnClass: #'GTDummyExamplesOnBothSides class' selector: #classSideC:classSideC:>
	self assert: classSideC = 3.
	^ classSideC
]
